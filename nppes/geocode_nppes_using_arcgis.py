'''
Created on May 15, 2012

@author: Ram Angara and Maruthi Deverenti
'''

#import pyodbc
import hashlib
import re
# import sys
# sys.path.append("F:\Program Files (x86)\ArcGIS\Desktop10.0\Bin")


# cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER=deepthought02\suny;DATABASE=npi')
# cursor = cnxn.cursor()
#
# cnxn2 = pyodbc.connect('DRIVER={SQL Server};SERVER=deepthought02\suny;DATABASE=npi')
# cursor2 = cnxn2.cursor()

#sys.path.append("F:\\Program Files (x86)\\ArcGIS\\Desktop10.0\\Bin")



#base_directory = "G:\\GiSNpi\\"
#geocode_input_directory = os.path.join(base_directory,"Geocode_Input")
#geocode_input_shape_directory = os.path.join(geocode_input,"shapefiles")
#geocode_output_directory = os.path.join(base_directory,"Geocode_Output")

#for dir in [geocode_input_directory,geocode_input_shape_directory,geocode_output_directory]:
#    if os.path.isdir(dir):
#        pass
#    else:
#        os.makedirs()

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


import arcgisscripting
import csv
import math

GP = arcgisscripting.create()
GP.Workspace = "E:\\data\\shapefiles\\"
locator = "E:\\ProgramData\\ESRI\\ArcLogistics\\StreetData\\TANA2012_R1\\Locators\\Street_Addresses"
address_field_map = "Address address VISIBLE NONE;City city VISIBLE NONE;State state VISIBLE NONE;ZIP zip VISIBLE NONE"
output_shapefile_path = "E:\\data\\shapefiles\\results25.shp"
address_table = "E:\\data\\shapefiles\\tna1000.csv"
GP.GeocodeAddresses(address_table, locator, address_field_map, output_shapefile_path,"STATIC")
output_csv_file = "E:\\data\\shapefiles\\geocoded_results.csv"

with open(output_csv_file, "wb") as fw:
    csv_writer = csv.writer(fw)
    object_row_list = GP.UpdateCursor(output_shapefile_path)
    strShapeFieldName = GP.Describe(output_shapefile_path).ShapeFieldName
    object_row = object_row_list.Next()
    while object_row:
        object_geometry = object_row.GetValue(strShapeFieldName)
        object_part = object_geometry.GetPart(0)
        # print(object_row)
        # print(dir(object_row))
        # print(object_part)
        # print(dir(object_part))

        if not math.isnan(object_part.X) or not math.isnan(object_part.Y):
            csv_writer.writerow([object_part.X, object_part.Y, object_row.address_ha, object_row.match_addr, object_row.address, object_row.state, object_row.city, object_row.zip, object_row.zip4])

        object_row = object_row_list.Next()


#cur_time = time.strftime("%a, %d %b %Y %H-%M-%S")
#cur_time = time.asctime()

#check this properly. address must be in proper format for geocoding. Delete the csv first
"""
filep = open('J:\\users\\ram\Desktop\Geocode_Input\\geocode_data_test_' + cur_time + '.csv', 'w')
initial = "ID,Address,City,State,ZIP"
print >> filep,initial
"""

"""
def process_address():

    query = "SELECT [NPI], [Provider First Line Business Mailing Address]," \
            "[Provider Second Line Business Mailing Address]," \
            "[Provider Business Mailing Address City Name]," \
            "[Provider Business Mailing Address State Name]," \
            "[Provider Business Mailing Address Postal Code]," \
            "[Provider Business Mailing Address Country Code (If outside U S )]," \
            "[Provider First Line Business Practice Location Address]," \
            "[Provider Second Line Business Practice Location Address]," \
            "[Provider Business Practice Location Address City Name]," \
            "[Provider Business Practice Location Address State Name]," \
            "[Provider Business Practice Location Address Postal Code]," \
            "[Provider Business Practice Location Address Country Code (If outside U S )]" \
            " FROM npidata"

    cursor.execute(query)
    row = cursor.fetchone()

    while row is not None:
        #print row[0]
        npi = row[0]
        business_address = str(row[1]) + ","
        if row[2]:
            business_address += str(row[2]) + ","
        if row[3]:
            business_address += str(row[3]) + ","
        if row[4]:
            business_address += str(row[4]) + ","
        if row[5]:
            business_address += str(row[5]) + ","
        if row[6]:
            business_address += str(row[6])

        print(business_address)
        practice_address = ""
        if row[7]:
            practice_address += row[7] + ","
        if row[8]:
            practice_address += row[8] + ","
        if row[9]:
            practice_address += row[9] + ","
        if row[10]:
            practice_address += row[10] + ","
        if row[11]:
            practice_address += row[11] + ","
        if row[12]:
            practice_address += row[12]

        print practice_address
        bHash = hashlib.sha224(business_address).hexdigest()
        pHash = hashlib.sha224(practice_address).hexdigest()

        query2 = "Select npi_id from npi_address_map where npi_id = " + str(npi) + " and business_address_hash = '" + str(bHash) + "' and practice_address_hash = '" + str(pHash) + "'"
        cursor2.execute(query2)
        result_set_npi_location = cursor2.fetchall()

        if(result_set_npi_location is not None):
            print "npi already in npi_address_map. skipping"
        else:

            #check_bhash = "select * from address_hash where hashval = \"" + str(bHash) + "\""
            check_bhash = "select * from address_hash where hashval = " + "'" + str(bHash) + "'"
            print(check_bhash)
            cursor2.execute(check_bhash)
            row1 = cursor2.fetchone()
            if(row1) :
                print "BusinessAddr already exists"
            else:
                print "Inserting businessAddr into address_hash"
                insertStr1 = "Insert into address_hash values(" + "\"" + str(business_address) + "\", " + "\"" + str(bHash) + "\");"
                cursor2.execute(insertStr1)
                result = [str(x) for x in filter(None, re.split('[,]', business_address))]
                length = len(result)
                Zip = result[length-2]
                State = result[length-3]
                City = result[length-4]
                if((length-5) >= 0):
                    if((length-6) >= 0):
                        Address = result[length-6] + ',' + result[length-5]
                    else:
                        Address = result[length-5]
                else:
                    Address = ""
                #print "Address: ", Address, "City: ", City, "State: ", State, "Zip: ", Zip
                toWrite = bHash + "," + "\"" + Address + "\"," + City + "," + State + "," + Zip
                print >> filep,toWrite

            #check_phash = "select * from address_hash where hashval = \"" + str(pHash) + "\""
            check_phash = "select * from address_hash where hashval = '" + str(pHash) + "'"
            print check_phash
            cursor2.execute(check_phash)
            row1 = cursor2.fetchone()
            if(row1):
                print("PracticeAddr already exists")
            else:
                print("Inserting practiceAddr into address_hash")
                insertStr2 = "Insert into address_hash values(" + "\"" + str(practice_address) + "\", " + "\"" + str(pHash) + "\");"
                cursor2.execute(insertStr2)
                result = [str(x) for x in filter(None, re.split('[,]', business_address))]
                length = len(result)
                Zip = result[length-2]
                State = result[length-3]
                City = result[length-4]
                if((length-5) >= 0):
                    if((length-6) >= 0):
                        Address = result[length-6] + ',' + result[length-5]
                    else:
                        Address = result[length-5]
                else:
                    Address = ""
                #print "Address: ", Address, "City: ", City, "State: ", State, "Zip: ", Zip
                toWrite = bHash + "," + "\"" + Address + "\"," + City + "," + State + "," + Zip
                print >> filep,toWrite

            # Check if npi entry is new or if just addresses is updated.
            query3 = "Select npi_id from npi_address_map where npi_id = " + str(npi)
            cursor2.execute(query3)
            resultset3 = cursor2.fetchall()
            if(resultset3 is not None):
                print "npi is updated"
                updateStr = "Update npi_address_map set business_address_hash = '" + str(bHash) + "' and practice_address_hash = '" + str(pHash) + "' where npi_id = " + str(npi)
                cursor2.execute("SET QUOTED_IDENTIFIER OFF")
                cursor2.execute(updateStr)
            else:
                print "Inserting into npi_address_map"
                insertStr = "Insert into npi_address_map values(" + str(npi) + ", \"" + str(bHash) + "\", \"" + str(pHash) + "\");"
                cursor2.execute("SET QUOTED_IDENTIFIER OFF")
                cursor2.execute(insertStr)

        row = cursor.fetchone()

    filep.close()

def geocode_address():
    print "geocoding started..\n"
    address_table = "J:\\users\\ram\Desktop\\Geocode_Input\\geocode_data_test_" + cur_time + ".csv"
    output_shapefile = "Geo_result_ram_new_test_" + cur_time
    GP.GeocodeAddresses(address_table, locator, address_field_map, output_shapefile,"STATIC")
    shapefile_path = 'J:\Users\\ram\\Desktop\\Geocode_Input\\shapefiles\\' + output_shapefile + '.shp'

    objRowList = GP.UpdateCursor(shapefile_path)
    objRow = objRowList.Next()
    strShapeFieldName = GP.Describe(shapefile_path).ShapeFieldName

    filpin = open('J:\\users\\ram\\Desktop\\Geocode_Input\\geocode_data_test_' + cur_time + '.csv', 'r')
    filpin.readline()
    filpout = open('J:\\users\\ram\\Desktop\\Geocode_Output\\output_' + cur_time + '.txt', 'w')

    while objRow:
        objGeometry = objRow.GetValue(strShapeFieldName)
        objPart = objGeometry.GetPart(0)

        inp = filpin.readline()
        result = [str(x) for x in filter(None, re.split('[,]',inp))]
        hashVal = result[0]

        print objPart.X, objPart.Y
        toWrite = hashVal + "," + str(objPart.X) + "," + str(objPart.Y)
        print >> filpout,toWrite
        insert_coords = "Insert into address_coordinates values(" + hashVal + "\",\"" + str(objPart.X) + "\",\"" + str(objPart.Y) + "\")"
        #cursor.execute(insert_coords)
        objRow = objRowList.Next()

    filpin.close()
    filpout.close()

if __name__ == "__main__":
    process_address()
    geocode_address()
    cnxn.close()
    cnxn2.close()
    print "Done!!!"

#Get the npi and addresses as arguments
"""
