/*
 MySQL Script to Load monthly NPPES into a
 mysql database

 Author: Janos G. Hajagos 1/13/13
*/

    drop table if exists NPPES_flat;
    create table NPPES_flat (
        NPI CHAR(10),
    Entity_Type_Code CHAR(1),
    Replacement_NPI CHAR(10),
    Employer_Identification_Number_EIN VARCHAR(9),
    Provider_Organization_Name_Legal_Business_Name VARCHAR(70),
    Provider_Last_Name_Legal_Name VARCHAR(35),
    Provider_First_Name VARCHAR(20),
    Provider_Middle_Name VARCHAR(20),
    Provider_Name_Prefix_Text VARCHAR(5),
    Provider_Name_Suffix_Text VARCHAR(5),
    Provider_Credential_Text VARCHAR(20),
    Provider_Other_Organization_Name VARCHAR(70),
    Provider_Other_Organization_Name_Type_Code VARCHAR(1),
    Provider_Other_Last_Name VARCHAR(35),
    Provider_Other_First_Name VARCHAR(20),
    Provider_Other_Middle_Name VARCHAR(20),
    Provider_Other_Name_Prefix_Text VARCHAR(5),
    Provider_Other_Name_Suffix_Text VARCHAR(5),
    Provider_Other_Credential_Text VARCHAR(20),
    Provider_Other_Last_Name_Type_Code CHAR(1),
    Provider_First_Line_Business_Mailing_Address VARCHAR(55),
    Provider_Second_Line_Business_Mailing_Address VARCHAR(55),
    Provider_Business_Mailing_Address_City_Name VARCHAR(40),
    Provider_Business_Mailing_Address_State_Name VARCHAR(40),
    Provider_Business_Mailing_Address_Postal_Code VARCHAR(20),
    Provider_Business_Mailing_Address_Country_Cod VARCHAR(2),
    Provider_Business_Mailing_Address_Telephone_Number VARCHAR(20),
    Provider_Business_Mailing_Address_Fax_Number VARCHAR(20),
    Provider_First_Line_Business_Practice_Location_Address VARCHAR(55),
    Provider_Second_Line_Business_Practice_Location_Address VARCHAR(55),
    Provider_Business_Practice_Location_Address_City_Name VARCHAR(40),
    Provider_Business_Practice_Location_Address_State_Name VARCHAR(40),
    Provider_Business_Practice_Location_Address_Postal_Code VARCHAR(20),
    Provider_Business_Practice_Location_Address_Country_Cod VARCHAR(2),
    Provider_Business_Practice_Location_Address_Telephone_Number VARCHAR(20),
    Provider_Business_Practice_Location_Address_Fax_Number VARCHAR(20),
    Provider_Enumeration_Date DATE,
    Last_Update_Date DATE,
    NPI_Deactivation_Reason_Code VARCHAR(2),
    NPI_Deactivation_Date DATE,
    NPI_Reactivation_Date DATE,
    Provider_Gender_Code VARCHAR(1),
    Authorized_Official_Last_Name VARCHAR(35),
    Authorized_Official_First_Name VARCHAR(20),
    Authorized_Official_Middle_Name VARCHAR(20),
    Authorized_Official_Title_or_Position VARCHAR(35),
    Authorized_Official_Telephone_Number VARCHAR(20),
    Healthcare_Provider_Taxonomy_Code_1 VARCHAR(10),
    Provider_License_Number_1 VARCHAR(20),
    Provider_License_Number_State_Code_1 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_1 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_2 VARCHAR(10),
    Provider_License_Number_2 VARCHAR(20),
    Provider_License_Number_State_Code_2 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_2 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_3 VARCHAR(10),
    Provider_License_Number_3 VARCHAR(20),
    Provider_License_Number_State_Code_3 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_3 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_4 VARCHAR(10),
    Provider_License_Number_4 VARCHAR(20),
    Provider_License_Number_State_Code_4 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_4 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_5 VARCHAR(10),
    Provider_License_Number_5 VARCHAR(20),
    Provider_License_Number_State_Code_5 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_5 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_6 VARCHAR(10),
    Provider_License_Number_6 VARCHAR(20),
    Provider_License_Number_State_Code_6 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_6 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_7 VARCHAR(10),
    Provider_License_Number_7 VARCHAR(20),
    Provider_License_Number_State_Code_7 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_7 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_8 VARCHAR(10),
    Provider_License_Number_8 VARCHAR(20),
    Provider_License_Number_State_Code_8 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_8 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_9 VARCHAR(10),
    Provider_License_Number_9 VARCHAR(20),
    Provider_License_Number_State_Code_9 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_9 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_10 VARCHAR(10),
    Provider_License_Number_10 VARCHAR(20),
    Provider_License_Number_State_Code_10 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_10 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_11 VARCHAR(10),
    Provider_License_Number_11 VARCHAR(20),
    Provider_License_Number_State_Code_11 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_11 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_12 VARCHAR(10),
    Provider_License_Number_12 VARCHAR(20),
    Provider_License_Number_State_Code_12 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_12 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_13 VARCHAR(10),
    Provider_License_Number_13 VARCHAR(20),
    Provider_License_Number_State_Code_13 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_13 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_14 VARCHAR(10),
    Provider_License_Number_14 VARCHAR(20),
    Provider_License_Number_State_Code_14 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_14 VARCHAR(1),
    Healthcare_Provider_Taxonomy_Code_15 VARCHAR(10),
    Provider_License_Number_15 VARCHAR(20),
    Provider_License_Number_State_Code_15 VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch_15 VARCHAR(1),
    Other_Provider_Identifier_1 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_1 VARCHAR(2),
    Other_Provider_Identifier_State_1 VARCHAR(2),
    Other_Provider_Identifier_Issuer_1 VARCHAR(80),
    Other_Provider_Identifier_2 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_2 VARCHAR(2),
    Other_Provider_Identifier_State_2 VARCHAR(2),
    Other_Provider_Identifier_Issuer_2 VARCHAR(80),
    Other_Provider_Identifier_3 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_3 VARCHAR(2),
    Other_Provider_Identifier_State_3 VARCHAR(2),
    Other_Provider_Identifier_Issuer_3 VARCHAR(80),
    Other_Provider_Identifier_4 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_4 VARCHAR(2),
    Other_Provider_Identifier_State_4 VARCHAR(2),
    Other_Provider_Identifier_Issuer_4 VARCHAR(80),
    Other_Provider_Identifier_5 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_5 VARCHAR(2),
    Other_Provider_Identifier_State_5 VARCHAR(2),
    Other_Provider_Identifier_Issuer_5 VARCHAR(80),
    Other_Provider_Identifier_6 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_6 VARCHAR(2),
    Other_Provider_Identifier_State_6 VARCHAR(2),
    Other_Provider_Identifier_Issuer_6 VARCHAR(80),
    Other_Provider_Identifier_7 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_7 VARCHAR(2),
    Other_Provider_Identifier_State_7 VARCHAR(2),
    Other_Provider_Identifier_Issuer_7 VARCHAR(80),
    Other_Provider_Identifier_8 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_8 VARCHAR(2),
    Other_Provider_Identifier_State_8 VARCHAR(2),
    Other_Provider_Identifier_Issuer_8 VARCHAR(80),
    Other_Provider_Identifier_9 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_9 VARCHAR(2),
    Other_Provider_Identifier_State_9 VARCHAR(2),
    Other_Provider_Identifier_Issuer_9 VARCHAR(80),
    Other_Provider_Identifier_10 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_10 VARCHAR(2),
    Other_Provider_Identifier_State_10 VARCHAR(2),
    Other_Provider_Identifier_Issuer_10 VARCHAR(80),
    Other_Provider_Identifier_11 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_11 VARCHAR(2),
    Other_Provider_Identifier_State_11 VARCHAR(2),
    Other_Provider_Identifier_Issuer_11 VARCHAR(80),
    Other_Provider_Identifier_12 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_12 VARCHAR(2),
    Other_Provider_Identifier_State_12 VARCHAR(2),
    Other_Provider_Identifier_Issuer_12 VARCHAR(80),
    Other_Provider_Identifier_13 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_13 VARCHAR(2),
    Other_Provider_Identifier_State_13 VARCHAR(2),
    Other_Provider_Identifier_Issuer_13 VARCHAR(80),
    Other_Provider_Identifier_14 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_14 VARCHAR(2),
    Other_Provider_Identifier_State_14 VARCHAR(2),
    Other_Provider_Identifier_Issuer_14 VARCHAR(80),
    Other_Provider_Identifier_15 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_15 VARCHAR(2),
    Other_Provider_Identifier_State_15 VARCHAR(2),
    Other_Provider_Identifier_Issuer_15 VARCHAR(80),
    Other_Provider_Identifier_16 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_16 VARCHAR(2),
    Other_Provider_Identifier_State_16 VARCHAR(2),
    Other_Provider_Identifier_Issuer_16 VARCHAR(80),
    Other_Provider_Identifier_17 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_17 VARCHAR(2),
    Other_Provider_Identifier_State_17 VARCHAR(2),
    Other_Provider_Identifier_Issuer_17 VARCHAR(80),
    Other_Provider_Identifier_18 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_18 VARCHAR(2),
    Other_Provider_Identifier_State_18 VARCHAR(2),
    Other_Provider_Identifier_Issuer_18 VARCHAR(80),
    Other_Provider_Identifier_19 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_19 VARCHAR(2),
    Other_Provider_Identifier_State_19 VARCHAR(2),
    Other_Provider_Identifier_Issuer_19 VARCHAR(80),
    Other_Provider_Identifier_20 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_20 VARCHAR(2),
    Other_Provider_Identifier_State_20 VARCHAR(2),
    Other_Provider_Identifier_Issuer_20 VARCHAR(80),
    Other_Provider_Identifier_21 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_21 VARCHAR(2),
    Other_Provider_Identifier_State_21 VARCHAR(2),
    Other_Provider_Identifier_Issuer_21 VARCHAR(80),
    Other_Provider_Identifier_22 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_22 VARCHAR(2),
    Other_Provider_Identifier_State_22 VARCHAR(2),
    Other_Provider_Identifier_Issuer_22 VARCHAR(80),
    Other_Provider_Identifier_23 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_23 VARCHAR(2),
    Other_Provider_Identifier_State_23 VARCHAR(2),
    Other_Provider_Identifier_Issuer_23 VARCHAR(80),
    Other_Provider_Identifier_24 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_24 VARCHAR(2),
    Other_Provider_Identifier_State_24 VARCHAR(2),
    Other_Provider_Identifier_Issuer_24 VARCHAR(80),
    Other_Provider_Identifier_25 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_25 VARCHAR(2),
    Other_Provider_Identifier_State_25 VARCHAR(2),
    Other_Provider_Identifier_Issuer_25 VARCHAR(80),
    Other_Provider_Identifier_26 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_26 VARCHAR(2),
    Other_Provider_Identifier_State_26 VARCHAR(2),
    Other_Provider_Identifier_Issuer_26 VARCHAR(80),
    Other_Provider_Identifier_27 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_27 VARCHAR(2),
    Other_Provider_Identifier_State_27 VARCHAR(2),
    Other_Provider_Identifier_Issuer_27 VARCHAR(80),
    Other_Provider_Identifier_28 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_28 VARCHAR(2),
    Other_Provider_Identifier_State_28 VARCHAR(2),
    Other_Provider_Identifier_Issuer_28 VARCHAR(80),
    Other_Provider_Identifier_29 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_29 VARCHAR(2),
    Other_Provider_Identifier_State_29 VARCHAR(2),
    Other_Provider_Identifier_Issuer_29 VARCHAR(80),
    Other_Provider_Identifier_30 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_30 VARCHAR(2),
    Other_Provider_Identifier_State_30 VARCHAR(2),
    Other_Provider_Identifier_Issuer_30 VARCHAR(80),
    Other_Provider_Identifier_31 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_31 VARCHAR(2),
    Other_Provider_Identifier_State_31 VARCHAR(2),
    Other_Provider_Identifier_Issuer_31 VARCHAR(80),
    Other_Provider_Identifier_32 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_32 VARCHAR(2),
    Other_Provider_Identifier_State_32 VARCHAR(2),
    Other_Provider_Identifier_Issuer_32 VARCHAR(80),
    Other_Provider_Identifier_33 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_33 VARCHAR(2),
    Other_Provider_Identifier_State_33 VARCHAR(2),
    Other_Provider_Identifier_Issuer_33 VARCHAR(80),
    Other_Provider_Identifier_34 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_34 VARCHAR(2),
    Other_Provider_Identifier_State_34 VARCHAR(2),
    Other_Provider_Identifier_Issuer_34 VARCHAR(80),
    Other_Provider_Identifier_35 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_35 VARCHAR(2),
    Other_Provider_Identifier_State_35 VARCHAR(2),
    Other_Provider_Identifier_Issuer_35 VARCHAR(80),
    Other_Provider_Identifier_36 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_36 VARCHAR(2),
    Other_Provider_Identifier_State_36 VARCHAR(2),
    Other_Provider_Identifier_Issuer_36 VARCHAR(80),
    Other_Provider_Identifier_37 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_37 VARCHAR(2),
    Other_Provider_Identifier_State_37 VARCHAR(2),
    Other_Provider_Identifier_Issuer_37 VARCHAR(80),
    Other_Provider_Identifier_38 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_38 VARCHAR(2),
    Other_Provider_Identifier_State_38 VARCHAR(2),
    Other_Provider_Identifier_Issuer_38 VARCHAR(80),
    Other_Provider_Identifier_39 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_39 VARCHAR(2),
    Other_Provider_Identifier_State_39 VARCHAR(2),
    Other_Provider_Identifier_Issuer_39 VARCHAR(80),
    Other_Provider_Identifier_40 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_40 VARCHAR(2),
    Other_Provider_Identifier_State_40 VARCHAR(2),
    Other_Provider_Identifier_Issuer_40 VARCHAR(80),
    Other_Provider_Identifier_41 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_41 VARCHAR(2),
    Other_Provider_Identifier_State_41 VARCHAR(2),
    Other_Provider_Identifier_Issuer_41 VARCHAR(80),
    Other_Provider_Identifier_42 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_42 VARCHAR(2),
    Other_Provider_Identifier_State_42 VARCHAR(2),
    Other_Provider_Identifier_Issuer_42 VARCHAR(80),
    Other_Provider_Identifier_43 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_43 VARCHAR(2),
    Other_Provider_Identifier_State_43 VARCHAR(2),
    Other_Provider_Identifier_Issuer_43 VARCHAR(80),
    Other_Provider_Identifier_44 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_44 VARCHAR(2),
    Other_Provider_Identifier_State_44 VARCHAR(2),
    Other_Provider_Identifier_Issuer_44 VARCHAR(80),
    Other_Provider_Identifier_45 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_45 VARCHAR(2),
    Other_Provider_Identifier_State_45 VARCHAR(2),
    Other_Provider_Identifier_Issuer_45 VARCHAR(80),
    Other_Provider_Identifier_46 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_46 VARCHAR(2),
    Other_Provider_Identifier_State_46 VARCHAR(2),
    Other_Provider_Identifier_Issuer_46 VARCHAR(80),
    Other_Provider_Identifier_47 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_47 VARCHAR(2),
    Other_Provider_Identifier_State_47 VARCHAR(2),
    Other_Provider_Identifier_Issuer_47 VARCHAR(80),
    Other_Provider_Identifier_48 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_48 VARCHAR(2),
    Other_Provider_Identifier_State_48 VARCHAR(2),
    Other_Provider_Identifier_Issuer_48 VARCHAR(80),
    Other_Provider_Identifier_49 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_49 VARCHAR(2),
    Other_Provider_Identifier_State_49 VARCHAR(2),
    Other_Provider_Identifier_Issuer_49 VARCHAR(80),
    Other_Provider_Identifier_50 VARCHAR(20),
    Other_Provider_Identifier_Type_Code_50 VARCHAR(2),
    Other_Provider_Identifier_State_50 VARCHAR(2),
    Other_Provider_Identifier_Issuer_50 VARCHAR(80),
    Is_Sole_Proprietor VARCHAR(1),
    Is_Organization_Subpart VARCHAR(1),
    Parent_Organization_LBN VARCHAR(70),
    Parent_Organization_TIN VARCHAR(9),
    Authorized_Official_Name_Prefix_Text VARCHAR(5),
    Authorized_Official_Name_Suffix_Text VARCHAR(5),
    Authorized_Official_Credential_Text VARCHAR(20))
;

LOAD DATA INFILE '/data/npi/npidata_20050523-20130113.csv' INTO TABLE NPPES_flat
      FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\0'
      LINES TERMINATED BY '\n'
      IGNORE 1 LINES
       (@NPI,@Entity_Type_Code,@Replacement_NPI,@Employer_Identification_Number_EIN,@Provider_Organization_Name_Legal_Business_Name,@Provider_Last_Name_Legal_Name,@Provider_First_Name,@Provider_Middle_Name,@Provider_Name_Prefix_Text,@Provider_Name_Suffix_Text,@Provider_Credential_Text,@Provider_Other_Organization_Name,@Provider_Other_Organization_Name_Type_Code,@Provider_Other_Last_Name,@Provider_Other_First_Name,@Provider_Other_Middle_Name,@Provider_Other_Name_Prefix_Text,@Provider_Other_Name_Suffix_Text,@Provider_Other_Credential_Text,@Provider_Other_Last_Name_Type_Code,@Provider_First_Line_Business_Mailing_Address,@Provider_Second_Line_Business_Mailing_Address,@Provider_Business_Mailing_Address_City_Name,@Provider_Business_Mailing_Address_State_Name,@Provider_Business_Mailing_Address_Postal_Code,@Provider_Business_Mailing_Address_Country_Cod,@Provider_Business_Mailing_Address_Telephone_Number,@Provider_Business_Mailing_Address_Fax_Number,@Provider_First_Line_Business_Practice_Location_Address,@Provider_Second_Line_Business_Practice_Location_Address,@Provider_Business_Practice_Location_Address_City_Name,@Provider_Business_Practice_Location_Address_State_Name,@Provider_Business_Practice_Location_Address_Postal_Code,@Provider_Business_Practice_Location_Address_Country_Cod,@Provider_Business_Practice_Location_Address_Telephone_Number,@Provider_Business_Practice_Location_Address_Fax_Number,@Provider_Enumeration_Date,@Last_Update_Date,@NPI_Deactivation_Reason_Code,@NPI_Deactivation_Date,@NPI_Reactivation_Date,@Provider_Gender_Code,@Authorized_Official_Last_Name,@Authorized_Official_First_Name,@Authorized_Official_Middle_Name,@Authorized_Official_Title_or_Position,@Authorized_Official_Telephone_Number,@Healthcare_Provider_Taxonomy_Code_1,@Provider_License_Number_1,@Provider_License_Number_State_Code_1,@Healthcare_Provider_Primary_Taxonomy_Switch_1,@Healthcare_Provider_Taxonomy_Code_2,@Provider_License_Number_2,@Provider_License_Number_State_Code_2,@Healthcare_Provider_Primary_Taxonomy_Switch_2,@Healthcare_Provider_Taxonomy_Code_3,@Provider_License_Number_3,@Provider_License_Number_State_Code_3,@Healthcare_Provider_Primary_Taxonomy_Switch_3,@Healthcare_Provider_Taxonomy_Code_4,@Provider_License_Number_4,@Provider_License_Number_State_Code_4,@Healthcare_Provider_Primary_Taxonomy_Switch_4,@Healthcare_Provider_Taxonomy_Code_5,@Provider_License_Number_5,@Provider_License_Number_State_Code_5,@Healthcare_Provider_Primary_Taxonomy_Switch_5,@Healthcare_Provider_Taxonomy_Code_6,@Provider_License_Number_6,@Provider_License_Number_State_Code_6,@Healthcare_Provider_Primary_Taxonomy_Switch_6,@Healthcare_Provider_Taxonomy_Code_7,@Provider_License_Number_7,@Provider_License_Number_State_Code_7,@Healthcare_Provider_Primary_Taxonomy_Switch_7,@Healthcare_Provider_Taxonomy_Code_8,@Provider_License_Number_8,@Provider_License_Number_State_Code_8,@Healthcare_Provider_Primary_Taxonomy_Switch_8,@Healthcare_Provider_Taxonomy_Code_9,@Provider_License_Number_9,@Provider_License_Number_State_Code_9,@Healthcare_Provider_Primary_Taxonomy_Switch_9,@Healthcare_Provider_Taxonomy_Code_10,@Provider_License_Number_10,@Provider_License_Number_State_Code_10,@Healthcare_Provider_Primary_Taxonomy_Switch_10,@Healthcare_Provider_Taxonomy_Code_11,@Provider_License_Number_11,@Provider_License_Number_State_Code_11,@Healthcare_Provider_Primary_Taxonomy_Switch_11,@Healthcare_Provider_Taxonomy_Code_12,@Provider_License_Number_12,@Provider_License_Number_State_Code_12,@Healthcare_Provider_Primary_Taxonomy_Switch_12,@Healthcare_Provider_Taxonomy_Code_13,@Provider_License_Number_13,@Provider_License_Number_State_Code_13,@Healthcare_Provider_Primary_Taxonomy_Switch_13,@Healthcare_Provider_Taxonomy_Code_14,@Provider_License_Number_14,@Provider_License_Number_State_Code_14,@Healthcare_Provider_Primary_Taxonomy_Switch_14,@Healthcare_Provider_Taxonomy_Code_15,@Provider_License_Number_15,@Provider_License_Number_State_Code_15,@Healthcare_Provider_Primary_Taxonomy_Switch_15,@Other_Provider_Identifier_1,@Other_Provider_Identifier_Type_Code_1,@Other_Provider_Identifier_State_1,@Other_Provider_Identifier_Issuer_1,@Other_Provider_Identifier_2,@Other_Provider_Identifier_Type_Code_2,@Other_Provider_Identifier_State_2,@Other_Provider_Identifier_Issuer_2,@Other_Provider_Identifier_3,@Other_Provider_Identifier_Type_Code_3,@Other_Provider_Identifier_State_3,@Other_Provider_Identifier_Issuer_3,@Other_Provider_Identifier_4,@Other_Provider_Identifier_Type_Code_4,@Other_Provider_Identifier_State_4,@Other_Provider_Identifier_Issuer_4,@Other_Provider_Identifier_5,@Other_Provider_Identifier_Type_Code_5,@Other_Provider_Identifier_State_5,@Other_Provider_Identifier_Issuer_5,@Other_Provider_Identifier_6,@Other_Provider_Identifier_Type_Code_6,@Other_Provider_Identifier_State_6,@Other_Provider_Identifier_Issuer_6,@Other_Provider_Identifier_7,@Other_Provider_Identifier_Type_Code_7,@Other_Provider_Identifier_State_7,@Other_Provider_Identifier_Issuer_7,@Other_Provider_Identifier_8,@Other_Provider_Identifier_Type_Code_8,@Other_Provider_Identifier_State_8,@Other_Provider_Identifier_Issuer_8,@Other_Provider_Identifier_9,@Other_Provider_Identifier_Type_Code_9,@Other_Provider_Identifier_State_9,@Other_Provider_Identifier_Issuer_9,@Other_Provider_Identifier_10,@Other_Provider_Identifier_Type_Code_10,@Other_Provider_Identifier_State_10,@Other_Provider_Identifier_Issuer_10,@Other_Provider_Identifier_11,@Other_Provider_Identifier_Type_Code_11,@Other_Provider_Identifier_State_11,@Other_Provider_Identifier_Issuer_11,@Other_Provider_Identifier_12,@Other_Provider_Identifier_Type_Code_12,@Other_Provider_Identifier_State_12,@Other_Provider_Identifier_Issuer_12,@Other_Provider_Identifier_13,@Other_Provider_Identifier_Type_Code_13,@Other_Provider_Identifier_State_13,@Other_Provider_Identifier_Issuer_13,@Other_Provider_Identifier_14,@Other_Provider_Identifier_Type_Code_14,@Other_Provider_Identifier_State_14,@Other_Provider_Identifier_Issuer_14,@Other_Provider_Identifier_15,@Other_Provider_Identifier_Type_Code_15,@Other_Provider_Identifier_State_15,@Other_Provider_Identifier_Issuer_15,@Other_Provider_Identifier_16,@Other_Provider_Identifier_Type_Code_16,@Other_Provider_Identifier_State_16,@Other_Provider_Identifier_Issuer_16,@Other_Provider_Identifier_17,@Other_Provider_Identifier_Type_Code_17,@Other_Provider_Identifier_State_17,@Other_Provider_Identifier_Issuer_17,@Other_Provider_Identifier_18,@Other_Provider_Identifier_Type_Code_18,@Other_Provider_Identifier_State_18,@Other_Provider_Identifier_Issuer_18,@Other_Provider_Identifier_19,@Other_Provider_Identifier_Type_Code_19,@Other_Provider_Identifier_State_19,@Other_Provider_Identifier_Issuer_19,@Other_Provider_Identifier_20,@Other_Provider_Identifier_Type_Code_20,@Other_Provider_Identifier_State_20,@Other_Provider_Identifier_Issuer_20,@Other_Provider_Identifier_21,@Other_Provider_Identifier_Type_Code_21,@Other_Provider_Identifier_State_21,@Other_Provider_Identifier_Issuer_21,@Other_Provider_Identifier_22,@Other_Provider_Identifier_Type_Code_22,@Other_Provider_Identifier_State_22,@Other_Provider_Identifier_Issuer_22,@Other_Provider_Identifier_23,@Other_Provider_Identifier_Type_Code_23,@Other_Provider_Identifier_State_23,@Other_Provider_Identifier_Issuer_23,@Other_Provider_Identifier_24,@Other_Provider_Identifier_Type_Code_24,@Other_Provider_Identifier_State_24,@Other_Provider_Identifier_Issuer_24,@Other_Provider_Identifier_25,@Other_Provider_Identifier_Type_Code_25,@Other_Provider_Identifier_State_25,@Other_Provider_Identifier_Issuer_25,@Other_Provider_Identifier_26,@Other_Provider_Identifier_Type_Code_26,@Other_Provider_Identifier_State_26,@Other_Provider_Identifier_Issuer_26,@Other_Provider_Identifier_27,@Other_Provider_Identifier_Type_Code_27,@Other_Provider_Identifier_State_27,@Other_Provider_Identifier_Issuer_27,@Other_Provider_Identifier_28,@Other_Provider_Identifier_Type_Code_28,@Other_Provider_Identifier_State_28,@Other_Provider_Identifier_Issuer_28,@Other_Provider_Identifier_29,@Other_Provider_Identifier_Type_Code_29,@Other_Provider_Identifier_State_29,@Other_Provider_Identifier_Issuer_29,@Other_Provider_Identifier_30,@Other_Provider_Identifier_Type_Code_30,@Other_Provider_Identifier_State_30,@Other_Provider_Identifier_Issuer_30,@Other_Provider_Identifier_31,@Other_Provider_Identifier_Type_Code_31,@Other_Provider_Identifier_State_31,@Other_Provider_Identifier_Issuer_31,@Other_Provider_Identifier_32,@Other_Provider_Identifier_Type_Code_32,@Other_Provider_Identifier_State_32,@Other_Provider_Identifier_Issuer_32,@Other_Provider_Identifier_33,@Other_Provider_Identifier_Type_Code_33,@Other_Provider_Identifier_State_33,@Other_Provider_Identifier_Issuer_33,@Other_Provider_Identifier_34,@Other_Provider_Identifier_Type_Code_34,@Other_Provider_Identifier_State_34,@Other_Provider_Identifier_Issuer_34,@Other_Provider_Identifier_35,@Other_Provider_Identifier_Type_Code_35,@Other_Provider_Identifier_State_35,@Other_Provider_Identifier_Issuer_35,@Other_Provider_Identifier_36,@Other_Provider_Identifier_Type_Code_36,@Other_Provider_Identifier_State_36,@Other_Provider_Identifier_Issuer_36,@Other_Provider_Identifier_37,@Other_Provider_Identifier_Type_Code_37,@Other_Provider_Identifier_State_37,@Other_Provider_Identifier_Issuer_37,@Other_Provider_Identifier_38,@Other_Provider_Identifier_Type_Code_38,@Other_Provider_Identifier_State_38,@Other_Provider_Identifier_Issuer_38,@Other_Provider_Identifier_39,@Other_Provider_Identifier_Type_Code_39,@Other_Provider_Identifier_State_39,@Other_Provider_Identifier_Issuer_39,@Other_Provider_Identifier_40,@Other_Provider_Identifier_Type_Code_40,@Other_Provider_Identifier_State_40,@Other_Provider_Identifier_Issuer_40,@Other_Provider_Identifier_41,@Other_Provider_Identifier_Type_Code_41,@Other_Provider_Identifier_State_41,@Other_Provider_Identifier_Issuer_41,@Other_Provider_Identifier_42,@Other_Provider_Identifier_Type_Code_42,@Other_Provider_Identifier_State_42,@Other_Provider_Identifier_Issuer_42,@Other_Provider_Identifier_43,@Other_Provider_Identifier_Type_Code_43,@Other_Provider_Identifier_State_43,@Other_Provider_Identifier_Issuer_43,@Other_Provider_Identifier_44,@Other_Provider_Identifier_Type_Code_44,@Other_Provider_Identifier_State_44,@Other_Provider_Identifier_Issuer_44,@Other_Provider_Identifier_45,@Other_Provider_Identifier_Type_Code_45,@Other_Provider_Identifier_State_45,@Other_Provider_Identifier_Issuer_45,@Other_Provider_Identifier_46,@Other_Provider_Identifier_Type_Code_46,@Other_Provider_Identifier_State_46,@Other_Provider_Identifier_Issuer_46,@Other_Provider_Identifier_47,@Other_Provider_Identifier_Type_Code_47,@Other_Provider_Identifier_State_47,@Other_Provider_Identifier_Issuer_47,@Other_Provider_Identifier_48,@Other_Provider_Identifier_Type_Code_48,@Other_Provider_Identifier_State_48,@Other_Provider_Identifier_Issuer_48,@Other_Provider_Identifier_49,@Other_Provider_Identifier_Type_Code_49,@Other_Provider_Identifier_State_49,@Other_Provider_Identifier_Issuer_49,@Other_Provider_Identifier_50,@Other_Provider_Identifier_Type_Code_50,@Other_Provider_Identifier_State_50,@Other_Provider_Identifier_Issuer_50,@Is_Sole_Proprietor,@Is_Organization_Subpart,@Parent_Organization_LBN,@Parent_Organization_TIN,@Authorized_Official_Name_Prefix_Text,@Authorized_Official_Name_Suffix_Text,@Authorized_Official_Credential_Text)
       set
       NPI = case @NPI when '' then NULL else @NPI end,
Entity_Type_Code = case @Entity_Type_Code when '' then NULL else @Entity_Type_Code end,
Replacement_NPI = case @Replacement_NPI when '' then NULL else @Replacement_NPI end,
Employer_Identification_Number_EIN = case @Employer_Identification_Number_EIN when '' then NULL else @Employer_Identification_Number_EIN end,
Provider_Organization_Name_Legal_Business_Name = case @Provider_Organization_Name_Legal_Business_Name when '' then NULL else @Provider_Organization_Name_Legal_Business_Name end,
Provider_Last_Name_Legal_Name = case @Provider_Last_Name_Legal_Name when '' then NULL else @Provider_Last_Name_Legal_Name end,
Provider_First_Name = case @Provider_First_Name when '' then NULL else @Provider_First_Name end,
Provider_Middle_Name = case @Provider_Middle_Name when '' then NULL else @Provider_Middle_Name end,
Provider_Name_Prefix_Text = case @Provider_Name_Prefix_Text when '' then NULL else @Provider_Name_Prefix_Text end,
Provider_Name_Suffix_Text = case @Provider_Name_Suffix_Text when '' then NULL else @Provider_Name_Suffix_Text end,
Provider_Credential_Text = case @Provider_Credential_Text when '' then NULL else @Provider_Credential_Text end,
Provider_Other_Organization_Name = case @Provider_Other_Organization_Name when '' then NULL else @Provider_Other_Organization_Name end,
Provider_Other_Organization_Name_Type_Code = case @Provider_Other_Organization_Name_Type_Code when '' then NULL else @Provider_Other_Organization_Name_Type_Code end,
Provider_Other_Last_Name = case @Provider_Other_Last_Name when '' then NULL else @Provider_Other_Last_Name end,
Provider_Other_First_Name = case @Provider_Other_First_Name when '' then NULL else @Provider_Other_First_Name end,
Provider_Other_Middle_Name = case @Provider_Other_Middle_Name when '' then NULL else @Provider_Other_Middle_Name end,
Provider_Other_Name_Prefix_Text = case @Provider_Other_Name_Prefix_Text when '' then NULL else @Provider_Other_Name_Prefix_Text end,
Provider_Other_Name_Suffix_Text = case @Provider_Other_Name_Suffix_Text when '' then NULL else @Provider_Other_Name_Suffix_Text end,
Provider_Other_Credential_Text = case @Provider_Other_Credential_Text when '' then NULL else @Provider_Other_Credential_Text end,
Provider_Other_Last_Name_Type_Code = case @Provider_Other_Last_Name_Type_Code when '' then NULL else @Provider_Other_Last_Name_Type_Code end,
Provider_First_Line_Business_Mailing_Address = case @Provider_First_Line_Business_Mailing_Address when '' then NULL else @Provider_First_Line_Business_Mailing_Address end,
Provider_Second_Line_Business_Mailing_Address = case @Provider_Second_Line_Business_Mailing_Address when '' then NULL else @Provider_Second_Line_Business_Mailing_Address end,
Provider_Business_Mailing_Address_City_Name = case @Provider_Business_Mailing_Address_City_Name when '' then NULL else @Provider_Business_Mailing_Address_City_Name end,
Provider_Business_Mailing_Address_State_Name = case @Provider_Business_Mailing_Address_State_Name when '' then NULL else @Provider_Business_Mailing_Address_State_Name end,
Provider_Business_Mailing_Address_Postal_Code = case @Provider_Business_Mailing_Address_Postal_Code when '' then NULL else @Provider_Business_Mailing_Address_Postal_Code end,
Provider_Business_Mailing_Address_Country_Cod = case @Provider_Business_Mailing_Address_Country_Cod when '' then NULL else @Provider_Business_Mailing_Address_Country_Cod end,
Provider_Business_Mailing_Address_Telephone_Number = case @Provider_Business_Mailing_Address_Telephone_Number when '' then NULL else @Provider_Business_Mailing_Address_Telephone_Number end,
Provider_Business_Mailing_Address_Fax_Number = case @Provider_Business_Mailing_Address_Fax_Number when '' then NULL else @Provider_Business_Mailing_Address_Fax_Number end,
Provider_First_Line_Business_Practice_Location_Address = case @Provider_First_Line_Business_Practice_Location_Address when '' then NULL else @Provider_First_Line_Business_Practice_Location_Address end,
Provider_Second_Line_Business_Practice_Location_Address = case @Provider_Second_Line_Business_Practice_Location_Address when '' then NULL else @Provider_Second_Line_Business_Practice_Location_Address end,
Provider_Business_Practice_Location_Address_City_Name = case @Provider_Business_Practice_Location_Address_City_Name when '' then NULL else @Provider_Business_Practice_Location_Address_City_Name end,
Provider_Business_Practice_Location_Address_State_Name = case @Provider_Business_Practice_Location_Address_State_Name when '' then NULL else @Provider_Business_Practice_Location_Address_State_Name end,
Provider_Business_Practice_Location_Address_Postal_Code = case @Provider_Business_Practice_Location_Address_Postal_Code when '' then NULL else @Provider_Business_Practice_Location_Address_Postal_Code end,
Provider_Business_Practice_Location_Address_Country_Cod = case @Provider_Business_Practice_Location_Address_Country_Cod when '' then NULL else @Provider_Business_Practice_Location_Address_Country_Cod end,
Provider_Business_Practice_Location_Address_Telephone_Number = case @Provider_Business_Practice_Location_Address_Telephone_Number when '' then NULL else @Provider_Business_Practice_Location_Address_Telephone_Number end,
Provider_Business_Practice_Location_Address_Fax_Number = case @Provider_Business_Practice_Location_Address_Fax_Number when '' then NULL else @Provider_Business_Practice_Location_Address_Fax_Number end,
Provider_Enumeration_Date = case @Provider_Enumeration_Date when '' then NULL else str_to_date(@Provider_Enumeration_Date, '%m/%d/%Y') end,
Last_Update_Date = case @Last_Update_Date when '' then NULL else str_to_date(@Last_Update_Date, '%m/%d/%Y') end,
NPI_Deactivation_Reason_Code = case @NPI_Deactivation_Reason_Code when '' then NULL else @NPI_Deactivation_Reason_Code end,
NPI_Deactivation_Date = case @NPI_Deactivation_Date when '' then NULL else str_to_date(@NPI_Deactivation_Date, '%m/%d/%Y') end,
NPI_Reactivation_Date = case @NPI_Reactivation_Date when '' then NULL else str_to_date(@NPI_Reactivation_Date, '%m/%d/%Y') end,
Provider_Gender_Code = case @Provider_Gender_Code when '' then NULL else @Provider_Gender_Code end,
Authorized_Official_Last_Name = case @Authorized_Official_Last_Name when '' then NULL else @Authorized_Official_Last_Name end,
Authorized_Official_First_Name = case @Authorized_Official_First_Name when '' then NULL else @Authorized_Official_First_Name end,
Authorized_Official_Middle_Name = case @Authorized_Official_Middle_Name when '' then NULL else @Authorized_Official_Middle_Name end,
Authorized_Official_Title_or_Position = case @Authorized_Official_Title_or_Position when '' then NULL else @Authorized_Official_Title_or_Position end,
Authorized_Official_Telephone_Number = case @Authorized_Official_Telephone_Number when '' then NULL else @Authorized_Official_Telephone_Number end,
Healthcare_Provider_Taxonomy_Code_1 = case @Healthcare_Provider_Taxonomy_Code_1 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_1 end,
Provider_License_Number_1 = case @Provider_License_Number_1 when '' then NULL else @Provider_License_Number_1 end,
Provider_License_Number_State_Code_1 = case @Provider_License_Number_State_Code_1 when '' then NULL else @Provider_License_Number_State_Code_1 end,
Healthcare_Provider_Primary_Taxonomy_Switch_1 = case @Healthcare_Provider_Primary_Taxonomy_Switch_1 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_1 end,
Healthcare_Provider_Taxonomy_Code_2 = case @Healthcare_Provider_Taxonomy_Code_2 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_2 end,
Provider_License_Number_2 = case @Provider_License_Number_2 when '' then NULL else @Provider_License_Number_2 end,
Provider_License_Number_State_Code_2 = case @Provider_License_Number_State_Code_2 when '' then NULL else @Provider_License_Number_State_Code_2 end,
Healthcare_Provider_Primary_Taxonomy_Switch_2 = case @Healthcare_Provider_Primary_Taxonomy_Switch_2 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_2 end,
Healthcare_Provider_Taxonomy_Code_3 = case @Healthcare_Provider_Taxonomy_Code_3 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_3 end,
Provider_License_Number_3 = case @Provider_License_Number_3 when '' then NULL else @Provider_License_Number_3 end,
Provider_License_Number_State_Code_3 = case @Provider_License_Number_State_Code_3 when '' then NULL else @Provider_License_Number_State_Code_3 end,
Healthcare_Provider_Primary_Taxonomy_Switch_3 = case @Healthcare_Provider_Primary_Taxonomy_Switch_3 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_3 end,
Healthcare_Provider_Taxonomy_Code_4 = case @Healthcare_Provider_Taxonomy_Code_4 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_4 end,
Provider_License_Number_4 = case @Provider_License_Number_4 when '' then NULL else @Provider_License_Number_4 end,
Provider_License_Number_State_Code_4 = case @Provider_License_Number_State_Code_4 when '' then NULL else @Provider_License_Number_State_Code_4 end,
Healthcare_Provider_Primary_Taxonomy_Switch_4 = case @Healthcare_Provider_Primary_Taxonomy_Switch_4 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_4 end,
Healthcare_Provider_Taxonomy_Code_5 = case @Healthcare_Provider_Taxonomy_Code_5 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_5 end,
Provider_License_Number_5 = case @Provider_License_Number_5 when '' then NULL else @Provider_License_Number_5 end,
Provider_License_Number_State_Code_5 = case @Provider_License_Number_State_Code_5 when '' then NULL else @Provider_License_Number_State_Code_5 end,
Healthcare_Provider_Primary_Taxonomy_Switch_5 = case @Healthcare_Provider_Primary_Taxonomy_Switch_5 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_5 end,
Healthcare_Provider_Taxonomy_Code_6 = case @Healthcare_Provider_Taxonomy_Code_6 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_6 end,
Provider_License_Number_6 = case @Provider_License_Number_6 when '' then NULL else @Provider_License_Number_6 end,
Provider_License_Number_State_Code_6 = case @Provider_License_Number_State_Code_6 when '' then NULL else @Provider_License_Number_State_Code_6 end,
Healthcare_Provider_Primary_Taxonomy_Switch_6 = case @Healthcare_Provider_Primary_Taxonomy_Switch_6 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_6 end,
Healthcare_Provider_Taxonomy_Code_7 = case @Healthcare_Provider_Taxonomy_Code_7 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_7 end,
Provider_License_Number_7 = case @Provider_License_Number_7 when '' then NULL else @Provider_License_Number_7 end,
Provider_License_Number_State_Code_7 = case @Provider_License_Number_State_Code_7 when '' then NULL else @Provider_License_Number_State_Code_7 end,
Healthcare_Provider_Primary_Taxonomy_Switch_7 = case @Healthcare_Provider_Primary_Taxonomy_Switch_7 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_7 end,
Healthcare_Provider_Taxonomy_Code_8 = case @Healthcare_Provider_Taxonomy_Code_8 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_8 end,
Provider_License_Number_8 = case @Provider_License_Number_8 when '' then NULL else @Provider_License_Number_8 end,
Provider_License_Number_State_Code_8 = case @Provider_License_Number_State_Code_8 when '' then NULL else @Provider_License_Number_State_Code_8 end,
Healthcare_Provider_Primary_Taxonomy_Switch_8 = case @Healthcare_Provider_Primary_Taxonomy_Switch_8 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_8 end,
Healthcare_Provider_Taxonomy_Code_9 = case @Healthcare_Provider_Taxonomy_Code_9 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_9 end,
Provider_License_Number_9 = case @Provider_License_Number_9 when '' then NULL else @Provider_License_Number_9 end,
Provider_License_Number_State_Code_9 = case @Provider_License_Number_State_Code_9 when '' then NULL else @Provider_License_Number_State_Code_9 end,
Healthcare_Provider_Primary_Taxonomy_Switch_9 = case @Healthcare_Provider_Primary_Taxonomy_Switch_9 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_9 end,
Healthcare_Provider_Taxonomy_Code_10 = case @Healthcare_Provider_Taxonomy_Code_10 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_10 end,
Provider_License_Number_10 = case @Provider_License_Number_10 when '' then NULL else @Provider_License_Number_10 end,
Provider_License_Number_State_Code_10 = case @Provider_License_Number_State_Code_10 when '' then NULL else @Provider_License_Number_State_Code_10 end,
Healthcare_Provider_Primary_Taxonomy_Switch_10 = case @Healthcare_Provider_Primary_Taxonomy_Switch_10 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_10 end,
Healthcare_Provider_Taxonomy_Code_11 = case @Healthcare_Provider_Taxonomy_Code_11 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_11 end,
Provider_License_Number_11 = case @Provider_License_Number_11 when '' then NULL else @Provider_License_Number_11 end,
Provider_License_Number_State_Code_11 = case @Provider_License_Number_State_Code_11 when '' then NULL else @Provider_License_Number_State_Code_11 end,
Healthcare_Provider_Primary_Taxonomy_Switch_11 = case @Healthcare_Provider_Primary_Taxonomy_Switch_11 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_11 end,
Healthcare_Provider_Taxonomy_Code_12 = case @Healthcare_Provider_Taxonomy_Code_12 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_12 end,
Provider_License_Number_12 = case @Provider_License_Number_12 when '' then NULL else @Provider_License_Number_12 end,
Provider_License_Number_State_Code_12 = case @Provider_License_Number_State_Code_12 when '' then NULL else @Provider_License_Number_State_Code_12 end,
Healthcare_Provider_Primary_Taxonomy_Switch_12 = case @Healthcare_Provider_Primary_Taxonomy_Switch_12 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_12 end,
Healthcare_Provider_Taxonomy_Code_13 = case @Healthcare_Provider_Taxonomy_Code_13 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_13 end,
Provider_License_Number_13 = case @Provider_License_Number_13 when '' then NULL else @Provider_License_Number_13 end,
Provider_License_Number_State_Code_13 = case @Provider_License_Number_State_Code_13 when '' then NULL else @Provider_License_Number_State_Code_13 end,
Healthcare_Provider_Primary_Taxonomy_Switch_13 = case @Healthcare_Provider_Primary_Taxonomy_Switch_13 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_13 end,
Healthcare_Provider_Taxonomy_Code_14 = case @Healthcare_Provider_Taxonomy_Code_14 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_14 end,
Provider_License_Number_14 = case @Provider_License_Number_14 when '' then NULL else @Provider_License_Number_14 end,
Provider_License_Number_State_Code_14 = case @Provider_License_Number_State_Code_14 when '' then NULL else @Provider_License_Number_State_Code_14 end,
Healthcare_Provider_Primary_Taxonomy_Switch_14 = case @Healthcare_Provider_Primary_Taxonomy_Switch_14 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_14 end,
Healthcare_Provider_Taxonomy_Code_15 = case @Healthcare_Provider_Taxonomy_Code_15 when '' then NULL else @Healthcare_Provider_Taxonomy_Code_15 end,
Provider_License_Number_15 = case @Provider_License_Number_15 when '' then NULL else @Provider_License_Number_15 end,
Provider_License_Number_State_Code_15 = case @Provider_License_Number_State_Code_15 when '' then NULL else @Provider_License_Number_State_Code_15 end,
Healthcare_Provider_Primary_Taxonomy_Switch_15 = case @Healthcare_Provider_Primary_Taxonomy_Switch_15 when '' then NULL else @Healthcare_Provider_Primary_Taxonomy_Switch_15 end,
Other_Provider_Identifier_1 = case @Other_Provider_Identifier_1 when '' then NULL else @Other_Provider_Identifier_1 end,
Other_Provider_Identifier_Type_Code_1 = case @Other_Provider_Identifier_Type_Code_1 when '' then NULL else @Other_Provider_Identifier_Type_Code_1 end,
Other_Provider_Identifier_State_1 = case @Other_Provider_Identifier_State_1 when '' then NULL else @Other_Provider_Identifier_State_1 end,
Other_Provider_Identifier_Issuer_1 = case @Other_Provider_Identifier_Issuer_1 when '' then NULL else @Other_Provider_Identifier_Issuer_1 end,
Other_Provider_Identifier_2 = case @Other_Provider_Identifier_2 when '' then NULL else @Other_Provider_Identifier_2 end,
Other_Provider_Identifier_Type_Code_2 = case @Other_Provider_Identifier_Type_Code_2 when '' then NULL else @Other_Provider_Identifier_Type_Code_2 end,
Other_Provider_Identifier_State_2 = case @Other_Provider_Identifier_State_2 when '' then NULL else @Other_Provider_Identifier_State_2 end,
Other_Provider_Identifier_Issuer_2 = case @Other_Provider_Identifier_Issuer_2 when '' then NULL else @Other_Provider_Identifier_Issuer_2 end,
Other_Provider_Identifier_3 = case @Other_Provider_Identifier_3 when '' then NULL else @Other_Provider_Identifier_3 end,
Other_Provider_Identifier_Type_Code_3 = case @Other_Provider_Identifier_Type_Code_3 when '' then NULL else @Other_Provider_Identifier_Type_Code_3 end,
Other_Provider_Identifier_State_3 = case @Other_Provider_Identifier_State_3 when '' then NULL else @Other_Provider_Identifier_State_3 end,
Other_Provider_Identifier_Issuer_3 = case @Other_Provider_Identifier_Issuer_3 when '' then NULL else @Other_Provider_Identifier_Issuer_3 end,
Other_Provider_Identifier_4 = case @Other_Provider_Identifier_4 when '' then NULL else @Other_Provider_Identifier_4 end,
Other_Provider_Identifier_Type_Code_4 = case @Other_Provider_Identifier_Type_Code_4 when '' then NULL else @Other_Provider_Identifier_Type_Code_4 end,
Other_Provider_Identifier_State_4 = case @Other_Provider_Identifier_State_4 when '' then NULL else @Other_Provider_Identifier_State_4 end,
Other_Provider_Identifier_Issuer_4 = case @Other_Provider_Identifier_Issuer_4 when '' then NULL else @Other_Provider_Identifier_Issuer_4 end,
Other_Provider_Identifier_5 = case @Other_Provider_Identifier_5 when '' then NULL else @Other_Provider_Identifier_5 end,
Other_Provider_Identifier_Type_Code_5 = case @Other_Provider_Identifier_Type_Code_5 when '' then NULL else @Other_Provider_Identifier_Type_Code_5 end,
Other_Provider_Identifier_State_5 = case @Other_Provider_Identifier_State_5 when '' then NULL else @Other_Provider_Identifier_State_5 end,
Other_Provider_Identifier_Issuer_5 = case @Other_Provider_Identifier_Issuer_5 when '' then NULL else @Other_Provider_Identifier_Issuer_5 end,
Other_Provider_Identifier_6 = case @Other_Provider_Identifier_6 when '' then NULL else @Other_Provider_Identifier_6 end,
Other_Provider_Identifier_Type_Code_6 = case @Other_Provider_Identifier_Type_Code_6 when '' then NULL else @Other_Provider_Identifier_Type_Code_6 end,
Other_Provider_Identifier_State_6 = case @Other_Provider_Identifier_State_6 when '' then NULL else @Other_Provider_Identifier_State_6 end,
Other_Provider_Identifier_Issuer_6 = case @Other_Provider_Identifier_Issuer_6 when '' then NULL else @Other_Provider_Identifier_Issuer_6 end,
Other_Provider_Identifier_7 = case @Other_Provider_Identifier_7 when '' then NULL else @Other_Provider_Identifier_7 end,
Other_Provider_Identifier_Type_Code_7 = case @Other_Provider_Identifier_Type_Code_7 when '' then NULL else @Other_Provider_Identifier_Type_Code_7 end,
Other_Provider_Identifier_State_7 = case @Other_Provider_Identifier_State_7 when '' then NULL else @Other_Provider_Identifier_State_7 end,
Other_Provider_Identifier_Issuer_7 = case @Other_Provider_Identifier_Issuer_7 when '' then NULL else @Other_Provider_Identifier_Issuer_7 end,
Other_Provider_Identifier_8 = case @Other_Provider_Identifier_8 when '' then NULL else @Other_Provider_Identifier_8 end,
Other_Provider_Identifier_Type_Code_8 = case @Other_Provider_Identifier_Type_Code_8 when '' then NULL else @Other_Provider_Identifier_Type_Code_8 end,
Other_Provider_Identifier_State_8 = case @Other_Provider_Identifier_State_8 when '' then NULL else @Other_Provider_Identifier_State_8 end,
Other_Provider_Identifier_Issuer_8 = case @Other_Provider_Identifier_Issuer_8 when '' then NULL else @Other_Provider_Identifier_Issuer_8 end,
Other_Provider_Identifier_9 = case @Other_Provider_Identifier_9 when '' then NULL else @Other_Provider_Identifier_9 end,
Other_Provider_Identifier_Type_Code_9 = case @Other_Provider_Identifier_Type_Code_9 when '' then NULL else @Other_Provider_Identifier_Type_Code_9 end,
Other_Provider_Identifier_State_9 = case @Other_Provider_Identifier_State_9 when '' then NULL else @Other_Provider_Identifier_State_9 end,
Other_Provider_Identifier_Issuer_9 = case @Other_Provider_Identifier_Issuer_9 when '' then NULL else @Other_Provider_Identifier_Issuer_9 end,
Other_Provider_Identifier_10 = case @Other_Provider_Identifier_10 when '' then NULL else @Other_Provider_Identifier_10 end,
Other_Provider_Identifier_Type_Code_10 = case @Other_Provider_Identifier_Type_Code_10 when '' then NULL else @Other_Provider_Identifier_Type_Code_10 end,
Other_Provider_Identifier_State_10 = case @Other_Provider_Identifier_State_10 when '' then NULL else @Other_Provider_Identifier_State_10 end,
Other_Provider_Identifier_Issuer_10 = case @Other_Provider_Identifier_Issuer_10 when '' then NULL else @Other_Provider_Identifier_Issuer_10 end,
Other_Provider_Identifier_11 = case @Other_Provider_Identifier_11 when '' then NULL else @Other_Provider_Identifier_11 end,
Other_Provider_Identifier_Type_Code_11 = case @Other_Provider_Identifier_Type_Code_11 when '' then NULL else @Other_Provider_Identifier_Type_Code_11 end,
Other_Provider_Identifier_State_11 = case @Other_Provider_Identifier_State_11 when '' then NULL else @Other_Provider_Identifier_State_11 end,
Other_Provider_Identifier_Issuer_11 = case @Other_Provider_Identifier_Issuer_11 when '' then NULL else @Other_Provider_Identifier_Issuer_11 end,
Other_Provider_Identifier_12 = case @Other_Provider_Identifier_12 when '' then NULL else @Other_Provider_Identifier_12 end,
Other_Provider_Identifier_Type_Code_12 = case @Other_Provider_Identifier_Type_Code_12 when '' then NULL else @Other_Provider_Identifier_Type_Code_12 end,
Other_Provider_Identifier_State_12 = case @Other_Provider_Identifier_State_12 when '' then NULL else @Other_Provider_Identifier_State_12 end,
Other_Provider_Identifier_Issuer_12 = case @Other_Provider_Identifier_Issuer_12 when '' then NULL else @Other_Provider_Identifier_Issuer_12 end,
Other_Provider_Identifier_13 = case @Other_Provider_Identifier_13 when '' then NULL else @Other_Provider_Identifier_13 end,
Other_Provider_Identifier_Type_Code_13 = case @Other_Provider_Identifier_Type_Code_13 when '' then NULL else @Other_Provider_Identifier_Type_Code_13 end,
Other_Provider_Identifier_State_13 = case @Other_Provider_Identifier_State_13 when '' then NULL else @Other_Provider_Identifier_State_13 end,
Other_Provider_Identifier_Issuer_13 = case @Other_Provider_Identifier_Issuer_13 when '' then NULL else @Other_Provider_Identifier_Issuer_13 end,
Other_Provider_Identifier_14 = case @Other_Provider_Identifier_14 when '' then NULL else @Other_Provider_Identifier_14 end,
Other_Provider_Identifier_Type_Code_14 = case @Other_Provider_Identifier_Type_Code_14 when '' then NULL else @Other_Provider_Identifier_Type_Code_14 end,
Other_Provider_Identifier_State_14 = case @Other_Provider_Identifier_State_14 when '' then NULL else @Other_Provider_Identifier_State_14 end,
Other_Provider_Identifier_Issuer_14 = case @Other_Provider_Identifier_Issuer_14 when '' then NULL else @Other_Provider_Identifier_Issuer_14 end,
Other_Provider_Identifier_15 = case @Other_Provider_Identifier_15 when '' then NULL else @Other_Provider_Identifier_15 end,
Other_Provider_Identifier_Type_Code_15 = case @Other_Provider_Identifier_Type_Code_15 when '' then NULL else @Other_Provider_Identifier_Type_Code_15 end,
Other_Provider_Identifier_State_15 = case @Other_Provider_Identifier_State_15 when '' then NULL else @Other_Provider_Identifier_State_15 end,
Other_Provider_Identifier_Issuer_15 = case @Other_Provider_Identifier_Issuer_15 when '' then NULL else @Other_Provider_Identifier_Issuer_15 end,
Other_Provider_Identifier_16 = case @Other_Provider_Identifier_16 when '' then NULL else @Other_Provider_Identifier_16 end,
Other_Provider_Identifier_Type_Code_16 = case @Other_Provider_Identifier_Type_Code_16 when '' then NULL else @Other_Provider_Identifier_Type_Code_16 end,
Other_Provider_Identifier_State_16 = case @Other_Provider_Identifier_State_16 when '' then NULL else @Other_Provider_Identifier_State_16 end,
Other_Provider_Identifier_Issuer_16 = case @Other_Provider_Identifier_Issuer_16 when '' then NULL else @Other_Provider_Identifier_Issuer_16 end,
Other_Provider_Identifier_17 = case @Other_Provider_Identifier_17 when '' then NULL else @Other_Provider_Identifier_17 end,
Other_Provider_Identifier_Type_Code_17 = case @Other_Provider_Identifier_Type_Code_17 when '' then NULL else @Other_Provider_Identifier_Type_Code_17 end,
Other_Provider_Identifier_State_17 = case @Other_Provider_Identifier_State_17 when '' then NULL else @Other_Provider_Identifier_State_17 end,
Other_Provider_Identifier_Issuer_17 = case @Other_Provider_Identifier_Issuer_17 when '' then NULL else @Other_Provider_Identifier_Issuer_17 end,
Other_Provider_Identifier_18 = case @Other_Provider_Identifier_18 when '' then NULL else @Other_Provider_Identifier_18 end,
Other_Provider_Identifier_Type_Code_18 = case @Other_Provider_Identifier_Type_Code_18 when '' then NULL else @Other_Provider_Identifier_Type_Code_18 end,
Other_Provider_Identifier_State_18 = case @Other_Provider_Identifier_State_18 when '' then NULL else @Other_Provider_Identifier_State_18 end,
Other_Provider_Identifier_Issuer_18 = case @Other_Provider_Identifier_Issuer_18 when '' then NULL else @Other_Provider_Identifier_Issuer_18 end,
Other_Provider_Identifier_19 = case @Other_Provider_Identifier_19 when '' then NULL else @Other_Provider_Identifier_19 end,
Other_Provider_Identifier_Type_Code_19 = case @Other_Provider_Identifier_Type_Code_19 when '' then NULL else @Other_Provider_Identifier_Type_Code_19 end,
Other_Provider_Identifier_State_19 = case @Other_Provider_Identifier_State_19 when '' then NULL else @Other_Provider_Identifier_State_19 end,
Other_Provider_Identifier_Issuer_19 = case @Other_Provider_Identifier_Issuer_19 when '' then NULL else @Other_Provider_Identifier_Issuer_19 end,
Other_Provider_Identifier_20 = case @Other_Provider_Identifier_20 when '' then NULL else @Other_Provider_Identifier_20 end,
Other_Provider_Identifier_Type_Code_20 = case @Other_Provider_Identifier_Type_Code_20 when '' then NULL else @Other_Provider_Identifier_Type_Code_20 end,
Other_Provider_Identifier_State_20 = case @Other_Provider_Identifier_State_20 when '' then NULL else @Other_Provider_Identifier_State_20 end,
Other_Provider_Identifier_Issuer_20 = case @Other_Provider_Identifier_Issuer_20 when '' then NULL else @Other_Provider_Identifier_Issuer_20 end,
Other_Provider_Identifier_21 = case @Other_Provider_Identifier_21 when '' then NULL else @Other_Provider_Identifier_21 end,
Other_Provider_Identifier_Type_Code_21 = case @Other_Provider_Identifier_Type_Code_21 when '' then NULL else @Other_Provider_Identifier_Type_Code_21 end,
Other_Provider_Identifier_State_21 = case @Other_Provider_Identifier_State_21 when '' then NULL else @Other_Provider_Identifier_State_21 end,
Other_Provider_Identifier_Issuer_21 = case @Other_Provider_Identifier_Issuer_21 when '' then NULL else @Other_Provider_Identifier_Issuer_21 end,
Other_Provider_Identifier_22 = case @Other_Provider_Identifier_22 when '' then NULL else @Other_Provider_Identifier_22 end,
Other_Provider_Identifier_Type_Code_22 = case @Other_Provider_Identifier_Type_Code_22 when '' then NULL else @Other_Provider_Identifier_Type_Code_22 end,
Other_Provider_Identifier_State_22 = case @Other_Provider_Identifier_State_22 when '' then NULL else @Other_Provider_Identifier_State_22 end,
Other_Provider_Identifier_Issuer_22 = case @Other_Provider_Identifier_Issuer_22 when '' then NULL else @Other_Provider_Identifier_Issuer_22 end,
Other_Provider_Identifier_23 = case @Other_Provider_Identifier_23 when '' then NULL else @Other_Provider_Identifier_23 end,
Other_Provider_Identifier_Type_Code_23 = case @Other_Provider_Identifier_Type_Code_23 when '' then NULL else @Other_Provider_Identifier_Type_Code_23 end,
Other_Provider_Identifier_State_23 = case @Other_Provider_Identifier_State_23 when '' then NULL else @Other_Provider_Identifier_State_23 end,
Other_Provider_Identifier_Issuer_23 = case @Other_Provider_Identifier_Issuer_23 when '' then NULL else @Other_Provider_Identifier_Issuer_23 end,
Other_Provider_Identifier_24 = case @Other_Provider_Identifier_24 when '' then NULL else @Other_Provider_Identifier_24 end,
Other_Provider_Identifier_Type_Code_24 = case @Other_Provider_Identifier_Type_Code_24 when '' then NULL else @Other_Provider_Identifier_Type_Code_24 end,
Other_Provider_Identifier_State_24 = case @Other_Provider_Identifier_State_24 when '' then NULL else @Other_Provider_Identifier_State_24 end,
Other_Provider_Identifier_Issuer_24 = case @Other_Provider_Identifier_Issuer_24 when '' then NULL else @Other_Provider_Identifier_Issuer_24 end,
Other_Provider_Identifier_25 = case @Other_Provider_Identifier_25 when '' then NULL else @Other_Provider_Identifier_25 end,
Other_Provider_Identifier_Type_Code_25 = case @Other_Provider_Identifier_Type_Code_25 when '' then NULL else @Other_Provider_Identifier_Type_Code_25 end,
Other_Provider_Identifier_State_25 = case @Other_Provider_Identifier_State_25 when '' then NULL else @Other_Provider_Identifier_State_25 end,
Other_Provider_Identifier_Issuer_25 = case @Other_Provider_Identifier_Issuer_25 when '' then NULL else @Other_Provider_Identifier_Issuer_25 end,
Other_Provider_Identifier_26 = case @Other_Provider_Identifier_26 when '' then NULL else @Other_Provider_Identifier_26 end,
Other_Provider_Identifier_Type_Code_26 = case @Other_Provider_Identifier_Type_Code_26 when '' then NULL else @Other_Provider_Identifier_Type_Code_26 end,
Other_Provider_Identifier_State_26 = case @Other_Provider_Identifier_State_26 when '' then NULL else @Other_Provider_Identifier_State_26 end,
Other_Provider_Identifier_Issuer_26 = case @Other_Provider_Identifier_Issuer_26 when '' then NULL else @Other_Provider_Identifier_Issuer_26 end,
Other_Provider_Identifier_27 = case @Other_Provider_Identifier_27 when '' then NULL else @Other_Provider_Identifier_27 end,
Other_Provider_Identifier_Type_Code_27 = case @Other_Provider_Identifier_Type_Code_27 when '' then NULL else @Other_Provider_Identifier_Type_Code_27 end,
Other_Provider_Identifier_State_27 = case @Other_Provider_Identifier_State_27 when '' then NULL else @Other_Provider_Identifier_State_27 end,
Other_Provider_Identifier_Issuer_27 = case @Other_Provider_Identifier_Issuer_27 when '' then NULL else @Other_Provider_Identifier_Issuer_27 end,
Other_Provider_Identifier_28 = case @Other_Provider_Identifier_28 when '' then NULL else @Other_Provider_Identifier_28 end,
Other_Provider_Identifier_Type_Code_28 = case @Other_Provider_Identifier_Type_Code_28 when '' then NULL else @Other_Provider_Identifier_Type_Code_28 end,
Other_Provider_Identifier_State_28 = case @Other_Provider_Identifier_State_28 when '' then NULL else @Other_Provider_Identifier_State_28 end,
Other_Provider_Identifier_Issuer_28 = case @Other_Provider_Identifier_Issuer_28 when '' then NULL else @Other_Provider_Identifier_Issuer_28 end,
Other_Provider_Identifier_29 = case @Other_Provider_Identifier_29 when '' then NULL else @Other_Provider_Identifier_29 end,
Other_Provider_Identifier_Type_Code_29 = case @Other_Provider_Identifier_Type_Code_29 when '' then NULL else @Other_Provider_Identifier_Type_Code_29 end,
Other_Provider_Identifier_State_29 = case @Other_Provider_Identifier_State_29 when '' then NULL else @Other_Provider_Identifier_State_29 end,
Other_Provider_Identifier_Issuer_29 = case @Other_Provider_Identifier_Issuer_29 when '' then NULL else @Other_Provider_Identifier_Issuer_29 end,
Other_Provider_Identifier_30 = case @Other_Provider_Identifier_30 when '' then NULL else @Other_Provider_Identifier_30 end,
Other_Provider_Identifier_Type_Code_30 = case @Other_Provider_Identifier_Type_Code_30 when '' then NULL else @Other_Provider_Identifier_Type_Code_30 end,
Other_Provider_Identifier_State_30 = case @Other_Provider_Identifier_State_30 when '' then NULL else @Other_Provider_Identifier_State_30 end,
Other_Provider_Identifier_Issuer_30 = case @Other_Provider_Identifier_Issuer_30 when '' then NULL else @Other_Provider_Identifier_Issuer_30 end,
Other_Provider_Identifier_31 = case @Other_Provider_Identifier_31 when '' then NULL else @Other_Provider_Identifier_31 end,
Other_Provider_Identifier_Type_Code_31 = case @Other_Provider_Identifier_Type_Code_31 when '' then NULL else @Other_Provider_Identifier_Type_Code_31 end,
Other_Provider_Identifier_State_31 = case @Other_Provider_Identifier_State_31 when '' then NULL else @Other_Provider_Identifier_State_31 end,
Other_Provider_Identifier_Issuer_31 = case @Other_Provider_Identifier_Issuer_31 when '' then NULL else @Other_Provider_Identifier_Issuer_31 end,
Other_Provider_Identifier_32 = case @Other_Provider_Identifier_32 when '' then NULL else @Other_Provider_Identifier_32 end,
Other_Provider_Identifier_Type_Code_32 = case @Other_Provider_Identifier_Type_Code_32 when '' then NULL else @Other_Provider_Identifier_Type_Code_32 end,
Other_Provider_Identifier_State_32 = case @Other_Provider_Identifier_State_32 when '' then NULL else @Other_Provider_Identifier_State_32 end,
Other_Provider_Identifier_Issuer_32 = case @Other_Provider_Identifier_Issuer_32 when '' then NULL else @Other_Provider_Identifier_Issuer_32 end,
Other_Provider_Identifier_33 = case @Other_Provider_Identifier_33 when '' then NULL else @Other_Provider_Identifier_33 end,
Other_Provider_Identifier_Type_Code_33 = case @Other_Provider_Identifier_Type_Code_33 when '' then NULL else @Other_Provider_Identifier_Type_Code_33 end,
Other_Provider_Identifier_State_33 = case @Other_Provider_Identifier_State_33 when '' then NULL else @Other_Provider_Identifier_State_33 end,
Other_Provider_Identifier_Issuer_33 = case @Other_Provider_Identifier_Issuer_33 when '' then NULL else @Other_Provider_Identifier_Issuer_33 end,
Other_Provider_Identifier_34 = case @Other_Provider_Identifier_34 when '' then NULL else @Other_Provider_Identifier_34 end,
Other_Provider_Identifier_Type_Code_34 = case @Other_Provider_Identifier_Type_Code_34 when '' then NULL else @Other_Provider_Identifier_Type_Code_34 end,
Other_Provider_Identifier_State_34 = case @Other_Provider_Identifier_State_34 when '' then NULL else @Other_Provider_Identifier_State_34 end,
Other_Provider_Identifier_Issuer_34 = case @Other_Provider_Identifier_Issuer_34 when '' then NULL else @Other_Provider_Identifier_Issuer_34 end,
Other_Provider_Identifier_35 = case @Other_Provider_Identifier_35 when '' then NULL else @Other_Provider_Identifier_35 end,
Other_Provider_Identifier_Type_Code_35 = case @Other_Provider_Identifier_Type_Code_35 when '' then NULL else @Other_Provider_Identifier_Type_Code_35 end,
Other_Provider_Identifier_State_35 = case @Other_Provider_Identifier_State_35 when '' then NULL else @Other_Provider_Identifier_State_35 end,
Other_Provider_Identifier_Issuer_35 = case @Other_Provider_Identifier_Issuer_35 when '' then NULL else @Other_Provider_Identifier_Issuer_35 end,
Other_Provider_Identifier_36 = case @Other_Provider_Identifier_36 when '' then NULL else @Other_Provider_Identifier_36 end,
Other_Provider_Identifier_Type_Code_36 = case @Other_Provider_Identifier_Type_Code_36 when '' then NULL else @Other_Provider_Identifier_Type_Code_36 end,
Other_Provider_Identifier_State_36 = case @Other_Provider_Identifier_State_36 when '' then NULL else @Other_Provider_Identifier_State_36 end,
Other_Provider_Identifier_Issuer_36 = case @Other_Provider_Identifier_Issuer_36 when '' then NULL else @Other_Provider_Identifier_Issuer_36 end,
Other_Provider_Identifier_37 = case @Other_Provider_Identifier_37 when '' then NULL else @Other_Provider_Identifier_37 end,
Other_Provider_Identifier_Type_Code_37 = case @Other_Provider_Identifier_Type_Code_37 when '' then NULL else @Other_Provider_Identifier_Type_Code_37 end,
Other_Provider_Identifier_State_37 = case @Other_Provider_Identifier_State_37 when '' then NULL else @Other_Provider_Identifier_State_37 end,
Other_Provider_Identifier_Issuer_37 = case @Other_Provider_Identifier_Issuer_37 when '' then NULL else @Other_Provider_Identifier_Issuer_37 end,
Other_Provider_Identifier_38 = case @Other_Provider_Identifier_38 when '' then NULL else @Other_Provider_Identifier_38 end,
Other_Provider_Identifier_Type_Code_38 = case @Other_Provider_Identifier_Type_Code_38 when '' then NULL else @Other_Provider_Identifier_Type_Code_38 end,
Other_Provider_Identifier_State_38 = case @Other_Provider_Identifier_State_38 when '' then NULL else @Other_Provider_Identifier_State_38 end,
Other_Provider_Identifier_Issuer_38 = case @Other_Provider_Identifier_Issuer_38 when '' then NULL else @Other_Provider_Identifier_Issuer_38 end,
Other_Provider_Identifier_39 = case @Other_Provider_Identifier_39 when '' then NULL else @Other_Provider_Identifier_39 end,
Other_Provider_Identifier_Type_Code_39 = case @Other_Provider_Identifier_Type_Code_39 when '' then NULL else @Other_Provider_Identifier_Type_Code_39 end,
Other_Provider_Identifier_State_39 = case @Other_Provider_Identifier_State_39 when '' then NULL else @Other_Provider_Identifier_State_39 end,
Other_Provider_Identifier_Issuer_39 = case @Other_Provider_Identifier_Issuer_39 when '' then NULL else @Other_Provider_Identifier_Issuer_39 end,
Other_Provider_Identifier_40 = case @Other_Provider_Identifier_40 when '' then NULL else @Other_Provider_Identifier_40 end,
Other_Provider_Identifier_Type_Code_40 = case @Other_Provider_Identifier_Type_Code_40 when '' then NULL else @Other_Provider_Identifier_Type_Code_40 end,
Other_Provider_Identifier_State_40 = case @Other_Provider_Identifier_State_40 when '' then NULL else @Other_Provider_Identifier_State_40 end,
Other_Provider_Identifier_Issuer_40 = case @Other_Provider_Identifier_Issuer_40 when '' then NULL else @Other_Provider_Identifier_Issuer_40 end,
Other_Provider_Identifier_41 = case @Other_Provider_Identifier_41 when '' then NULL else @Other_Provider_Identifier_41 end,
Other_Provider_Identifier_Type_Code_41 = case @Other_Provider_Identifier_Type_Code_41 when '' then NULL else @Other_Provider_Identifier_Type_Code_41 end,
Other_Provider_Identifier_State_41 = case @Other_Provider_Identifier_State_41 when '' then NULL else @Other_Provider_Identifier_State_41 end,
Other_Provider_Identifier_Issuer_41 = case @Other_Provider_Identifier_Issuer_41 when '' then NULL else @Other_Provider_Identifier_Issuer_41 end,
Other_Provider_Identifier_42 = case @Other_Provider_Identifier_42 when '' then NULL else @Other_Provider_Identifier_42 end,
Other_Provider_Identifier_Type_Code_42 = case @Other_Provider_Identifier_Type_Code_42 when '' then NULL else @Other_Provider_Identifier_Type_Code_42 end,
Other_Provider_Identifier_State_42 = case @Other_Provider_Identifier_State_42 when '' then NULL else @Other_Provider_Identifier_State_42 end,
Other_Provider_Identifier_Issuer_42 = case @Other_Provider_Identifier_Issuer_42 when '' then NULL else @Other_Provider_Identifier_Issuer_42 end,
Other_Provider_Identifier_43 = case @Other_Provider_Identifier_43 when '' then NULL else @Other_Provider_Identifier_43 end,
Other_Provider_Identifier_Type_Code_43 = case @Other_Provider_Identifier_Type_Code_43 when '' then NULL else @Other_Provider_Identifier_Type_Code_43 end,
Other_Provider_Identifier_State_43 = case @Other_Provider_Identifier_State_43 when '' then NULL else @Other_Provider_Identifier_State_43 end,
Other_Provider_Identifier_Issuer_43 = case @Other_Provider_Identifier_Issuer_43 when '' then NULL else @Other_Provider_Identifier_Issuer_43 end,
Other_Provider_Identifier_44 = case @Other_Provider_Identifier_44 when '' then NULL else @Other_Provider_Identifier_44 end,
Other_Provider_Identifier_Type_Code_44 = case @Other_Provider_Identifier_Type_Code_44 when '' then NULL else @Other_Provider_Identifier_Type_Code_44 end,
Other_Provider_Identifier_State_44 = case @Other_Provider_Identifier_State_44 when '' then NULL else @Other_Provider_Identifier_State_44 end,
Other_Provider_Identifier_Issuer_44 = case @Other_Provider_Identifier_Issuer_44 when '' then NULL else @Other_Provider_Identifier_Issuer_44 end,
Other_Provider_Identifier_45 = case @Other_Provider_Identifier_45 when '' then NULL else @Other_Provider_Identifier_45 end,
Other_Provider_Identifier_Type_Code_45 = case @Other_Provider_Identifier_Type_Code_45 when '' then NULL else @Other_Provider_Identifier_Type_Code_45 end,
Other_Provider_Identifier_State_45 = case @Other_Provider_Identifier_State_45 when '' then NULL else @Other_Provider_Identifier_State_45 end,
Other_Provider_Identifier_Issuer_45 = case @Other_Provider_Identifier_Issuer_45 when '' then NULL else @Other_Provider_Identifier_Issuer_45 end,
Other_Provider_Identifier_46 = case @Other_Provider_Identifier_46 when '' then NULL else @Other_Provider_Identifier_46 end,
Other_Provider_Identifier_Type_Code_46 = case @Other_Provider_Identifier_Type_Code_46 when '' then NULL else @Other_Provider_Identifier_Type_Code_46 end,
Other_Provider_Identifier_State_46 = case @Other_Provider_Identifier_State_46 when '' then NULL else @Other_Provider_Identifier_State_46 end,
Other_Provider_Identifier_Issuer_46 = case @Other_Provider_Identifier_Issuer_46 when '' then NULL else @Other_Provider_Identifier_Issuer_46 end,
Other_Provider_Identifier_47 = case @Other_Provider_Identifier_47 when '' then NULL else @Other_Provider_Identifier_47 end,
Other_Provider_Identifier_Type_Code_47 = case @Other_Provider_Identifier_Type_Code_47 when '' then NULL else @Other_Provider_Identifier_Type_Code_47 end,
Other_Provider_Identifier_State_47 = case @Other_Provider_Identifier_State_47 when '' then NULL else @Other_Provider_Identifier_State_47 end,
Other_Provider_Identifier_Issuer_47 = case @Other_Provider_Identifier_Issuer_47 when '' then NULL else @Other_Provider_Identifier_Issuer_47 end,
Other_Provider_Identifier_48 = case @Other_Provider_Identifier_48 when '' then NULL else @Other_Provider_Identifier_48 end,
Other_Provider_Identifier_Type_Code_48 = case @Other_Provider_Identifier_Type_Code_48 when '' then NULL else @Other_Provider_Identifier_Type_Code_48 end,
Other_Provider_Identifier_State_48 = case @Other_Provider_Identifier_State_48 when '' then NULL else @Other_Provider_Identifier_State_48 end,
Other_Provider_Identifier_Issuer_48 = case @Other_Provider_Identifier_Issuer_48 when '' then NULL else @Other_Provider_Identifier_Issuer_48 end,
Other_Provider_Identifier_49 = case @Other_Provider_Identifier_49 when '' then NULL else @Other_Provider_Identifier_49 end,
Other_Provider_Identifier_Type_Code_49 = case @Other_Provider_Identifier_Type_Code_49 when '' then NULL else @Other_Provider_Identifier_Type_Code_49 end,
Other_Provider_Identifier_State_49 = case @Other_Provider_Identifier_State_49 when '' then NULL else @Other_Provider_Identifier_State_49 end,
Other_Provider_Identifier_Issuer_49 = case @Other_Provider_Identifier_Issuer_49 when '' then NULL else @Other_Provider_Identifier_Issuer_49 end,
Other_Provider_Identifier_50 = case @Other_Provider_Identifier_50 when '' then NULL else @Other_Provider_Identifier_50 end,
Other_Provider_Identifier_Type_Code_50 = case @Other_Provider_Identifier_Type_Code_50 when '' then NULL else @Other_Provider_Identifier_Type_Code_50 end,
Other_Provider_Identifier_State_50 = case @Other_Provider_Identifier_State_50 when '' then NULL else @Other_Provider_Identifier_State_50 end,
Other_Provider_Identifier_Issuer_50 = case @Other_Provider_Identifier_Issuer_50 when '' then NULL else @Other_Provider_Identifier_Issuer_50 end,
Is_Sole_Proprietor = case @Is_Sole_Proprietor when '' then NULL else @Is_Sole_Proprietor end,
Is_Organization_Subpart = case @Is_Organization_Subpart when '' then NULL else @Is_Organization_Subpart end,
Parent_Organization_LBN = case @Parent_Organization_LBN when '' then NULL else @Parent_Organization_LBN end,
Parent_Organization_TIN = case @Parent_Organization_TIN when '' then NULL else @Parent_Organization_TIN end,
Authorized_Official_Name_Prefix_Text = case @Authorized_Official_Name_Prefix_Text when '' then NULL else @Authorized_Official_Name_Prefix_Text end,
Authorized_Official_Name_Suffix_Text = case @Authorized_Official_Name_Suffix_Text when '' then NULL else @Authorized_Official_Name_Suffix_Text end,
Authorized_Official_Credential_Text = case @Authorized_Official_Credential_Text when '' then NULL else @Authorized_Official_Credential_Text end
;

/*
create view NPPESdata as (select
   NPI as [NPI],
   Entity_Type_Code as [Entity Type Code],
   Replacement_NPI as [Replacement NPI],
   Employer_Identification_Number_EIN as [Employer Identification Number (EIN)],
   Provider_Organization_Name_Legal_Business_Name as [Provider Organization Name (Legal Business Name)],
   Provider_Last_Name_Legal_Name as [Provider Last Name (Legal Name)],
   Provider_First_Name as [Provider First Name],
   Provider_Middle_Name as [Provider Middle Name],
   Provider_Name_Prefix_Text as [Provider Name Prefix Text],
   Provider_Name_Suffix_Text as [Provider Name Suffix Text],
   Provider_Credential_Text as [Provider Credential Text],
   Provider_Other_Organization_Name as [Provider Other Organization Name],
   Provider_Other_Organization_Name_Type_Code as [Provider Other Organization Name Type Code],
   Provider_Other_Last_Name as [Provider Other Last Name],
   Provider_Other_First_Name as [Provider Other First Name],
   Provider_Other_Middle_Name as [Provider Other Middle Name],
   Provider_Other_Name_Prefix_Text as [Provider Other Name Prefix Text],
   Provider_Other_Name_Suffix_Text as [Provider Other Name Suffix Text],
   Provider_Other_Credential_Text as [Provider Other Credential Text],
   Provider_Other_Last_Name_Type_Code as [Provider Other Last Name Type Code],
   Provider_First_Line_Business_Mailing_Address as [Provider First Line Business Mailing Address],
   Provider_Second_Line_Business_Mailing_Address as [Provider Second Line Business Mailing Address],
   Provider_Business_Mailing_Address_City_Name as [Provider Business Mailing Address City Name],
   Provider_Business_Mailing_Address_State_Name as [Provider Business Mailing Address State Name],
   Provider_Business_Mailing_Address_Postal_Code as [Provider Business Mailing Address Postal Code],
   Provider_Business_Mailing_Address_Country_Cod as [Provider Business Mailing Address Country Code (If outside U.S.)],
   Provider_Business_Mailing_Address_Telephone_Number as [Provider Business Mailing Address Telephone Number],
   Provider_Business_Mailing_Address_Fax_Number as [Provider Business Mailing Address Fax Number],
   Provider_First_Line_Business_Practice_Location_Address as [Provider First Line Business Practice Location Address],
   Provider_Second_Line_Business_Practice_Location_Address as [Provider Second Line Business Practice Location Address],
   Provider_Business_Practice_Location_Address_City_Name as [Provider Business Practice Location Address City Name],
   Provider_Business_Practice_Location_Address_State_Name as [Provider Business Practice Location Address State Name],
   Provider_Business_Practice_Location_Address_Postal_Code as [Provider Business Practice Location Address Postal Code],
   Provider_Business_Practice_Location_Address_Country_Cod as [Provider Business Practice Location Address Country Code (If outside U.S.)],
   Provider_Business_Practice_Location_Address_Telephone_Number as [Provider Business Practice Location Address Telephone Number],
   Provider_Business_Practice_Location_Address_Fax_Number as [Provider Business Practice Location Address Fax Number],
   Provider_Enumeration_Date as [Provider Enumeration Date],
   Last_Update_Date as [Last Update Date],
   NPI_Deactivation_Reason_Code as [NPI Deactivation Reason Code],
   NPI_Deactivation_Date as [NPI Deactivation Date],
   NPI_Reactivation_Date as [NPI Reactivation Date],
   Provider_Gender_Code as [Provider Gender Code],
   Authorized_Official_Last_Name as [Authorized Official Last Name],
   Authorized_Official_First_Name as [Authorized Official First Name],
   Authorized_Official_Middle_Name as [Authorized Official Middle Name],
   Authorized_Official_Title_or_Position as [Authorized Official Title or Position],
   Authorized_Official_Telephone_Number as [Authorized Official Telephone Number],
   Healthcare_Provider_Taxonomy_Code_1 as [Healthcare Provider Taxonomy Code_1],
   Provider_License_Number_1 as [Provider License Number_1],
   Provider_License_Number_State_Code_1 as [Provider License Number State Code_1],
   Healthcare_Provider_Primary_Taxonomy_Switch_1 as [Healthcare Provider Primary Taxonomy Switch_1],
   Healthcare_Provider_Taxonomy_Code_2 as [Healthcare Provider Taxonomy Code_2],
   Provider_License_Number_2 as [Provider License Number_2],
   Provider_License_Number_State_Code_2 as [Provider License Number State Code_2],
   Healthcare_Provider_Primary_Taxonomy_Switch_2 as [Healthcare Provider Primary Taxonomy Switch_2],
   Healthcare_Provider_Taxonomy_Code_3 as [Healthcare Provider Taxonomy Code_3],
   Provider_License_Number_3 as [Provider License Number_3],
   Provider_License_Number_State_Code_3 as [Provider License Number State Code_3],
   Healthcare_Provider_Primary_Taxonomy_Switch_3 as [Healthcare Provider Primary Taxonomy Switch_3],
   Healthcare_Provider_Taxonomy_Code_4 as [Healthcare Provider Taxonomy Code_4],
   Provider_License_Number_4 as [Provider License Number_4],
   Provider_License_Number_State_Code_4 as [Provider License Number State Code_4],
   Healthcare_Provider_Primary_Taxonomy_Switch_4 as [Healthcare Provider Primary Taxonomy Switch_4],
   Healthcare_Provider_Taxonomy_Code_5 as [Healthcare Provider Taxonomy Code_5],
   Provider_License_Number_5 as [Provider License Number_5],
   Provider_License_Number_State_Code_5 as [Provider License Number State Code_5],
   Healthcare_Provider_Primary_Taxonomy_Switch_5 as [Healthcare Provider Primary Taxonomy Switch_5],
   Healthcare_Provider_Taxonomy_Code_6 as [Healthcare Provider Taxonomy Code_6],
   Provider_License_Number_6 as [Provider License Number_6],
   Provider_License_Number_State_Code_6 as [Provider License Number State Code_6],
   Healthcare_Provider_Primary_Taxonomy_Switch_6 as [Healthcare Provider Primary Taxonomy Switch_6],
   Healthcare_Provider_Taxonomy_Code_7 as [Healthcare Provider Taxonomy Code_7],
   Provider_License_Number_7 as [Provider License Number_7],
   Provider_License_Number_State_Code_7 as [Provider License Number State Code_7],
   Healthcare_Provider_Primary_Taxonomy_Switch_7 as [Healthcare Provider Primary Taxonomy Switch_7],
   Healthcare_Provider_Taxonomy_Code_8 as [Healthcare Provider Taxonomy Code_8],
   Provider_License_Number_8 as [Provider License Number_8],
   Provider_License_Number_State_Code_8 as [Provider License Number State Code_8],
   Healthcare_Provider_Primary_Taxonomy_Switch_8 as [Healthcare Provider Primary Taxonomy Switch_8],
   Healthcare_Provider_Taxonomy_Code_9 as [Healthcare Provider Taxonomy Code_9],
   Provider_License_Number_9 as [Provider License Number_9],
   Provider_License_Number_State_Code_9 as [Provider License Number State Code_9],
   Healthcare_Provider_Primary_Taxonomy_Switch_9 as [Healthcare Provider Primary Taxonomy Switch_9],
   Healthcare_Provider_Taxonomy_Code_10 as [Healthcare Provider Taxonomy Code_10],
   Provider_License_Number_10 as [Provider License Number_10],
   Provider_License_Number_State_Code_10 as [Provider License Number State Code_10],
   Healthcare_Provider_Primary_Taxonomy_Switch_10 as [Healthcare Provider Primary Taxonomy Switch_10],
   Healthcare_Provider_Taxonomy_Code_11 as [Healthcare Provider Taxonomy Code_11],
   Provider_License_Number_11 as [Provider License Number_11],
   Provider_License_Number_State_Code_11 as [Provider License Number State Code_11],
   Healthcare_Provider_Primary_Taxonomy_Switch_11 as [Healthcare Provider Primary Taxonomy Switch_11],
   Healthcare_Provider_Taxonomy_Code_12 as [Healthcare Provider Taxonomy Code_12],
   Provider_License_Number_12 as [Provider License Number_12],
   Provider_License_Number_State_Code_12 as [Provider License Number State Code_12],
   Healthcare_Provider_Primary_Taxonomy_Switch_12 as [Healthcare Provider Primary Taxonomy Switch_12],
   Healthcare_Provider_Taxonomy_Code_13 as [Healthcare Provider Taxonomy Code_13],
   Provider_License_Number_13 as [Provider License Number_13],
   Provider_License_Number_State_Code_13 as [Provider License Number State Code_13],
   Healthcare_Provider_Primary_Taxonomy_Switch_13 as [Healthcare Provider Primary Taxonomy Switch_13],
   Healthcare_Provider_Taxonomy_Code_14 as [Healthcare Provider Taxonomy Code_14],
   Provider_License_Number_14 as [Provider License Number_14],
   Provider_License_Number_State_Code_14 as [Provider License Number State Code_14],
   Healthcare_Provider_Primary_Taxonomy_Switch_14 as [Healthcare Provider Primary Taxonomy Switch_14],
   Healthcare_Provider_Taxonomy_Code_15 as [Healthcare Provider Taxonomy Code_15],
   Provider_License_Number_15 as [Provider License Number_15],
   Provider_License_Number_State_Code_15 as [Provider License Number State Code_15],
   Healthcare_Provider_Primary_Taxonomy_Switch_15 as [Healthcare Provider Primary Taxonomy Switch_15],
   Other_Provider_Identifier_1 as [Other Provider Identifier_1],
   Other_Provider_Identifier_Type_Code_1 as [Other Provider Identifier Type Code_1],
   Other_Provider_Identifier_State_1 as [Other Provider Identifier State_1],
   Other_Provider_Identifier_Issuer_1 as [Other Provider Identifier Issuer_1],
   Other_Provider_Identifier_2 as [Other Provider Identifier_2],
   Other_Provider_Identifier_Type_Code_2 as [Other Provider Identifier Type Code_2],
   Other_Provider_Identifier_State_2 as [Other Provider Identifier State_2],
   Other_Provider_Identifier_Issuer_2 as [Other Provider Identifier Issuer_2],
   Other_Provider_Identifier_3 as [Other Provider Identifier_3],
   Other_Provider_Identifier_Type_Code_3 as [Other Provider Identifier Type Code_3],
   Other_Provider_Identifier_State_3 as [Other Provider Identifier State_3],
   Other_Provider_Identifier_Issuer_3 as [Other Provider Identifier Issuer_3],
   Other_Provider_Identifier_4 as [Other Provider Identifier_4],
   Other_Provider_Identifier_Type_Code_4 as [Other Provider Identifier Type Code_4],
   Other_Provider_Identifier_State_4 as [Other Provider Identifier State_4],
   Other_Provider_Identifier_Issuer_4 as [Other Provider Identifier Issuer_4],
   Other_Provider_Identifier_5 as [Other Provider Identifier_5],
   Other_Provider_Identifier_Type_Code_5 as [Other Provider Identifier Type Code_5],
   Other_Provider_Identifier_State_5 as [Other Provider Identifier State_5],
   Other_Provider_Identifier_Issuer_5 as [Other Provider Identifier Issuer_5],
   Other_Provider_Identifier_6 as [Other Provider Identifier_6],
   Other_Provider_Identifier_Type_Code_6 as [Other Provider Identifier Type Code_6],
   Other_Provider_Identifier_State_6 as [Other Provider Identifier State_6],
   Other_Provider_Identifier_Issuer_6 as [Other Provider Identifier Issuer_6],
   Other_Provider_Identifier_7 as [Other Provider Identifier_7],
   Other_Provider_Identifier_Type_Code_7 as [Other Provider Identifier Type Code_7],
   Other_Provider_Identifier_State_7 as [Other Provider Identifier State_7],
   Other_Provider_Identifier_Issuer_7 as [Other Provider Identifier Issuer_7],
   Other_Provider_Identifier_8 as [Other Provider Identifier_8],
   Other_Provider_Identifier_Type_Code_8 as [Other Provider Identifier Type Code_8],
   Other_Provider_Identifier_State_8 as [Other Provider Identifier State_8],
   Other_Provider_Identifier_Issuer_8 as [Other Provider Identifier Issuer_8],
   Other_Provider_Identifier_9 as [Other Provider Identifier_9],
   Other_Provider_Identifier_Type_Code_9 as [Other Provider Identifier Type Code_9],
   Other_Provider_Identifier_State_9 as [Other Provider Identifier State_9],
   Other_Provider_Identifier_Issuer_9 as [Other Provider Identifier Issuer_9],
   Other_Provider_Identifier_10 as [Other Provider Identifier_10],
   Other_Provider_Identifier_Type_Code_10 as [Other Provider Identifier Type Code_10],
   Other_Provider_Identifier_State_10 as [Other Provider Identifier State_10],
   Other_Provider_Identifier_Issuer_10 as [Other Provider Identifier Issuer_10],
   Other_Provider_Identifier_11 as [Other Provider Identifier_11],
   Other_Provider_Identifier_Type_Code_11 as [Other Provider Identifier Type Code_11],
   Other_Provider_Identifier_State_11 as [Other Provider Identifier State_11],
   Other_Provider_Identifier_Issuer_11 as [Other Provider Identifier Issuer_11],
   Other_Provider_Identifier_12 as [Other Provider Identifier_12],
   Other_Provider_Identifier_Type_Code_12 as [Other Provider Identifier Type Code_12],
   Other_Provider_Identifier_State_12 as [Other Provider Identifier State_12],
   Other_Provider_Identifier_Issuer_12 as [Other Provider Identifier Issuer_12],
   Other_Provider_Identifier_13 as [Other Provider Identifier_13],
   Other_Provider_Identifier_Type_Code_13 as [Other Provider Identifier Type Code_13],
   Other_Provider_Identifier_State_13 as [Other Provider Identifier State_13],
   Other_Provider_Identifier_Issuer_13 as [Other Provider Identifier Issuer_13],
   Other_Provider_Identifier_14 as [Other Provider Identifier_14],
   Other_Provider_Identifier_Type_Code_14 as [Other Provider Identifier Type Code_14],
   Other_Provider_Identifier_State_14 as [Other Provider Identifier State_14],
   Other_Provider_Identifier_Issuer_14 as [Other Provider Identifier Issuer_14],
   Other_Provider_Identifier_15 as [Other Provider Identifier_15],
   Other_Provider_Identifier_Type_Code_15 as [Other Provider Identifier Type Code_15],
   Other_Provider_Identifier_State_15 as [Other Provider Identifier State_15],
   Other_Provider_Identifier_Issuer_15 as [Other Provider Identifier Issuer_15],
   Other_Provider_Identifier_16 as [Other Provider Identifier_16],
   Other_Provider_Identifier_Type_Code_16 as [Other Provider Identifier Type Code_16],
   Other_Provider_Identifier_State_16 as [Other Provider Identifier State_16],
   Other_Provider_Identifier_Issuer_16 as [Other Provider Identifier Issuer_16],
   Other_Provider_Identifier_17 as [Other Provider Identifier_17],
   Other_Provider_Identifier_Type_Code_17 as [Other Provider Identifier Type Code_17],
   Other_Provider_Identifier_State_17 as [Other Provider Identifier State_17],
   Other_Provider_Identifier_Issuer_17 as [Other Provider Identifier Issuer_17],
   Other_Provider_Identifier_18 as [Other Provider Identifier_18],
   Other_Provider_Identifier_Type_Code_18 as [Other Provider Identifier Type Code_18],
   Other_Provider_Identifier_State_18 as [Other Provider Identifier State_18],
   Other_Provider_Identifier_Issuer_18 as [Other Provider Identifier Issuer_18],
   Other_Provider_Identifier_19 as [Other Provider Identifier_19],
   Other_Provider_Identifier_Type_Code_19 as [Other Provider Identifier Type Code_19],
   Other_Provider_Identifier_State_19 as [Other Provider Identifier State_19],
   Other_Provider_Identifier_Issuer_19 as [Other Provider Identifier Issuer_19],
   Other_Provider_Identifier_20 as [Other Provider Identifier_20],
   Other_Provider_Identifier_Type_Code_20 as [Other Provider Identifier Type Code_20],
   Other_Provider_Identifier_State_20 as [Other Provider Identifier State_20],
   Other_Provider_Identifier_Issuer_20 as [Other Provider Identifier Issuer_20],
   Other_Provider_Identifier_21 as [Other Provider Identifier_21],
   Other_Provider_Identifier_Type_Code_21 as [Other Provider Identifier Type Code_21],
   Other_Provider_Identifier_State_21 as [Other Provider Identifier State_21],
   Other_Provider_Identifier_Issuer_21 as [Other Provider Identifier Issuer_21],
   Other_Provider_Identifier_22 as [Other Provider Identifier_22],
   Other_Provider_Identifier_Type_Code_22 as [Other Provider Identifier Type Code_22],
   Other_Provider_Identifier_State_22 as [Other Provider Identifier State_22],
   Other_Provider_Identifier_Issuer_22 as [Other Provider Identifier Issuer_22],
   Other_Provider_Identifier_23 as [Other Provider Identifier_23],
   Other_Provider_Identifier_Type_Code_23 as [Other Provider Identifier Type Code_23],
   Other_Provider_Identifier_State_23 as [Other Provider Identifier State_23],
   Other_Provider_Identifier_Issuer_23 as [Other Provider Identifier Issuer_23],
   Other_Provider_Identifier_24 as [Other Provider Identifier_24],
   Other_Provider_Identifier_Type_Code_24 as [Other Provider Identifier Type Code_24],
   Other_Provider_Identifier_State_24 as [Other Provider Identifier State_24],
   Other_Provider_Identifier_Issuer_24 as [Other Provider Identifier Issuer_24],
   Other_Provider_Identifier_25 as [Other Provider Identifier_25],
   Other_Provider_Identifier_Type_Code_25 as [Other Provider Identifier Type Code_25],
   Other_Provider_Identifier_State_25 as [Other Provider Identifier State_25],
   Other_Provider_Identifier_Issuer_25 as [Other Provider Identifier Issuer_25],
   Other_Provider_Identifier_26 as [Other Provider Identifier_26],
   Other_Provider_Identifier_Type_Code_26 as [Other Provider Identifier Type Code_26],
   Other_Provider_Identifier_State_26 as [Other Provider Identifier State_26],
   Other_Provider_Identifier_Issuer_26 as [Other Provider Identifier Issuer_26],
   Other_Provider_Identifier_27 as [Other Provider Identifier_27],
   Other_Provider_Identifier_Type_Code_27 as [Other Provider Identifier Type Code_27],
   Other_Provider_Identifier_State_27 as [Other Provider Identifier State_27],
   Other_Provider_Identifier_Issuer_27 as [Other Provider Identifier Issuer_27],
   Other_Provider_Identifier_28 as [Other Provider Identifier_28],
   Other_Provider_Identifier_Type_Code_28 as [Other Provider Identifier Type Code_28],
   Other_Provider_Identifier_State_28 as [Other Provider Identifier State_28],
   Other_Provider_Identifier_Issuer_28 as [Other Provider Identifier Issuer_28],
   Other_Provider_Identifier_29 as [Other Provider Identifier_29],
   Other_Provider_Identifier_Type_Code_29 as [Other Provider Identifier Type Code_29],
   Other_Provider_Identifier_State_29 as [Other Provider Identifier State_29],
   Other_Provider_Identifier_Issuer_29 as [Other Provider Identifier Issuer_29],
   Other_Provider_Identifier_30 as [Other Provider Identifier_30],
   Other_Provider_Identifier_Type_Code_30 as [Other Provider Identifier Type Code_30],
   Other_Provider_Identifier_State_30 as [Other Provider Identifier State_30],
   Other_Provider_Identifier_Issuer_30 as [Other Provider Identifier Issuer_30],
   Other_Provider_Identifier_31 as [Other Provider Identifier_31],
   Other_Provider_Identifier_Type_Code_31 as [Other Provider Identifier Type Code_31],
   Other_Provider_Identifier_State_31 as [Other Provider Identifier State_31],
   Other_Provider_Identifier_Issuer_31 as [Other Provider Identifier Issuer_31],
   Other_Provider_Identifier_32 as [Other Provider Identifier_32],
   Other_Provider_Identifier_Type_Code_32 as [Other Provider Identifier Type Code_32],
   Other_Provider_Identifier_State_32 as [Other Provider Identifier State_32],
   Other_Provider_Identifier_Issuer_32 as [Other Provider Identifier Issuer_32],
   Other_Provider_Identifier_33 as [Other Provider Identifier_33],
   Other_Provider_Identifier_Type_Code_33 as [Other Provider Identifier Type Code_33],
   Other_Provider_Identifier_State_33 as [Other Provider Identifier State_33],
   Other_Provider_Identifier_Issuer_33 as [Other Provider Identifier Issuer_33],
   Other_Provider_Identifier_34 as [Other Provider Identifier_34],
   Other_Provider_Identifier_Type_Code_34 as [Other Provider Identifier Type Code_34],
   Other_Provider_Identifier_State_34 as [Other Provider Identifier State_34],
   Other_Provider_Identifier_Issuer_34 as [Other Provider Identifier Issuer_34],
   Other_Provider_Identifier_35 as [Other Provider Identifier_35],
   Other_Provider_Identifier_Type_Code_35 as [Other Provider Identifier Type Code_35],
   Other_Provider_Identifier_State_35 as [Other Provider Identifier State_35],
   Other_Provider_Identifier_Issuer_35 as [Other Provider Identifier Issuer_35],
   Other_Provider_Identifier_36 as [Other Provider Identifier_36],
   Other_Provider_Identifier_Type_Code_36 as [Other Provider Identifier Type Code_36],
   Other_Provider_Identifier_State_36 as [Other Provider Identifier State_36],
   Other_Provider_Identifier_Issuer_36 as [Other Provider Identifier Issuer_36],
   Other_Provider_Identifier_37 as [Other Provider Identifier_37],
   Other_Provider_Identifier_Type_Code_37 as [Other Provider Identifier Type Code_37],
   Other_Provider_Identifier_State_37 as [Other Provider Identifier State_37],
   Other_Provider_Identifier_Issuer_37 as [Other Provider Identifier Issuer_37],
   Other_Provider_Identifier_38 as [Other Provider Identifier_38],
   Other_Provider_Identifier_Type_Code_38 as [Other Provider Identifier Type Code_38],
   Other_Provider_Identifier_State_38 as [Other Provider Identifier State_38],
   Other_Provider_Identifier_Issuer_38 as [Other Provider Identifier Issuer_38],
   Other_Provider_Identifier_39 as [Other Provider Identifier_39],
   Other_Provider_Identifier_Type_Code_39 as [Other Provider Identifier Type Code_39],
   Other_Provider_Identifier_State_39 as [Other Provider Identifier State_39],
   Other_Provider_Identifier_Issuer_39 as [Other Provider Identifier Issuer_39],
   Other_Provider_Identifier_40 as [Other Provider Identifier_40],
   Other_Provider_Identifier_Type_Code_40 as [Other Provider Identifier Type Code_40],
   Other_Provider_Identifier_State_40 as [Other Provider Identifier State_40],
   Other_Provider_Identifier_Issuer_40 as [Other Provider Identifier Issuer_40],
   Other_Provider_Identifier_41 as [Other Provider Identifier_41],
   Other_Provider_Identifier_Type_Code_41 as [Other Provider Identifier Type Code_41],
   Other_Provider_Identifier_State_41 as [Other Provider Identifier State_41],
   Other_Provider_Identifier_Issuer_41 as [Other Provider Identifier Issuer_41],
   Other_Provider_Identifier_42 as [Other Provider Identifier_42],
   Other_Provider_Identifier_Type_Code_42 as [Other Provider Identifier Type Code_42],
   Other_Provider_Identifier_State_42 as [Other Provider Identifier State_42],
   Other_Provider_Identifier_Issuer_42 as [Other Provider Identifier Issuer_42],
   Other_Provider_Identifier_43 as [Other Provider Identifier_43],
   Other_Provider_Identifier_Type_Code_43 as [Other Provider Identifier Type Code_43],
   Other_Provider_Identifier_State_43 as [Other Provider Identifier State_43],
   Other_Provider_Identifier_Issuer_43 as [Other Provider Identifier Issuer_43],
   Other_Provider_Identifier_44 as [Other Provider Identifier_44],
   Other_Provider_Identifier_Type_Code_44 as [Other Provider Identifier Type Code_44],
   Other_Provider_Identifier_State_44 as [Other Provider Identifier State_44],
   Other_Provider_Identifier_Issuer_44 as [Other Provider Identifier Issuer_44],
   Other_Provider_Identifier_45 as [Other Provider Identifier_45],
   Other_Provider_Identifier_Type_Code_45 as [Other Provider Identifier Type Code_45],
   Other_Provider_Identifier_State_45 as [Other Provider Identifier State_45],
   Other_Provider_Identifier_Issuer_45 as [Other Provider Identifier Issuer_45],
   Other_Provider_Identifier_46 as [Other Provider Identifier_46],
   Other_Provider_Identifier_Type_Code_46 as [Other Provider Identifier Type Code_46],
   Other_Provider_Identifier_State_46 as [Other Provider Identifier State_46],
   Other_Provider_Identifier_Issuer_46 as [Other Provider Identifier Issuer_46],
   Other_Provider_Identifier_47 as [Other Provider Identifier_47],
   Other_Provider_Identifier_Type_Code_47 as [Other Provider Identifier Type Code_47],
   Other_Provider_Identifier_State_47 as [Other Provider Identifier State_47],
   Other_Provider_Identifier_Issuer_47 as [Other Provider Identifier Issuer_47],
   Other_Provider_Identifier_48 as [Other Provider Identifier_48],
   Other_Provider_Identifier_Type_Code_48 as [Other Provider Identifier Type Code_48],
   Other_Provider_Identifier_State_48 as [Other Provider Identifier State_48],
   Other_Provider_Identifier_Issuer_48 as [Other Provider Identifier Issuer_48],
   Other_Provider_Identifier_49 as [Other Provider Identifier_49],
   Other_Provider_Identifier_Type_Code_49 as [Other Provider Identifier Type Code_49],
   Other_Provider_Identifier_State_49 as [Other Provider Identifier State_49],
   Other_Provider_Identifier_Issuer_49 as [Other Provider Identifier Issuer_49],
   Other_Provider_Identifier_50 as [Other Provider Identifier_50],
   Other_Provider_Identifier_Type_Code_50 as [Other Provider Identifier Type Code_50],
   Other_Provider_Identifier_State_50 as [Other Provider Identifier State_50],
   Other_Provider_Identifier_Issuer_50 as [Other Provider Identifier Issuer_50],
   Is_Sole_Proprietor as [Is Sole Proprietor],
   Is_Organization_Subpart as [Is Organization Subpart],
   Parent_Organization_LBN as [Parent Organization LBN],
   Parent_Organization_TIN as [Parent Organization TIN],
   Authorized_Official_Name_Prefix_Text as [Authorized Official Name Prefix Text],
   Authorized_Official_Name_Suffix_Text as [Authorized Official Name Suffix Text],
   Authorized_Official_Credential_Text as [Authorized Official Credential Text] from NPPES_flat);
*/

drop table if exists other_provider_identifiers;
    create table other_provider_identifiers (
    npi char(10),
    sequence_id integer,
    Other_Provider_Identifier VARCHAR(20),
    Other_Provider_Identifier_Type_Code VARCHAR(2),
    Other_Provider_Identifier_Issuer VARCHAR(80),
    Other_Provider_Identifier_State VARCHAR(2));

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 1, Other_Provider_Identifier_1,Other_Provider_Identifier_Type_Code_1,Other_Provider_Identifier_Issuer_1,Other_Provider_Identifier_State_1 from NPPES_flat npf
where Other_Provider_Identifier_1 is not NULL or Other_Provider_Identifier_Type_Code_1 is not NULL or Other_Provider_Identifier_Issuer_1 is not NULL or Other_Provider_Identifier_State_1 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 2, Other_Provider_Identifier_2,Other_Provider_Identifier_Type_Code_2,Other_Provider_Identifier_Issuer_2,Other_Provider_Identifier_State_2 from NPPES_flat npf
where Other_Provider_Identifier_2 is not NULL or Other_Provider_Identifier_Type_Code_2 is not NULL or Other_Provider_Identifier_Issuer_2 is not NULL or Other_Provider_Identifier_State_2 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 3, Other_Provider_Identifier_3,Other_Provider_Identifier_Type_Code_3,Other_Provider_Identifier_Issuer_3,Other_Provider_Identifier_State_3 from NPPES_flat npf
where Other_Provider_Identifier_3 is not NULL or Other_Provider_Identifier_Type_Code_3 is not NULL or Other_Provider_Identifier_Issuer_3 is not NULL or Other_Provider_Identifier_State_3 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 4, Other_Provider_Identifier_4,Other_Provider_Identifier_Type_Code_4,Other_Provider_Identifier_Issuer_4,Other_Provider_Identifier_State_4 from NPPES_flat npf
where Other_Provider_Identifier_4 is not NULL or Other_Provider_Identifier_Type_Code_4 is not NULL or Other_Provider_Identifier_Issuer_4 is not NULL or Other_Provider_Identifier_State_4 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 5, Other_Provider_Identifier_5,Other_Provider_Identifier_Type_Code_5,Other_Provider_Identifier_Issuer_5,Other_Provider_Identifier_State_5 from NPPES_flat npf
where Other_Provider_Identifier_5 is not NULL or Other_Provider_Identifier_Type_Code_5 is not NULL or Other_Provider_Identifier_Issuer_5 is not NULL or Other_Provider_Identifier_State_5 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 6, Other_Provider_Identifier_6,Other_Provider_Identifier_Type_Code_6,Other_Provider_Identifier_Issuer_6,Other_Provider_Identifier_State_6 from NPPES_flat npf
where Other_Provider_Identifier_6 is not NULL or Other_Provider_Identifier_Type_Code_6 is not NULL or Other_Provider_Identifier_Issuer_6 is not NULL or Other_Provider_Identifier_State_6 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 7, Other_Provider_Identifier_7,Other_Provider_Identifier_Type_Code_7,Other_Provider_Identifier_Issuer_7,Other_Provider_Identifier_State_7 from NPPES_flat npf
where Other_Provider_Identifier_7 is not NULL or Other_Provider_Identifier_Type_Code_7 is not NULL or Other_Provider_Identifier_Issuer_7 is not NULL or Other_Provider_Identifier_State_7 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 8, Other_Provider_Identifier_8,Other_Provider_Identifier_Type_Code_8,Other_Provider_Identifier_Issuer_8,Other_Provider_Identifier_State_8 from NPPES_flat npf
where Other_Provider_Identifier_8 is not NULL or Other_Provider_Identifier_Type_Code_8 is not NULL or Other_Provider_Identifier_Issuer_8 is not NULL or Other_Provider_Identifier_State_8 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 9, Other_Provider_Identifier_9,Other_Provider_Identifier_Type_Code_9,Other_Provider_Identifier_Issuer_9,Other_Provider_Identifier_State_9 from NPPES_flat npf
where Other_Provider_Identifier_9 is not NULL or Other_Provider_Identifier_Type_Code_9 is not NULL or Other_Provider_Identifier_Issuer_9 is not NULL or Other_Provider_Identifier_State_9 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 10, Other_Provider_Identifier_10,Other_Provider_Identifier_Type_Code_10,Other_Provider_Identifier_Issuer_10,Other_Provider_Identifier_State_10 from NPPES_flat npf
where Other_Provider_Identifier_10 is not NULL or Other_Provider_Identifier_Type_Code_10 is not NULL or Other_Provider_Identifier_Issuer_10 is not NULL or Other_Provider_Identifier_State_10 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 11, Other_Provider_Identifier_11,Other_Provider_Identifier_Type_Code_11,Other_Provider_Identifier_Issuer_11,Other_Provider_Identifier_State_11 from NPPES_flat npf
where Other_Provider_Identifier_11 is not NULL or Other_Provider_Identifier_Type_Code_11 is not NULL or Other_Provider_Identifier_Issuer_11 is not NULL or Other_Provider_Identifier_State_11 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 12, Other_Provider_Identifier_12,Other_Provider_Identifier_Type_Code_12,Other_Provider_Identifier_Issuer_12,Other_Provider_Identifier_State_12 from NPPES_flat npf
where Other_Provider_Identifier_12 is not NULL or Other_Provider_Identifier_Type_Code_12 is not NULL or Other_Provider_Identifier_Issuer_12 is not NULL or Other_Provider_Identifier_State_12 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 13, Other_Provider_Identifier_13,Other_Provider_Identifier_Type_Code_13,Other_Provider_Identifier_Issuer_13,Other_Provider_Identifier_State_13 from NPPES_flat npf
where Other_Provider_Identifier_13 is not NULL or Other_Provider_Identifier_Type_Code_13 is not NULL or Other_Provider_Identifier_Issuer_13 is not NULL or Other_Provider_Identifier_State_13 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 14, Other_Provider_Identifier_14,Other_Provider_Identifier_Type_Code_14,Other_Provider_Identifier_Issuer_14,Other_Provider_Identifier_State_14 from NPPES_flat npf
where Other_Provider_Identifier_14 is not NULL or Other_Provider_Identifier_Type_Code_14 is not NULL or Other_Provider_Identifier_Issuer_14 is not NULL or Other_Provider_Identifier_State_14 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 15, Other_Provider_Identifier_15,Other_Provider_Identifier_Type_Code_15,Other_Provider_Identifier_Issuer_15,Other_Provider_Identifier_State_15 from NPPES_flat npf
where Other_Provider_Identifier_15 is not NULL or Other_Provider_Identifier_Type_Code_15 is not NULL or Other_Provider_Identifier_Issuer_15 is not NULL or Other_Provider_Identifier_State_15 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 16, Other_Provider_Identifier_16,Other_Provider_Identifier_Type_Code_16,Other_Provider_Identifier_Issuer_16,Other_Provider_Identifier_State_16 from NPPES_flat npf
where Other_Provider_Identifier_16 is not NULL or Other_Provider_Identifier_Type_Code_16 is not NULL or Other_Provider_Identifier_Issuer_16 is not NULL or Other_Provider_Identifier_State_16 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 17, Other_Provider_Identifier_17,Other_Provider_Identifier_Type_Code_17,Other_Provider_Identifier_Issuer_17,Other_Provider_Identifier_State_17 from NPPES_flat npf
where Other_Provider_Identifier_17 is not NULL or Other_Provider_Identifier_Type_Code_17 is not NULL or Other_Provider_Identifier_Issuer_17 is not NULL or Other_Provider_Identifier_State_17 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 18, Other_Provider_Identifier_18,Other_Provider_Identifier_Type_Code_18,Other_Provider_Identifier_Issuer_18,Other_Provider_Identifier_State_18 from NPPES_flat npf
where Other_Provider_Identifier_18 is not NULL or Other_Provider_Identifier_Type_Code_18 is not NULL or Other_Provider_Identifier_Issuer_18 is not NULL or Other_Provider_Identifier_State_18 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 19, Other_Provider_Identifier_19,Other_Provider_Identifier_Type_Code_19,Other_Provider_Identifier_Issuer_19,Other_Provider_Identifier_State_19 from NPPES_flat npf
where Other_Provider_Identifier_19 is not NULL or Other_Provider_Identifier_Type_Code_19 is not NULL or Other_Provider_Identifier_Issuer_19 is not NULL or Other_Provider_Identifier_State_19 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 20, Other_Provider_Identifier_20,Other_Provider_Identifier_Type_Code_20,Other_Provider_Identifier_Issuer_20,Other_Provider_Identifier_State_20 from NPPES_flat npf
where Other_Provider_Identifier_20 is not NULL or Other_Provider_Identifier_Type_Code_20 is not NULL or Other_Provider_Identifier_Issuer_20 is not NULL or Other_Provider_Identifier_State_20 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 21, Other_Provider_Identifier_21,Other_Provider_Identifier_Type_Code_21,Other_Provider_Identifier_Issuer_21,Other_Provider_Identifier_State_21 from NPPES_flat npf
where Other_Provider_Identifier_21 is not NULL or Other_Provider_Identifier_Type_Code_21 is not NULL or Other_Provider_Identifier_Issuer_21 is not NULL or Other_Provider_Identifier_State_21 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 22, Other_Provider_Identifier_22,Other_Provider_Identifier_Type_Code_22,Other_Provider_Identifier_Issuer_22,Other_Provider_Identifier_State_22 from NPPES_flat npf
where Other_Provider_Identifier_22 is not NULL or Other_Provider_Identifier_Type_Code_22 is not NULL or Other_Provider_Identifier_Issuer_22 is not NULL or Other_Provider_Identifier_State_22 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 23, Other_Provider_Identifier_23,Other_Provider_Identifier_Type_Code_23,Other_Provider_Identifier_Issuer_23,Other_Provider_Identifier_State_23 from NPPES_flat npf
where Other_Provider_Identifier_23 is not NULL or Other_Provider_Identifier_Type_Code_23 is not NULL or Other_Provider_Identifier_Issuer_23 is not NULL or Other_Provider_Identifier_State_23 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 24, Other_Provider_Identifier_24,Other_Provider_Identifier_Type_Code_24,Other_Provider_Identifier_Issuer_24,Other_Provider_Identifier_State_24 from NPPES_flat npf
where Other_Provider_Identifier_24 is not NULL or Other_Provider_Identifier_Type_Code_24 is not NULL or Other_Provider_Identifier_Issuer_24 is not NULL or Other_Provider_Identifier_State_24 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 25, Other_Provider_Identifier_25,Other_Provider_Identifier_Type_Code_25,Other_Provider_Identifier_Issuer_25,Other_Provider_Identifier_State_25 from NPPES_flat npf
where Other_Provider_Identifier_25 is not NULL or Other_Provider_Identifier_Type_Code_25 is not NULL or Other_Provider_Identifier_Issuer_25 is not NULL or Other_Provider_Identifier_State_25 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 26, Other_Provider_Identifier_26,Other_Provider_Identifier_Type_Code_26,Other_Provider_Identifier_Issuer_26,Other_Provider_Identifier_State_26 from NPPES_flat npf
where Other_Provider_Identifier_26 is not NULL or Other_Provider_Identifier_Type_Code_26 is not NULL or Other_Provider_Identifier_Issuer_26 is not NULL or Other_Provider_Identifier_State_26 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 27, Other_Provider_Identifier_27,Other_Provider_Identifier_Type_Code_27,Other_Provider_Identifier_Issuer_27,Other_Provider_Identifier_State_27 from NPPES_flat npf
where Other_Provider_Identifier_27 is not NULL or Other_Provider_Identifier_Type_Code_27 is not NULL or Other_Provider_Identifier_Issuer_27 is not NULL or Other_Provider_Identifier_State_27 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 28, Other_Provider_Identifier_28,Other_Provider_Identifier_Type_Code_28,Other_Provider_Identifier_Issuer_28,Other_Provider_Identifier_State_28 from NPPES_flat npf
where Other_Provider_Identifier_28 is not NULL or Other_Provider_Identifier_Type_Code_28 is not NULL or Other_Provider_Identifier_Issuer_28 is not NULL or Other_Provider_Identifier_State_28 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 29, Other_Provider_Identifier_29,Other_Provider_Identifier_Type_Code_29,Other_Provider_Identifier_Issuer_29,Other_Provider_Identifier_State_29 from NPPES_flat npf
where Other_Provider_Identifier_29 is not NULL or Other_Provider_Identifier_Type_Code_29 is not NULL or Other_Provider_Identifier_Issuer_29 is not NULL or Other_Provider_Identifier_State_29 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 30, Other_Provider_Identifier_30,Other_Provider_Identifier_Type_Code_30,Other_Provider_Identifier_Issuer_30,Other_Provider_Identifier_State_30 from NPPES_flat npf
where Other_Provider_Identifier_30 is not NULL or Other_Provider_Identifier_Type_Code_30 is not NULL or Other_Provider_Identifier_Issuer_30 is not NULL or Other_Provider_Identifier_State_30 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 31, Other_Provider_Identifier_31,Other_Provider_Identifier_Type_Code_31,Other_Provider_Identifier_Issuer_31,Other_Provider_Identifier_State_31 from NPPES_flat npf
where Other_Provider_Identifier_31 is not NULL or Other_Provider_Identifier_Type_Code_31 is not NULL or Other_Provider_Identifier_Issuer_31 is not NULL or Other_Provider_Identifier_State_31 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 32, Other_Provider_Identifier_32,Other_Provider_Identifier_Type_Code_32,Other_Provider_Identifier_Issuer_32,Other_Provider_Identifier_State_32 from NPPES_flat npf
where Other_Provider_Identifier_32 is not NULL or Other_Provider_Identifier_Type_Code_32 is not NULL or Other_Provider_Identifier_Issuer_32 is not NULL or Other_Provider_Identifier_State_32 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 33, Other_Provider_Identifier_33,Other_Provider_Identifier_Type_Code_33,Other_Provider_Identifier_Issuer_33,Other_Provider_Identifier_State_33 from NPPES_flat npf
where Other_Provider_Identifier_33 is not NULL or Other_Provider_Identifier_Type_Code_33 is not NULL or Other_Provider_Identifier_Issuer_33 is not NULL or Other_Provider_Identifier_State_33 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 34, Other_Provider_Identifier_34,Other_Provider_Identifier_Type_Code_34,Other_Provider_Identifier_Issuer_34,Other_Provider_Identifier_State_34 from NPPES_flat npf
where Other_Provider_Identifier_34 is not NULL or Other_Provider_Identifier_Type_Code_34 is not NULL or Other_Provider_Identifier_Issuer_34 is not NULL or Other_Provider_Identifier_State_34 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 35, Other_Provider_Identifier_35,Other_Provider_Identifier_Type_Code_35,Other_Provider_Identifier_Issuer_35,Other_Provider_Identifier_State_35 from NPPES_flat npf
where Other_Provider_Identifier_35 is not NULL or Other_Provider_Identifier_Type_Code_35 is not NULL or Other_Provider_Identifier_Issuer_35 is not NULL or Other_Provider_Identifier_State_35 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 36, Other_Provider_Identifier_36,Other_Provider_Identifier_Type_Code_36,Other_Provider_Identifier_Issuer_36,Other_Provider_Identifier_State_36 from NPPES_flat npf
where Other_Provider_Identifier_36 is not NULL or Other_Provider_Identifier_Type_Code_36 is not NULL or Other_Provider_Identifier_Issuer_36 is not NULL or Other_Provider_Identifier_State_36 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 37, Other_Provider_Identifier_37,Other_Provider_Identifier_Type_Code_37,Other_Provider_Identifier_Issuer_37,Other_Provider_Identifier_State_37 from NPPES_flat npf
where Other_Provider_Identifier_37 is not NULL or Other_Provider_Identifier_Type_Code_37 is not NULL or Other_Provider_Identifier_Issuer_37 is not NULL or Other_Provider_Identifier_State_37 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 38, Other_Provider_Identifier_38,Other_Provider_Identifier_Type_Code_38,Other_Provider_Identifier_Issuer_38,Other_Provider_Identifier_State_38 from NPPES_flat npf
where Other_Provider_Identifier_38 is not NULL or Other_Provider_Identifier_Type_Code_38 is not NULL or Other_Provider_Identifier_Issuer_38 is not NULL or Other_Provider_Identifier_State_38 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 39, Other_Provider_Identifier_39,Other_Provider_Identifier_Type_Code_39,Other_Provider_Identifier_Issuer_39,Other_Provider_Identifier_State_39 from NPPES_flat npf
where Other_Provider_Identifier_39 is not NULL or Other_Provider_Identifier_Type_Code_39 is not NULL or Other_Provider_Identifier_Issuer_39 is not NULL or Other_Provider_Identifier_State_39 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 40, Other_Provider_Identifier_40,Other_Provider_Identifier_Type_Code_40,Other_Provider_Identifier_Issuer_40,Other_Provider_Identifier_State_40 from NPPES_flat npf
where Other_Provider_Identifier_40 is not NULL or Other_Provider_Identifier_Type_Code_40 is not NULL or Other_Provider_Identifier_Issuer_40 is not NULL or Other_Provider_Identifier_State_40 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 41, Other_Provider_Identifier_41,Other_Provider_Identifier_Type_Code_41,Other_Provider_Identifier_Issuer_41,Other_Provider_Identifier_State_41 from NPPES_flat npf
where Other_Provider_Identifier_41 is not NULL or Other_Provider_Identifier_Type_Code_41 is not NULL or Other_Provider_Identifier_Issuer_41 is not NULL or Other_Provider_Identifier_State_41 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 42, Other_Provider_Identifier_42,Other_Provider_Identifier_Type_Code_42,Other_Provider_Identifier_Issuer_42,Other_Provider_Identifier_State_42 from NPPES_flat npf
where Other_Provider_Identifier_42 is not NULL or Other_Provider_Identifier_Type_Code_42 is not NULL or Other_Provider_Identifier_Issuer_42 is not NULL or Other_Provider_Identifier_State_42 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 43, Other_Provider_Identifier_43,Other_Provider_Identifier_Type_Code_43,Other_Provider_Identifier_Issuer_43,Other_Provider_Identifier_State_43 from NPPES_flat npf
where Other_Provider_Identifier_43 is not NULL or Other_Provider_Identifier_Type_Code_43 is not NULL or Other_Provider_Identifier_Issuer_43 is not NULL or Other_Provider_Identifier_State_43 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 44, Other_Provider_Identifier_44,Other_Provider_Identifier_Type_Code_44,Other_Provider_Identifier_Issuer_44,Other_Provider_Identifier_State_44 from NPPES_flat npf
where Other_Provider_Identifier_44 is not NULL or Other_Provider_Identifier_Type_Code_44 is not NULL or Other_Provider_Identifier_Issuer_44 is not NULL or Other_Provider_Identifier_State_44 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 45, Other_Provider_Identifier_45,Other_Provider_Identifier_Type_Code_45,Other_Provider_Identifier_Issuer_45,Other_Provider_Identifier_State_45 from NPPES_flat npf
where Other_Provider_Identifier_45 is not NULL or Other_Provider_Identifier_Type_Code_45 is not NULL or Other_Provider_Identifier_Issuer_45 is not NULL or Other_Provider_Identifier_State_45 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 46, Other_Provider_Identifier_46,Other_Provider_Identifier_Type_Code_46,Other_Provider_Identifier_Issuer_46,Other_Provider_Identifier_State_46 from NPPES_flat npf
where Other_Provider_Identifier_46 is not NULL or Other_Provider_Identifier_Type_Code_46 is not NULL or Other_Provider_Identifier_Issuer_46 is not NULL or Other_Provider_Identifier_State_46 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 47, Other_Provider_Identifier_47,Other_Provider_Identifier_Type_Code_47,Other_Provider_Identifier_Issuer_47,Other_Provider_Identifier_State_47 from NPPES_flat npf
where Other_Provider_Identifier_47 is not NULL or Other_Provider_Identifier_Type_Code_47 is not NULL or Other_Provider_Identifier_Issuer_47 is not NULL or Other_Provider_Identifier_State_47 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 48, Other_Provider_Identifier_48,Other_Provider_Identifier_Type_Code_48,Other_Provider_Identifier_Issuer_48,Other_Provider_Identifier_State_48 from NPPES_flat npf
where Other_Provider_Identifier_48 is not NULL or Other_Provider_Identifier_Type_Code_48 is not NULL or Other_Provider_Identifier_Issuer_48 is not NULL or Other_Provider_Identifier_State_48 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 49, Other_Provider_Identifier_49,Other_Provider_Identifier_Type_Code_49,Other_Provider_Identifier_Issuer_49,Other_Provider_Identifier_State_49 from NPPES_flat npf
where Other_Provider_Identifier_49 is not NULL or Other_Provider_Identifier_Type_Code_49 is not NULL or Other_Provider_Identifier_Issuer_49 is not NULL or Other_Provider_Identifier_State_49 is not NULL;

insert into other_provider_identifiers (npi,sequence_id,Other_Provider_Identifier,Other_Provider_Identifier_Type_Code,Other_Provider_Identifier_Issuer,Other_Provider_Identifier_State)
    select npf.npi, 50, Other_Provider_Identifier_50,Other_Provider_Identifier_Type_Code_50,Other_Provider_Identifier_Issuer_50,Other_Provider_Identifier_State_50 from NPPES_flat npf
where Other_Provider_Identifier_50 is not NULL or Other_Provider_Identifier_Type_Code_50 is not NULL or Other_Provider_Identifier_Issuer_50 is not NULL or Other_Provider_Identifier_State_50 is not NULL;



drop table if exists provider_licenses;
create table provider_licenses (
    npi char(10),
    sequence_id integer,
    Healthcare_Provider_Taxonomy_Code VARCHAR(10),
    Provider_License_Number VARCHAR(20),
    Provider_License_Number_State_Code VARCHAR(2),
    Healthcare_Provider_Primary_Taxonomy_Switch VARCHAR(1));

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 1, Healthcare_Provider_Taxonomy_Code_1,Provider_License_Number_1,Provider_License_Number_State_Code_1,Healthcare_Provider_Primary_Taxonomy_Switch_1 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_1 is not NULL or Provider_License_Number_1 is not NULL or Provider_License_Number_State_Code_1 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_1 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 2, Healthcare_Provider_Taxonomy_Code_2,Provider_License_Number_2,Provider_License_Number_State_Code_2,Healthcare_Provider_Primary_Taxonomy_Switch_2 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_2 is not NULL or Provider_License_Number_2 is not NULL or Provider_License_Number_State_Code_2 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_2 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 3, Healthcare_Provider_Taxonomy_Code_3,Provider_License_Number_3,Provider_License_Number_State_Code_3,Healthcare_Provider_Primary_Taxonomy_Switch_3 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_3 is not NULL or Provider_License_Number_3 is not NULL or Provider_License_Number_State_Code_3 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_3 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 4, Healthcare_Provider_Taxonomy_Code_4,Provider_License_Number_4,Provider_License_Number_State_Code_4,Healthcare_Provider_Primary_Taxonomy_Switch_4 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_4 is not NULL or Provider_License_Number_4 is not NULL or Provider_License_Number_State_Code_4 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_4 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 5, Healthcare_Provider_Taxonomy_Code_5,Provider_License_Number_5,Provider_License_Number_State_Code_5,Healthcare_Provider_Primary_Taxonomy_Switch_5 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_5 is not NULL or Provider_License_Number_5 is not NULL or Provider_License_Number_State_Code_5 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_5 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 6, Healthcare_Provider_Taxonomy_Code_6,Provider_License_Number_6,Provider_License_Number_State_Code_6,Healthcare_Provider_Primary_Taxonomy_Switch_6 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_6 is not NULL or Provider_License_Number_6 is not NULL or Provider_License_Number_State_Code_6 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_6 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 7, Healthcare_Provider_Taxonomy_Code_7,Provider_License_Number_7,Provider_License_Number_State_Code_7,Healthcare_Provider_Primary_Taxonomy_Switch_7 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_7 is not NULL or Provider_License_Number_7 is not NULL or Provider_License_Number_State_Code_7 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_7 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 8, Healthcare_Provider_Taxonomy_Code_8,Provider_License_Number_8,Provider_License_Number_State_Code_8,Healthcare_Provider_Primary_Taxonomy_Switch_8 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_8 is not NULL or Provider_License_Number_8 is not NULL or Provider_License_Number_State_Code_8 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_8 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 9, Healthcare_Provider_Taxonomy_Code_9,Provider_License_Number_9,Provider_License_Number_State_Code_9,Healthcare_Provider_Primary_Taxonomy_Switch_9 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_9 is not NULL or Provider_License_Number_9 is not NULL or Provider_License_Number_State_Code_9 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_9 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 10, Healthcare_Provider_Taxonomy_Code_10,Provider_License_Number_10,Provider_License_Number_State_Code_10,Healthcare_Provider_Primary_Taxonomy_Switch_10 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_10 is not NULL or Provider_License_Number_10 is not NULL or Provider_License_Number_State_Code_10 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_10 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 11, Healthcare_Provider_Taxonomy_Code_11,Provider_License_Number_11,Provider_License_Number_State_Code_11,Healthcare_Provider_Primary_Taxonomy_Switch_11 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_11 is not NULL or Provider_License_Number_11 is not NULL or Provider_License_Number_State_Code_11 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_11 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 12, Healthcare_Provider_Taxonomy_Code_12,Provider_License_Number_12,Provider_License_Number_State_Code_12,Healthcare_Provider_Primary_Taxonomy_Switch_12 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_12 is not NULL or Provider_License_Number_12 is not NULL or Provider_License_Number_State_Code_12 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_12 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 13, Healthcare_Provider_Taxonomy_Code_13,Provider_License_Number_13,Provider_License_Number_State_Code_13,Healthcare_Provider_Primary_Taxonomy_Switch_13 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_13 is not NULL or Provider_License_Number_13 is not NULL or Provider_License_Number_State_Code_13 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_13 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 14, Healthcare_Provider_Taxonomy_Code_14,Provider_License_Number_14,Provider_License_Number_State_Code_14,Healthcare_Provider_Primary_Taxonomy_Switch_14 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_14 is not NULL or Provider_License_Number_14 is not NULL or Provider_License_Number_State_Code_14 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_14 is not NULL;

insert into provider_licenses (npi,sequence_id,Healthcare_Provider_Taxonomy_Code,Provider_License_Number,Provider_License_Number_State_Code,Healthcare_Provider_Primary_Taxonomy_Switch)
    select npf.npi, 15, Healthcare_Provider_Taxonomy_Code_15,Provider_License_Number_15,Provider_License_Number_State_Code_15,Healthcare_Provider_Primary_Taxonomy_Switch_15 from NPPES_flat npf
where Healthcare_Provider_Taxonomy_Code_15 is not NULL or Provider_License_Number_15 is not NULL or Provider_License_Number_State_Code_15 is not NULL or Healthcare_Provider_Primary_Taxonomy_Switch_15 is not NULL;



drop table if exists NPPES_header;
    create table NPPES_header (
    NPI CHAR(10),
    Entity_Type_Code CHAR(1),
    Replacement_NPI CHAR(10),
    Employer_Identification_Number_EIN VARCHAR(9),
    Provider_Organization_Name_Legal_Business_Name VARCHAR(70),
    Provider_Last_Name_Legal_Name VARCHAR(35),
    Provider_First_Name VARCHAR(20),
    Provider_Middle_Name VARCHAR(20),
    Provider_Name_Prefix_Text VARCHAR(5),
    Provider_Name_Suffix_Text VARCHAR(5),
    Provider_Credential_Text VARCHAR(20),
    Provider_Other_Organization_Name VARCHAR(70),
    Provider_Other_Organization_Name_Type_Code VARCHAR(1),
    Provider_Other_Last_Name VARCHAR(35),
    Provider_Other_First_Name VARCHAR(20),
    Provider_Other_Middle_Name VARCHAR(20),
    Provider_Other_Name_Prefix_Text VARCHAR(5),
    Provider_Other_Name_Suffix_Text VARCHAR(5),
    Provider_Other_Credential_Text VARCHAR(20),
    Provider_Other_Last_Name_Type_Code CHAR(1),
    Provider_First_Line_Business_Mailing_Address VARCHAR(55),
    Provider_Second_Line_Business_Mailing_Address VARCHAR(55),
    Provider_Business_Mailing_Address_City_Name VARCHAR(40),
    Provider_Business_Mailing_Address_State_Name VARCHAR(40),
    Provider_Business_Mailing_Address_Postal_Code VARCHAR(20),
    Provider_Business_Mailing_Address_Country_Cod VARCHAR(2),
    Provider_Business_Mailing_Address_Telephone_Number VARCHAR(20),
    Provider_Business_Mailing_Address_Fax_Number VARCHAR(20),
    Provider_First_Line_Business_Practice_Location_Address VARCHAR(55),
    Provider_Second_Line_Business_Practice_Location_Address VARCHAR(55),
    Provider_Business_Practice_Location_Address_City_Name VARCHAR(40),
    Provider_Business_Practice_Location_Address_State_Name VARCHAR(40),
    Provider_Business_Practice_Location_Address_Postal_Code VARCHAR(20),
    Provider_Business_Practice_Location_Address_Country_Cod VARCHAR(2),
    Provider_Business_Practice_Location_Address_Telephone_Number VARCHAR(20),
    Provider_Business_Practice_Location_Address_Fax_Number VARCHAR(20),
    Provider_Enumeration_Date DATE,
    Last_Update_Date DATE,
    NPI_Deactivation_Reason_Code VARCHAR(2),
    NPI_Deactivation_Date DATE,
    NPI_Reactivation_Date DATE,
    Provider_Gender_Code VARCHAR(1),
    Authorized_Official_Last_Name VARCHAR(35),
    Authorized_Official_First_Name VARCHAR(20),
    Authorized_Official_Middle_Name VARCHAR(20),
    Authorized_Official_Title_or_Position VARCHAR(35),
    Authorized_Official_Telephone_Number VARCHAR(20),
    Is_Sole_Proprietor VARCHAR(1),
    Is_Organization_Subpart VARCHAR(1),
    Parent_Organization_LBN VARCHAR(70),
    Parent_Organization_TIN VARCHAR(9),
    Authorized_Official_Name_Prefix_Text VARCHAR(5),
    Authorized_Official_Name_Suffix_Text VARCHAR(5),
    Authorized_Official_Credential_Text VARCHAR(20));

insert into NPPES_header (NPI,Entity_Type_Code,Replacement_NPI,Employer_Identification_Number_EIN,Provider_Organization_Name_Legal_Business_Name,Provider_Last_Name_Legal_Name,Provider_First_Name,Provider_Middle_Name,Provider_Name_Prefix_Text,Provider_Name_Suffix_Text,Provider_Credential_Text,Provider_Other_Organization_Name,Provider_Other_Organization_Name_Type_Code,Provider_Other_Last_Name,Provider_Other_First_Name,Provider_Other_Middle_Name,Provider_Other_Name_Prefix_Text,Provider_Other_Name_Suffix_Text,Provider_Other_Credential_Text,Provider_Other_Last_Name_Type_Code,Provider_First_Line_Business_Mailing_Address,Provider_Second_Line_Business_Mailing_Address,Provider_Business_Mailing_Address_City_Name,Provider_Business_Mailing_Address_State_Name,Provider_Business_Mailing_Address_Postal_Code,Provider_Business_Mailing_Address_Country_Cod,Provider_Business_Mailing_Address_Telephone_Number,Provider_Business_Mailing_Address_Fax_Number,Provider_First_Line_Business_Practice_Location_Address,Provider_Second_Line_Business_Practice_Location_Address,Provider_Business_Practice_Location_Address_City_Name,Provider_Business_Practice_Location_Address_State_Name,Provider_Business_Practice_Location_Address_Postal_Code,Provider_Business_Practice_Location_Address_Country_Cod,Provider_Business_Practice_Location_Address_Telephone_Number,Provider_Business_Practice_Location_Address_Fax_Number,Provider_Enumeration_Date,Last_Update_Date,NPI_Deactivation_Reason_Code,NPI_Deactivation_Date,NPI_Reactivation_Date,Provider_Gender_Code,Authorized_Official_Last_Name,Authorized_Official_First_Name,Authorized_Official_Middle_Name,Authorized_Official_Title_or_Position,Authorized_Official_Telephone_Number,Is_Sole_Proprietor,Is_Organization_Subpart,Parent_Organization_LBN,Parent_Organization_TIN,Authorized_Official_Name_Prefix_Text,Authorized_Official_Name_Suffix_Text,Authorized_Official_Credential_Text)
    select NPI,Entity_Type_Code,Replacement_NPI,Employer_Identification_Number_EIN,Provider_Organization_Name_Legal_Business_Name,Provider_Last_Name_Legal_Name,Provider_First_Name,Provider_Middle_Name,Provider_Name_Prefix_Text,Provider_Name_Suffix_Text,Provider_Credential_Text,Provider_Other_Organization_Name,Provider_Other_Organization_Name_Type_Code,Provider_Other_Last_Name,Provider_Other_First_Name,Provider_Other_Middle_Name,Provider_Other_Name_Prefix_Text,Provider_Other_Name_Suffix_Text,Provider_Other_Credential_Text,Provider_Other_Last_Name_Type_Code,Provider_First_Line_Business_Mailing_Address,Provider_Second_Line_Business_Mailing_Address,Provider_Business_Mailing_Address_City_Name,Provider_Business_Mailing_Address_State_Name,Provider_Business_Mailing_Address_Postal_Code,Provider_Business_Mailing_Address_Country_Cod,Provider_Business_Mailing_Address_Telephone_Number,Provider_Business_Mailing_Address_Fax_Number,Provider_First_Line_Business_Practice_Location_Address,Provider_Second_Line_Business_Practice_Location_Address,Provider_Business_Practice_Location_Address_City_Name,Provider_Business_Practice_Location_Address_State_Name,Provider_Business_Practice_Location_Address_Postal_Code,Provider_Business_Practice_Location_Address_Country_Cod,Provider_Business_Practice_Location_Address_Telephone_Number,Provider_Business_Practice_Location_Address_Fax_Number,Provider_Enumeration_Date,Last_Update_Date,NPI_Deactivation_Reason_Code,NPI_Deactivation_Date,NPI_Reactivation_Date,Provider_Gender_Code,Authorized_Official_Last_Name,Authorized_Official_First_Name,Authorized_Official_Middle_Name,Authorized_Official_Title_or_Position,Authorized_Official_Telephone_Number,Is_Sole_Proprietor,Is_Organization_Subpart,Parent_Organization_LBN,Parent_Organization_TIN,Authorized_Official_Name_Prefix_Text,Authorized_Official_Name_Suffix_Text,Authorized_Official_Credential_Text from NPPES_flat;

drop table if exists healthcare_provider_taxonomies;
create table healthcare_provider_taxonomies (
    taxonomy_code char(10) not null,
    provider_type varchar(255),
    classification varchar(255),
    specialization varchar(1024),
    definition text,
    notes text);
        
LOAD DATA INFILE '/data/npi/nucc_taxonomy_121.csv' INTO TABLE healthcare_provider_taxonomies
      FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\0'
      LINES TERMINATED BY '\r\n'
      IGNORE 1 LINES
