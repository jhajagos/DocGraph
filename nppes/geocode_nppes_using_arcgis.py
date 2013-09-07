"""
Created on May 15, 2012

@author: Janos Hajagos, Ram Angara, Maruthi Deverenti

The strategy is to do several passes to update the latitude and longitude
starting with matched addresses, zip4, zip, city_state matched geocodes

We update records in the address table if the latitude is null

We are using ArcGIS to do the Geocoding and using the Address Locators that are part of Arclogistics

One of the issues that we have to deal with is that ArcGis can only update several records

"""

import arcgisscripting
import csv
import math
import os
import pyodbc as odbc
import glob


def logger(string_to_write=""):
    print(string_to_write)

logger("Open GIS workspace")
workspace_path = "E:\\data\\shapefiles\\"
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


def get_new_cursor(dsn_name="nppes"):
    logger("Opening connection %s" % dsn_name)
    connection = odbc.connect("DSN=%s" % dsn_name, autocommit=True)
    return connection.cursor()


def extract_addresses_to_csv(directory, n=10000):
    cursor = get_new_cursor()
    header = ["address", "city", "state", "zip", "address_hash"]
    h = 0
    i = 0
    j = 1

    query_result_size = n * 10
    cursor.execute("select count(*) as counter from address where country_code = 'US'")
    r = list(cursor)
    record_count = r[0][0]
    logger("Transferring %s records" % record_count)
    address_hash = ''

    while (h * query_result_size) < (record_count + query_result_size):
        query_string = """select first_line as address, city as city, state as state, zip5 as zip,
        address_hash as address_hash from address where country_code = 'US'
        and address_hash > '%s'
        order by address_hash limit %s;""" % (address_hash, query_result_size)

        logger(query_string)
        cursor.execute(query_string)

        for row in cursor:
            if i % n == 0:
                csv_file_name = os.path.join(directory, "us_addresses_%s.csv" % j)
                logger("Writing file '%s'" % csv_file_name)
                fwc = open(csv_file_name, "wb")
                csv_writer = csv.writer(fwc)
                csv_writer.writerow(header)
                j += 1

            address_hash = row.address_hash
            csv_writer.writerow([row.address, row.city, row.state, row.zip, address_hash])
            i += 1
        h += 1


def extract_city_state_to_csv(directory):
    csv_file_name = os.path.join(directory, "us_city_state.csv")
    logger("Writing file '%s'" % csv_file_name)
    with open(csv_file_name, "wb") as fwc:
        cursor = get_new_cursor()
        header = ["city", "state"]
        csv_writer = csv.writer(fwc)
        csv_writer.writerow(header)

        cursor.execute("""select distinct city, state from address where country_code = 'US'""")
        for row in cursor:
            csv_writer.write_row([row.city, row.state])


def extract_zip_to_csv(directory):
    csv_file_name = os.path.join(directory, "us_zip.csv")
    logger("Writing file '%s'" % csv_file_name)
    with open(csv_file_name, "wb") as fwc:
        cursor = get_new_cursor()
        header = ["zip"]
        csv_writer = csv.writer(fwc)
        csv_writer.writerow(header)

        cursor.execute("""select distinct zip5 as zip from address where country_code = 'US'""")
        for row in cursor:
            csv_writer.write_row([row.zip])


def extract_zip4_to_csv(directory, n=10000):
    cursor = get_new_cursor()
    cursor.execute("""select distinct zip5 as zip, zip4 as zip4 from address where country_code = 'US'""")

    header = ["zip", "zip4"]
    i = 0
    j = 1
    for row in cursor:
        if i % n == 0:
            csv_file_name = os.path.join(directory, "us_zip4_%s.csv" % j)
            logger("Writing file '%s'" % csv_file_name)
            fwc = open(csv_file_name, "wb")
            csv_writer = csv.writer(fwc)
            csv_writer.writerow(header)
            j += 1

        csv_writer.writerow([row.zip, row.zip4])
        i += 1


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
            geocode_addresses_to_csv(GP, address_locator, address_field_map, csv_file, shapefile, geocoded_csv_file_name, ["address_ha", "match_addr", "address", "city", "state", "zip"])


def geocode_city_state(directory):
    city_state_csv = os.path.join(directory, "us_city_state.csv")
    geocode_to_csv = os.path.join(directory, "geo_us_city_state.csv")
    shapefile = os.path.join(directory, "geo_us_city_state.shp")
    geocode_addresses_to_csv(GP, city_state_locator, address_field_map, city_state_csv, shapefile, geocode_to_csv, ["city", "state"])


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
        if file_exists == False or replace_file == True:
            geocode_addresses_to_csv(GP, zip4_locator, zip4_field_map, csv_file, shapefile, geocoded_csv_file_name, ["zip", "zip4"])


def write_geocode_address_csv_to_sql(directory, file_patterns="geo_us_address*.csv"):
    geo_csv_files = glob.glob(os.path.join(directory, file_patterns))
    geo_sql_file = os.path.join(directory,"geo_us_addresses.sql")

    with open(geo_sql_file, "w") as fws:
        for geo_csv_file in geo_csv_files:
            with open(geo_csv_file, "rb") as fc:
                geo_csv_dict = csv.DictReader(fc)
                for geo_dict in geo_csv_dict:
                    fws.write("update address set latitude = %s, longitude = %s, geocode_method = 'address' where address_hash = '%s'"";\n\n"
                              % (geo_dict["Y"], geo_dict["X"], geo_dict["address_ha"]))


def write_geocode_city_state_csv_to_sql(directory):
    pass


def write_geocode_zip_csv_to_sql(directory):
    pass


def write_geocode_zip4_csv_to_sql(directory):
    pass


if __name__ == "__main__":

    #Geocode addresses
    extract_addresses_to_csv(workspace_path)
    geocode_addresses(workspace_path)
    #write_geocode_address_csv_to_sql(workspace_path)


"""
alter table address add zip5 char(5);
alter table address add zip4 char(4);
alter table address add geocode_method varchar(15);
create index idx_addr_hash on address(address_hash);

update address set zip5 = left(postal_code, 5), zip4 = case when length(postal_code) = 9 then right(postal_code, 4) else NULL end;


select distinct zip5, zip4 from address;
--1563006

select distinct city, state, country_code from address;
--39397

select distinct zip5 from address;
--37110
"""