'''
Created on May 15, 2012

@author: Ram Angara and Maruthi Deverenti
'''

import arcgisscripting
import csv
import math
import os

def logger(string_to_write=""):
    print(string_to_write)


logger("Open GIS workspace")
workspace_path = "E:\\data\\shapefiles\\"
GP = arcgisscripting.create()
GP.Workspace = workspace_path

locator = "E:\\ProgramData\\ESRI\\ArcLogistics\\StreetData\\TANA2012_R1\\Locators\\Street_Addresses"
address_field_map = "Address address VISIBLE NONE;City city VISIBLE NONE;State state VISIBLE NONE;ZIP zip VISIBLE NONE"
output_shapefile_path = "E:\\data\\shapefiles\\results25.shp"
address_table = "E:\\data\\shapefiles\\tna1000.csv"
output_csv_file = "E:\\data\\shapefiles\\geocoded_results.csv"


def geocode_addresses_to_csv(gis_workplace, locator, address_field_map, address_table, output_shapefile_path, output_csv_file, fields_to_write):
    """Writes a GIS workspace"""

    if os.path.exists(output_shapefile_path):
        base_file_name,ext = os.path.splitext(output_shapefile_path)
        extensions_to_remove = ["dbf","sbn", "shp", "shx", "prj", "sbx", "shp.xml"]
        for extension_to_remove in extensions_to_remove:
            path_to_check = base_file_name + "." + extension_to_remove
            if os.path.exists(path_to_check):
                os.remove(path_to_check)

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

if __name__ == "__main__":
    geocode_addresses_to_csv(GP, locator, address_field_map, address_table, output_shapefile_path, output_csv_file, ["address_ha", "match_addr", "address", "state", "city", "zip", "zip4"])


#cur_time = time.strftime("%a, %d %b %Y %H-%M-%S")
#cur_time = time.asctime()

#check this properly. address must be in proper format for geocoding. Delete the csv first
"""
alter table address add zip5 char(5);
alter table address add zip4 char(4);

update address set zip5 = left(postal_code, 5), zip4 = case when length(postal_code) = 9 then right(postal_code, 4) else NULL end;


select distinct zip5, zip4 from address;
--1563006

select distinct city, state, country_code from address;
--39397

select distinct zip5 from address;
--37110
"""