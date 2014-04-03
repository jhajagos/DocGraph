"""
Created on May 15, 2012

@author: Janos Hajagos, Ram Angara, Maruthi Deverenti

The strategy is to do several passes to update the latitude and longitude
starting with matched addresses, zip4, zip, city_state matched geocodes

We update records in the address table if the latitude is null

We are using ArcGIS to do the Geocoding and using the Address Locators that are part of Arclogistics

One of the issues that we have to deal with is that ArcGis cannot batch geoprocess millions of records.

"""


import csv
import math
import os
import pyodbc as odbc
import glob
import sys
import json

def logger(string_to_write=""):
    print(string_to_write)

workspace_path = "E:\\data\\shapefiles\\"
if "32 bit (Intel)" in sys.version:
    import arcgisscripting
    logger("Open GIS workspace")
    GP = arcgisscripting.create()
    GP.Workspace = workspace_path

locator_base = "E:\\ProgramData\\ESRI\\ArcLogistics\\StreetData\\TANA2012_R1\\Locators\\"
address_locator = locator_base + "Street_Addresses"
zip_locator = locator_base + "Zipcode"
city_state_locator = locator_base + "CityState"
zip4_locator = locator_base + "ZIP4"

address_field_map = "Address address VISIBLE NONE;City city VISIBLE NONE;State state VISIBLE NONE;ZIP zip VISIBLE NONE"
city_state_field_map = "City city VISIBLE NONE;State state VISIBLE NONE"
zip_field_map = "ZIP zip VISIBLE NONE"
zip4_field_map = "ZIP zip VISIBLE NONE; ZIP4 zip4 VISIBLE NONE"

output_shapefile_path = "E:\\data\\shapefiles\\results25.shp"
address_table = "E:\\data\\shapefiles\\tna1000.csv"
output_csv_file = "E:\\data\\shapefiles\\geocoded_results.csv"


def geocode_addresses_to_csv(gis_workplace, locator, address_field_map, address_table, output_shapefile_path, output_csv_file, fields_to_write):
    """Writes a GIS workspace"""

    if os.path.exists(output_shapefile_path):
        base_file_name, ext = os.path.splitext(output_shapefile_path)
        extensions_to_remove = ["dbf", "sbn", "shp", "shx", "prj", "sbx", "shp.xml"]
        for extension_to_remove in extensions_to_remove:
            path_to_check = base_file_name + "." + extension_to_remove
            if os.path.exists(path_to_check):
                os.remove(path_to_check)
    logger("Geocoding Addresses from '%s'" % address_table)
    gis_workplace.GeocodeAddresses(address_table, locator, address_field_map, output_shapefile_path, "STATIC")
    with open(output_csv_file, "wb") as fw:
        csv_writer = csv.writer(fw)
        object_row_list = gis_workplace.UpdateCursor(output_shapefile_path)
        string_shape_field_name = gis_workplace.Describe(output_shapefile_path).ShapeFieldName
        fields_to_write += ["X", "Y"]
        csv_writer.writerow(fields_to_write)

        object_row = object_row_list.Next()
        while object_row:
            object_geometry = object_row.GetValue(string_shape_field_name)
            object_part = object_geometry.GetPart(0)
            values_to_write = []
            for field_to_write in fields_to_write:
                values_to_write += [object_row.getvalue(field_to_write)]

            if not math.isnan(object_part.X) or not math.isnan(object_part.Y):
                csv_writer.writerow(values_to_write)

            object_row = object_row_list.Next()

def write_out_schema_ini(directory, dict):
    """Schema.ini is a file format for specifying to the ODBC text driver the format of the field
[us_zip4_1.csv]
Col1=zip Text
Col2=zip4 Text
    """

    with open(os.path.join(directory, "schema.ini"), "w") as fws:
        for file_name in dict:
            fws.write("[%s]\n" % file_name)
            data = dict[file_name]
            i = 1
            for datum in data:
                fws.write("Col%s=%s %s\n" % (i, datum[0], datum[1]))
                i += 1


def save_schema_in_json(directory, dict):
    json_schema_file = os.path.join(directory, "schema.json")
    with open(json_schema_file, "w") as fw:
        json.dump(dict, fw)


def load_schema_ini_from_json(directory):
    json_schema_file = os.path.join(directory, "schema.json")

    if os.path.exists(json_schema_file):
        with open(json_schema_file, "r") as f:
            return json.load(f)
    else:
        return {}


def add_entry_into_schema_dict(dict, file_name, columns, mapping=None):
    if mapping is None:
        mapping = {}
        for column in columns:
            mapping[column] = "Text"

    dict[file_name] = []
    for column in columns:
        dict[file_name] += [(column, mapping[column])]

    return dict


def get_new_cursor(dsn_name="nppes"):
    logger("Opening connection %s" % dsn_name)
    connection = odbc.connect("DSN=%s" % dsn_name, autocommit=False)
    return connection.cursor()


def extract_addresses_to_csv(directory, n=10000):
    cursor = get_new_cursor()
    header = ["address", "city", "state", "zip", "address_hash"]
    schema_dict = load_schema_ini_from_json(directory)
    h = 0
    i = 0
    j = 1

    query_result_size = n * 10
    cursor.execute("select count(*) as counter from address where country_code = 'US' and geocode_method is NULL")
    r = list(cursor)
    record_count = r[0][0]
    logger("Transferring %s records" % record_count)
    address_hash = ''

    while (h * query_result_size) < (record_count + query_result_size):
        query_string = """select first_line as address, city as city, state as state, zip5 as zip,
        address_hash as address_hash from address where country_code = 'US'
        and address_hash > '%s'and geocode_method is NULL
        order by address_hash limit %s;""" % (address_hash, query_result_size)

        logger(query_string)
        cursor.execute(query_string)

        for row in cursor:
            if i % n == 0:
                csv_file_name = "us_addresses_%s.csv" % j
                schema_dict = add_entry_into_schema_dict(schema_dict, csv_file_name, header)
                csv_full_file_name = os.path.join(directory, csv_file_name)
                logger("Writing file '%s'" % csv_full_file_name)
                fwc = open(csv_full_file_name, "wb")
                csv_writer = csv.writer(fwc)
                # csv_writer.writerow(header)
                j += 1

            address_hash = row.address_hash
            csv_writer.writerow([row.address, row.city, row.state, row.zip, address_hash])
            i += 1
        h += 1

    save_schema_in_json(directory, schema_dict)
    write_out_schema_ini(directory, schema_dict)


def extract_city_state_to_csv(directory):
    csv_file_name = os.path.join(directory, "us_city_state.csv")
    logger("Writing file '%s'" % csv_file_name)
    with open(csv_file_name, "wb") as fwc:
        cursor = get_new_cursor()
        header = ["city", "state"]
        csv_writer = csv.writer(fwc)
        csv_writer.writerow(header)

        cursor.execute("""select distinct city, state from address where country_code = 'US' and geocode_method is NULL""")
        for row in cursor:
            csv_writer.writerow([row.city, row.state])


def extract_zip_to_csv(directory):
    csv_file_name = "us_zip.csv"
    csv_full_file_name = os.path.join(directory, csv_file_name)
    logger("Writing file '%s'" % csv_full_file_name)
    with open(csv_full_file_name, "wb") as fwc:
        cursor = get_new_cursor()
        header = ["zip"]
        schema_dict = load_schema_ini_from_json(directory)
        schema_dict = add_entry_into_schema_dict(schema_dict, csv_file_name, header)
        csv_writer = csv.writer(fwc)
        csv_writer.writerow(header)

        cursor.execute("""select distinct zip5 as zip from address where country_code = 'US' and geocode_method is NULL""")
        for row in cursor:
            csv_writer.writerow([row.zip])

        save_schema_in_json(directory, schema_dict)
        write_out_schema_ini(directory, schema_dict)


def extract_zip4_to_csv(directory, n=10000):
    cursor = get_new_cursor()
    cursor.execute("""select distinct zip5 as zip, zip4 as zip4 from address where country_code = 'US' and
  geocode_method is null""")

    schema_dict = load_schema_ini_from_json(directory)

    header = ["zip", "zip4"]
    i = 0
    j = 1
    for row in cursor:
        if i % n == 0:
            csv_file_name = "us_zip4_%s.csv" % j
            csv_full_file_name = os.path.join(directory, csv_file_name)
            logger("Writing file '%s'" % csv_file_name)
            fwc = open(csv_full_file_name, "wb")
            if csv_file_name in schema_dict:
               schema_dict.pop(csv_file_name, None)
            schema_dict = add_entry_into_schema_dict(schema_dict, csv_file_name, header)
            csv_writer = csv.writer(fwc, dialect="excel", quoting=csv.QUOTE_ALL)
            csv_writer.writerow(header)
            j += 1
        csv_writer.writerow([row.zip, row.zip4])
        i += 1
    save_schema_in_json(directory, schema_dict)
    write_out_schema_ini(directory, schema_dict)


def geocode_addresses(directory, file_pattern="us_address*.csv", replace_file=False):
    csv_files = glob.glob(os.path.join(directory, file_pattern))

    for csv_file in csv_files:
        directory, file_name = os.path.split(csv_file)
        geocoded_csv_file_name = os.path.join(directory, "geo_" + file_name)
        path_file, ext = os.path.splitext(csv_file)
        shapefile = path_file + ".shp"
        logger(shapefile)
        file_exists = os.path.exists(geocoded_csv_file_name)
        if not file_exists or replace_file:
            geocode_addresses_to_csv(GP, address_locator, address_field_map, csv_file, shapefile, geocoded_csv_file_name,
                                     ["address_ha", "match_addr", "address", "city", "state", "zip"])


def geocode_city_state(directory):
    city_state_csv = os.path.join(directory, "us_city_state.csv")
    geocode_to_csv = os.path.join(directory, "geo_us_city_state.csv")
    shapefile = os.path.join(directory, "geo_us_city_state.shp")
    geocode_addresses_to_csv(GP, city_state_locator, address_field_map, city_state_csv, shapefile, geocode_to_csv,
                             ["city", "state"])


def geocode_zip(directory):
    zip_csv = os.path.join(directory, "us_zip.csv")
    geocode_to_csv = os.path.join(directory, "geo_us_zip.csv")
    shapefile = os.path.join(directory, "geo_us_zip.shp")
    geocode_addresses_to_csv(GP, zip_locator, zip_field_map, zip_csv, shapefile, geocode_to_csv, ["zip"])


def geocode_zip4(directory, file_pattern="us_zip4*.csv", replace_file=False):
    csv_files = glob.glob(os.path.join(directory, file_pattern))

    for csv_file in csv_files:
        directory, file_name = os.path.split(csv_file)
        geocoded_csv_file_name = os.path.join(directory, "geo_" + file_name)
        path_file, ext = os.path.splitext(csv_file)
        shapefile = path_file + ".shp"
        logger(shapefile)
        file_exists = os.path.exists(geocoded_csv_file_name)
        if not file_exists or replace_file:
            geocode_addresses_to_csv(GP, zip4_locator, zip4_field_map, csv_file, shapefile, geocoded_csv_file_name, ["zip", "zip4"])


def write_geocode_address_csv_to_sql(directory, file_pattern="geo_us_address*.csv"):
    geo_csv_files = glob.glob(os.path.join(directory, file_pattern))
    geo_sql_file = os.path.join(directory,"geo_us_addresses.sql")

    with open(geo_sql_file, "w") as fws:
        for geo_csv_file in geo_csv_files:
            with open(geo_csv_file, "rb") as fc:
                geo_csv_dict = csv.DictReader(fc)
                for geo_dict in geo_csv_dict:
                    fws.write("""update address set latitude = %s, longitude = %s, geocode_method = 'address'
                              where address_hash='%s' and latitude is null;\n"""
                              % (geo_dict["Y"], geo_dict["X"], geo_dict["address_ha"]))


def write_geocode_city_state_csv_to_sql(directory):
    geo_csv_file = os.path.join(directory, "geo_us_city_state.csv")
    geo_sql_file = os.path.join(directory, "geo_us_city_state.sql")

    with open(geo_sql_file, "w") as fws:
        with open(geo_csv_file, "r") as fc:
            geo_csv_dict = csv.DictReader(fc)
            for geo_dict in geo_csv_dict:
                sql_query = "update address set latitude = %s, longitude = %s, geocode_method = 'city_state'" % (geo_dict["Y"],
                                                                                                          geo_dict["X"])
                sql_query += " where city = '%s' and state = '%s'" % (geo_dict["city"], geo_dict["state"])
                sql_query += "and latitude is null;\n"
                fws.write(sql_query)


def write_geocode_zip_csv_to_sql(directory):
    geo_csv_file = os.path.join(directory, "geo_us_zip.csv")
    geo_sql_file = os.path.join(directory, "geo_us_zip.sql")

    with open(geo_sql_file, "w") as fws:
        with open(geo_csv_file, "r") as fc:
            geo_csv_dict = csv.DictReader(fc)
            for geo_dict in geo_csv_dict:
                sql_query = "update address set latitude = %s, longitude = %s, geocode_method = 'zip'" % (geo_dict["Y"], geo_dict["X"])
                sql_query += " where zip5 = '%s' and latitude is null;\n" % geo_dict["zip"]
                fws.write(sql_query)


def write_geocode_zip4_csv_to_sql(directory, file_pattern="geo_us_zip4*.csv"):
    geo_csv_files = glob.glob(os.path.join(directory, file_pattern))
    geo_sql_file = os.path.join(directory, "geo_us_zip4.sql")

    with open(geo_sql_file, "w") as fws:
        for geo_csv_file in geo_csv_files:
            with open(geo_csv_file, "rb") as fc:
                geo_csv_dict = csv.DictReader(fc)
                for geo_dict in geo_csv_dict:
                    fws.write("""update address set latitude = %s, longitude = %s, geocode_method = 'zip4'
                              where zip5 = '%s' and zip4 = '%s' and latitude is null;\n"""
                              % (geo_dict["Y"], geo_dict["X"], geo_dict["zip"], geo_dict["zip4"]))


def execute_sql_script(directory, sql_script_name, starting_i=0):
    cursor = get_new_cursor()
    with open(os.path.join(directory, sql_script_name), "r") as f:
        i = 0
        sql_string = ""
        for line in f:
            sql_string += line
            stripped_line = line.strip()
            if stripped_line[-1] == ";":
                cursor.execute(sql_string.strip())
                cursor.commit()
                sql_string = ""
                i += 1


if __name__ == "__main__":

    #Geocode addresses

    #geo_us_addresses_1 8999 records
    extract_addresses_to_csv(workspace_path)
    geocode_addresses(workspace_path, replace_file=False)
    write_geocode_address_csv_to_sql(workspace_path)
    execute_sql_script(workspace_path, "geo_us_addresses.sql")
    #
    extract_zip4_to_csv(workspace_path)
    geocode_zip4(workspace_path)
    write_geocode_zip4_csv_to_sql(workspace_path)
    execute_sql_script(workspace_path, "geo_us_zip4.sql")

    extract_zip_to_csv(workspace_path)
    geocode_zip(workspace_path)
    write_geocode_zip_csv_to_sql(workspace_path)
    execute_sql_script(workspace_path, "geo_us_zip.sql")

    extract_city_state_to_csv(workspace_path)
    geocode_city_state(workspace_path)
    write_geocode_city_state_csv_to_sql(workspace_path)
    execute_sql_script(workspace_path, "geo_us_city_state.sql")



"""
Some counts for analysis

select distinct zip5, zip4 from address;
--1563006

select distinct city, state, country_code from address;
--39397

select distinct zip5 from address;
--37110
"""