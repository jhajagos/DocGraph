"""
    Basic script to load the NPI database into a mysql database table.

    http://nppes.viva-it.com/NPI_Files.html

    Maps Number data types to char
    Converts data times
    Empty strings and empty dates are interpreted to be nulls

    Also load taxonomies with descriptions

    http://www.nucc.org/index.php?option=com_content&task=view&id=107&Itemid=57

    Author: Janos G. Hajagos (@jhajagos) risk DOT limits AT gmail DOT com
"""

from string import join
import csv


def generate_load_table_script(filename,table_name,row_terminator=r"\n",escape_char=r"\0"):
    return """LOAD DATA INFILE '%s' INTO TABLE %s
      FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '%s'
      LINES TERMINATED BY '%s'
      IGNORE 1 LINES""" % (filename, table_name, escape_char, row_terminator) # The csv file is in Unix format


def split_and_join(text_to_split, split_by, join_by):
    split_text = text_to_split.split(split_by)
    return join(split_text, join_by)


def transform_text_into_field(text_to_transform):
    text1_transform = split_and_join(text_to_transform.lower()," ","_")
    text2_transform = split_and_join(text1_transform, "_&_","_and_")
    text3_transform = split_and_join(text2_transform, ",","")
    text4_transform = split_and_join(text3_transform, "/","_")
    text5_transform = split_and_join(text4_transform, "(","")
    text6_transform = split_and_join(text5_transform, ")","")
    text7_transform = split_and_join(text6_transform, ".","")
    text8_transform = split_and_join(text7_transform, "-","")
    text9_transform = split_and_join(text8_transform, "__","_")
    return text9_transform


def generate_alter_update_for_provider_taxonomy(fields_to_create, table_name_to_alter, target_taxonomy_field):
    alter_table_sql = ""
    update_table_sql = ""
    fields = fields_to_create.keys()
    fields.sort()

    for field in fields:
        new_field_name = "is_" + transform_text_into_field(field)
        alter_table_sql += "alter table %s add %s boolean;\n\n" % (table_name_to_alter, new_field_name)

        taxonomy_string = ""
        for taxonomy_code in fields_to_create[field]:
            taxonomy_string += " %s like '%%%s%%' or" % (target_taxonomy_field, taxonomy_code)
        update_table_sql += "update %s set %s = case when %s then 1 else 0 end;\n\n" % (table_name_to_alter,
                                                                                      new_field_name, taxonomy_string[:-3])

    return alter_table_sql, update_table_sql


def generate_fields_and_populate_flattened_fields(file_name="nucc_taxonomy_121_with_annotations.csv",
                                                  table_name_to_alter="", target_taxonomy_field=""):
    f = open(file_name)
    csv_annotations = csv.reader(f)

    i = 0
    header = []
    classification_fields_to_create = {}
    type_fields_to_create = {}
    type_fields_to_rename = {}
    specialty_fields_to_create = {}

    for row in csv_annotations:

        if i == 0:
            header = row
        else:
            type_field = row[header.index("Type")]
            classification_field = row[header.index("Classification")]
            specialty_field = row[header.index("Specialization")]
            code_field = row[header.index("Code")]
            add_type_field = row[header.index("build_type_field")]
            add_classification_field = row[header.index("build_classification_field")]
            classification_field_rename = row[header.index("classification_field_rename")]
            type_field_rename = row[header.index("type_field_rename")]
            add_specialty_field = row[header.index("build_specialty_field")]

            if add_classification_field == "1":
                if len(classification_field_rename) > 0:
                    classification_field = classification_field_rename

                if classification_field in classification_fields_to_create:
                    classification_fields_to_create[classification_field] += [code_field]
                else:
                    classification_fields_to_create[classification_field] = [code_field]

            if add_type_field == '1':
                if len(type_field_rename) > 0:
                    type_field = type_field_rename

                if type_field in type_fields_to_create:
                    type_fields_to_create[type_field] += [code_field]
                else:
                    type_fields_to_create[type_field] = [code_field]
                    if len(classification_field_rename) > 0:
                        type_fields_to_rename[type_field] = type_field_rename

            if add_specialty_field == '1':
                if specialty_field in specialty_fields_to_create:
                    specialty_fields_to_create[specialty_field] += [code_field]
                else:
                    specialty_fields_to_create[specialty_field] = [code_field]

        i += 1

    f.close()

    (alter_table_sql1, update_table_sql1) = generate_alter_update_for_provider_taxonomy(classification_fields_to_create,
                                                                                      table_name_to_alter,
                                                                                      target_taxonomy_field)


    (alter_table_sql2, update_table_sql2) = generate_alter_update_for_provider_taxonomy(type_fields_to_create,
                                                                                      table_name_to_alter,
                                                                                      target_taxonomy_field)


    (alter_table_sq3, update_table_sql3) = generate_alter_update_for_provider_taxonomy(specialty_fields_to_create,
                                                                                      table_name_to_alter,
                                                                                      target_taxonomy_field)
    return alter_table_sql1 + alter_table_sql2 + alter_table_sq3, update_table_sql1 + update_table_sql2 \
                                                                  + update_table_sql3


def main(nppes_data_file_name, taxonomy_file_name = None):
    f = open("npi_schema.txt","r")
    npi_lines=f.readlines()
    npi_split = [npi_line.split('\t') for npi_line in npi_lines]

    #First pass through build a dictionary connecting names to
    # select friendly names e.g. transform "Last name (U.S. Legal name)"
    # into "Last_name_US_Legal_name"

    field_name_db_field_names = {}

    for npi_row in npi_split:
            field_name = npi_row[0].strip()
            db_field_name = join(field_name.split(),"_")
            db_field_name = join(db_field_name.split("."),"")
            db_field_name = join(db_field_name.split("("),"")
            db_field_name = join(db_field_name.split(")"),"")

            if db_field_name[-1] == "_":
                db_field_name = db_field_name[:-1]

            try:
                position = db_field_name.index("_If_outside_US")
                db_field_name = db_field_name[0:position-1]
            except ValueError:
                pass

            field_name_db_field_names[field_name] = db_field_name

    #Second pass through we build a data type hash
    field_name_data_types = {}
    for npi_row in npi_split:
            field_name = npi_row[0].strip()
            data_type = npi_row[2].strip()
            field_length = npi_row[1].strip()

            if data_type == "NUMBER":
                data_type = "CHAR"

            if data_type == "DATE":
                field_length = ""
            else:
                field_length = "(%s)" % field_length

            field_name_data_types[field_name] = data_type + field_length

    #Third pass through we write the ddl script

    ddl_table_script = """
    drop table if exists NPPES_flat;
    create table NPPES_flat (
    """
    for npi_row in npi_split:
        field_name = npi_row[0].strip()
        db_field_name = field_name_db_field_names[field_name]
        data_type = field_name_data_types[field_name]
        ddl_table_script += "    %s %s,\n" % (db_field_name, data_type)
    ddl_table_script = ddl_table_script[:-2] + ")"

    # The fourth pass through we create the Mysql load script
    # Because of date time fields we need to do custom mappings and we also
    # set null values when fields are empty strings

    load_table_script = generate_load_table_script(nppes_data_file_name,"NPPES_flat")

    set_string = ""
    fields_string = ""

    for npi_row in npi_split:
        field_name = npi_row[0].strip()
        db_field_name = field_name_db_field_names[field_name]
        data_type = field_name_data_types[field_name]

        fields_string += "@%s," % db_field_name
        set_string += "%s = case @%s when '' then NULL else " % (db_field_name,db_field_name)
        if data_type == "DATE":
            set_string += "str_to_date(@%s, '%%m/%%d/%%Y') " % db_field_name
        else:
            set_string += "@%s " % db_field_name
        set_string += "end,\n"

    # Fifth pass through we now build a commented view to NPPES_flat
    # Because some of the fields are too long for mysql we leave the view
    # commented out. View can be used to emulate NPPESdata import with original fields
    # with a database that supports long field names. We escape field names with
    # [] because we ultimately import this into a SQLServer Database

    create_view_script = "create view NPPESdata as (select\n"

    for npi_row in npi_split:
        field_name = npi_row[0].strip()
        db_field_name = field_name_db_field_names[field_name]
        create_view_script += "   %s as [%s],\n" % (db_field_name,field_name)

    create_view_script = create_view_script[:-2] + " from NPPES_flat);"

    # Now we begin the process of normalizing the flat table
    # NPPES_header will be the main table

    # We now need to reverse our dictionary of field names
    db_field_name_field_names = {}
    for (field_name,db_field_name) in field_name_db_field_names.iteritems():
        db_field_name_field_names[db_field_name] = field_name

    # We first generate the schema for other_provider_identifiers
    other_provider_identifier_base_fields = ["Other_Provider_Identifier", "Other_Provider_Identifier_Type_Code",
                                             "Other_Provider_Identifier_Issuer","Other_Provider_Identifier_State"]
    other_provider_identifier_maximum_flat_n = 50
    normalized_field_names = []  # Store fields that we normalized so that we can generate NPPES_header table

    opi_create_table_script = """drop table if exists other_provider_identifiers;
    create table other_provider_identifiers (
    npi char(10),
    sequence_id integer,
"""

    for db_field_name in other_provider_identifier_base_fields:
        first_db_field_name = db_field_name + "_1"
        first_field_name = db_field_name_field_names[first_db_field_name]
        first_data_type = field_name_data_types[first_field_name]

        opi_create_table_script += "    %s %s,\n" % (db_field_name,first_data_type)

    opi_create_table_script = opi_create_table_script[:-2] + ");"

    opi_load_table_script = ""
    for i in range(1,other_provider_identifier_maximum_flat_n + 1):
        opi_db_field_names = [opi_db_field_name + "_" + str(i) for opi_db_field_name in other_provider_identifier_base_fields]
        opi_load_table_script += """insert into other_provider_identifiers (npi,sequence_id,%s)
    select npf.npi, %s, %s from NPPES_flat npf
where %s is not NULL;\n\n""" % (join(other_provider_identifier_base_fields,","), i, join(opi_db_field_names,","), join(opi_db_field_names," is not NULL or "))
        normalized_field_names += opi_db_field_names

    license_base_field_names = ["Healthcare_Provider_Taxonomy_Code","Provider_License_Number",
                                "Provider_License_Number_State_Code", "Healthcare_Provider_Primary_Taxonomy_Switch"]
    license_maximum_flat_n = 15

    license_create_table_script = """drop table if exists provider_licenses;
create table provider_licenses (
    npi char(10),
    sequence_id integer,
"""

    for db_field_name in license_base_field_names:
        first_db_field_name = db_field_name + "_1"
        first_field_name = db_field_name_field_names[first_db_field_name]
        first_data_type = field_name_data_types[first_field_name]

        license_create_table_script += "    %s %s,\n" % (db_field_name,first_data_type)
    license_create_table_script = license_create_table_script[:-2] + ");"

    license_load_table_script = ""
    for i in range(1,license_maximum_flat_n + 1):
        license_db_field_names = [license_db_field_name + "_" + str(i) for license_db_field_name in license_base_field_names]
        license_load_table_script += """insert into provider_licenses (npi,sequence_id,%s)
    select npf.npi, %s, %s from NPPES_flat npf
where %s is not NULL;\n\n""" % (join(license_base_field_names,","), i, join(license_db_field_names,","), join(license_db_field_names," is not NULL or "))
        normalized_field_names += license_db_field_names

    nppes_header_create_table_script = """drop table if exists NPPES_header;
    create table NPPES_header (\n"""
    nppes_header_db_field_names = []
    for npi_row in npi_split:
        field_name = npi_row[0].strip()
        db_field_name = field_name_db_field_names[field_name]
        data_type = field_name_data_types[field_name]

        if db_field_name not in normalized_field_names:
            nppes_header_create_table_script += "    " + db_field_name + " " + data_type + ",\n"
            nppes_header_db_field_names.append(db_field_name)

    nppes_header_create_table_script = nppes_header_create_table_script[:-2] + ");"

    nppes_header_load_table_script = """insert into NPPES_header (%s)
    select %s from NPPES_flat;""" % (join(nppes_header_db_field_names,","),join(nppes_header_db_field_names,","))


    load_table_script = """%s
       (%s)
       set
       %s""" % (load_table_script,fields_string[:-1],set_string[:-2])


    if taxonomy_file_name:
        taxonomy_create_table_script = """drop table if exists healthcare_provider_taxonomy_processed;
create table healthcare_provider_taxonomies (
    taxonomy_code char(10) not null,
    provider_type varchar(255),
    classification varchar(255),
    specialization varchar(1024),
    definition text,
    notes text);
        """

        taxonomy_load_table_script = generate_load_table_script(taxonomy_file_name,"healthcare_provider_taxonomies",r"\r\n")
        taxonomy_load_table_script += "\n;\n"


    taxonomy_processed_create_table_script = """drop table if exists healthcare_provider_taxonomy_processed;
    create table  healthcare_provider_taxonomy_processed
        (npi char(11),
        depth integer,
         flattened_taxonomy_string varchar(200)
    );
    """

    provider_taxonomy_processed_string = ""
    provider_taxonomy_insert_statement = "insert into healthcare_provider_taxonomy_processed (npi, depth, flattened_taxonomy_string)\n"

    for i in range(0,license_maximum_flat_n):
        fields_to_aggregrate = ""
        for j in range(0, i + 1):
            fields_to_aggregrate += "'|', Healthcare_Provider_Taxonomy_Code_%s, '|'," % (j + 1,)

        if i == license_maximum_flat_n - 1:
            where_clause = ""
            for j in range(0, i + 1):
                where_clause += " Healthcare_Provider_Taxonomy_Code_%s is not null and" % (j + 1,)
            where_clause = where_clause[:-4]
        else:
            where_clause = """Healthcare_Provider_Taxonomy_Code_%s is null
and Healthcare_Provider_Taxonomy_Code_%s is not null""" % (i + 2, i + 1)

        provider_taxonomy_processed_string += """%s select nf.npi, %s, concat(%s) as taxonomy_string
from nppes_flat nf where %s;\n\n""" % (provider_taxonomy_insert_statement, i + 1, fields_to_aggregrate[:-1], where_clause)

    print("""/*
 MySQL Script to Load monthly NPPES into a
 database.

 Author: Janos G. Hajagos 1/13/13
*/""")

    print(ddl_table_script)
    print(";\n")
    print(load_table_script)
    print(";\n")

    print("/*")
    print(create_view_script)
    print("*/")
    print("")
    print(opi_create_table_script)
    print("")
    print(opi_load_table_script)
    print("")
    print(license_create_table_script)
    print("")
    print(license_load_table_script)
    print("")
    print(nppes_header_create_table_script)
    print("")
    print(nppes_header_load_table_script)

    if taxonomy_file_name:
        print("")
        print(taxonomy_create_table_script)
        print(taxonomy_load_table_script)

    print("")
    print(taxonomy_processed_create_table_script)
    print("")

    alter_table_sql, update_table_sql = generate_fields_and_populate_flattened_fields(table_name_to_alter="healthcare_provider_taxonomy_processed",
                                                  target_taxonomy_field='flattened_taxonomy_string')
    
    print(alter_table_sql)
    print(provider_taxonomy_processed_string)
    print(update_table_sql)

    create_indexes_sql = """/* Add indices to the tables */

create unique index pk_npi_nppes_header on npi.nppes_header(npi);
create unique index pk_npi_hct_proc on healthcare_provider_taxonomy_processed(npi);
create index idx_oth_prov_id_npi on other_provider_identifiers(npi);
create index idx_provider_licenses on provider_licenses(npi);
"""
    print("")
    print(create_indexes_sql)


if __name__ == "__main__":
    # Hardcoded file names
    # The assumption in this script that you are using a Unix like file system
    main("/data/npi/npidata_20050523-20130113.csv", "/data/npi/nucc_taxonomy_121.csv")

    #Loading the files
    #python npi_schema.py > npi_schema.sql
    #python npi_schema.py > npi_schema.sql
    #mysql -u root -pd
        #create database npi;
    #mysql -u root -p npi < npi_schema.sql
    #mysqldump -u root -p > npi_20130113.sql
    #bzip2 npi_20130113.sql
