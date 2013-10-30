"""This little script maps a MySQL table to a scidb array.
It generates two files one for dumping the MySQL table to CSV
and a second for mapping the table data types to scidb.
"""

"""
Scidb types for reference:
bool false Boolean TRUE (1) or FALSE (0)
char \0 Single-character
datetime 1970-01-01 00:00:00 Date and time
datetimetz 1970-01-01 00:00:00 -00:00 Timezone
double 0 Double-precision decimal
float 0 Floating-point number
int8 0 Signed 8-bit integer
int16 0 Signed 16-bit integer
int32 0 Signed 32-bit integer
int64 0 Signed 64-bit integer
string "" Character string
uint8 0 Unsigned 8-bit integer
uint16 0 Unsigned 16-bit integer
uint32 0 Unsigned 32-bit integer
uint64 0 Unsigned 64-bit integer
"""

type_map = {"varchar": "string", "integer": "int32", "float": "float", "double": "double", "tinyint": "int8",
    "datetime": "datetime", "char": "string"
}

import pyodbc as odbc

__author__ = 'Janos G. Hajagos'

def main():
    table_name = "rx_graph_brand_name_nppes"
    mapped_fields = map_data_types_to_scidb_types(table_name)
    aql = create_array_aql(table_name, mapped_fields)
    print(aql)

def logger(string_to_log=""):
    print(string_to_log)

def get_cursor(dsn_name="rx_graph"):
    logger("Opening connection %s" % dsn_name)
    connection = odbc.connect("DSN=%s" % dsn_name, autocommit=True)
    return connection.cursor()


def map_data_types_to_scidb_types(table_name="rx_graph_brand_name_nppes"):

    cursor = get_cursor()
    raw_odbc_column_info = cursor.columns(table_name)
    field_data_types_list = [(info[3], info[5]) for info in raw_odbc_column_info]

    mapped_field_list = []
    for field_data_type in field_data_types_list:
        field_name, data_type = field_data_type
        if data_type in type_map:
            mapped_data_type = type_map[data_type]
        else:
            mapped_data_type = data_type

        mapped_field_list += [(field_name, mapped_data_type)]

    print(mapped_field_list)
    return mapped_field_list

"""
create array rx_graph_brand_name
<npi:string,
brand_name:string,
claim_count:uint32,
claim_count_raw:uint32,
claim_count_compound:uint32
quantity_sum:uint32,
day_supply_sum:uint64,
gross_drug_cost_sum:double>
[row_num=0:*, 1000000,0]"
"""

def create_array_aql(array_name, mapped_field_list, chunk_size=1000000, overlap=0):
    aql_string = ""
    aql_string += "create array %s\n<" % array_name
    #aql_string += "row_num:uint64,\n"

    for mapped_field in mapped_field_list:
        aql_string += "%s:%s,\n" % (mapped_field[0], mapped_field[1])

    aql_string = aql_string[:-2]
    aql_string += ">\n"
    aql_string += "[row_num=0:*,%s,%s];" % (chunk_size, overlap)

    return aql_string


if __name__ == "__main__":
    main()