select * from healthcare_provider_taxonomy_processed hptp
join nppes_header nh on nh.npi = hptp.npi
where hptp.is_orthopaedic_surgery = 1;

drop table if exists nppes_contact;
create table nppes_contact (
 id  integer auto_increment primary key,
 address_type varchar(15),
 npi char(10),
 First_Line varchar(55),
 Second_Line varchar(55),
 City varchar(40),
 State varchar(40),
 Postal_Code varchar(20),
 Country_Code varchar(2),
 address_flattened varchar(1023),
 address_formatted varchar(1023),
 phone varchar(20),
 fax varchar(20),
 address_hash varchar(1024)
);
/*alter table nppes_contact add address_flattened varchar(1023); */

alter table nppes_contact add id integer auto_increment primary key;

insert into nppes_contact (address_type, npi, first_line, second_line, city, state, postal_code, country_code, phone, fax)
  select 'business',nh.npi, nh.Provider_First_Line_Business_Mailing_Address, nh.Provider_Second_Line_Business_Mailing_Address, nh.Provider_Business_Mailing_Address_City_Name, 
    nh.Provider_Business_Mailing_Address_State_Name, nh.Provider_Business_Mailing_Address_Postal_Code, 
    nh.Provider_Business_Mailing_Address_Country_Cod, 
    nh.Provider_Business_Mailing_Address_Telephone_Number, nh.Provider_Business_Mailing_Address_Fax_Number
    from nppes_header nh
    ; 

insert into nppes_contact (address_type, npi, first_line, second_line, city, state, postal_code, country_code, phone, fax)
  select 'practice', nh.NPI, nh.Provider_First_Line_Business_Practice_Location_Address, nh.Provider_Second_Line_Business_Practice_Location_Address, nh.Provider_Business_Practice_Location_Address_City_Name, 
    nh.Provider_Business_Practice_Location_Address_State_Name, nh.Provider_Business_Practice_Location_Address_Postal_Code, 
    nh.Provider_Business_Practice_Location_Address_Country_Cod, nh.Provider_Business_Practice_Location_Address_Fax_Number, 
    nh.Provider_Business_Practice_Location_Address_Telephone_Number from nppes_header nh;


delete from nppes_contact where first_line is null and second_line is null and city is null and postal_code is null
  and country_code is null and phone is null and fax is null;
  
update nppes_contact set address_flattened = 
  concat(case when first_line is not null then concat('|',first_line,'|') else '||' end,
         case when second_line is not null then concat('|', second_line,'|') else '||' end,
         case when city is not null then concat('|', city,'|') else '||' end,
         case when postal_code is not null then concat('|', postal_code,'|') else '||' end,
         case when country_code is not null then concat('|', country_code, '|') else '||' end);
         
 update nppes_contact set address_hash = password(address_flattened);
 
 create table temp_max_id_address (max_id integer, counter integer, address_hash varchar(1023));
 
 insert into temp_max_id_address (max_id, counter, address_hash)
  select max(id),count(*),address_hash from nppes_contact group by address_hash order by count(*) desc;


create table address 
  (id integer primary key auto_increment, 
    first_line varchar(55),
    second_line varchar(55),
    city varchar(40),
    state varchar(40),
    postal_code varchar(20),
    country_code varchar(2),
    address_flattened varchar(1023),
    address_formatted varchar(1023),
    address_hash varchar(1023),
    latitude float,
    longitude float
    );
    
insert address (first_line, second_line, city, state, postal_code, country_code, address_flattened, address_formatted, address_hash)
  select nc.first_line, nc.second_line, nc.city, nc.state, nc.postal_code, nc.country_code, 
    nc.address_flattened, nc.address_formatted, nc.address_hash from nppes_contact nc 
   join temp_max_id_address tmi on tmi.address_hash = nc.address_hash and tmi.max_id = tc.id;  


 update address set zip5 = left(postal_code, 5), zip4 = substring(postal_code, 6);

alter table nppes_contact drop column first_line;
alter table nppes_contact drop column second_line;
alter table nppes_contact drop column city;
alter table nppes_contact drop column state;
alter table nppes_contact drop column postal_code;
alter table nppes_contact drop column address_formatted;
alter table nppes_contact drop column address_flattened;

select * from nppes_contact where address_hash = '*AB9D6C2A591E83F44FEA81E553A80FAA30C3E079';o6