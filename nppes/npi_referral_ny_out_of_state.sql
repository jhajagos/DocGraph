create UNIQUE index pk_npi_nppes_header on npi.nppes_header(npi);

create index idx_provider_licenses on npi.provider_licenses(npi);

create index idx_referral2011_from_npi on referral.referral2011(npi_from);

create index idx_referral2011_to_npi on referral.referral2011(npi_to);


select nr.weight,fp.*,tp.*, 
  concat(pt1.provider_type,
    if(pt1.specialization is null,'',concat(' - ', pt1.specialization))) as from_taxonomy_name,
  concat(pt1.provider_type,
    if(pt2.specialization is null,'',concat(' - ', pt2.specialization))) as to_taxonomy_name
  from 
  (
    select nh1.npi as from_npi,nh1.Provider_Business_Practice_Location_Address_State_Name as from_state,
      nh1.Provider_Business_Practice_Location_Address_Postal_Code as from_zip, nh1.Provider_Business_Practice_Location_Address_City_Name as from_city,
      nh1.Is_Sole_Proprietor as from_sole_provider,
      case 
        when nh1.Provider_Organization_Name_Legal_Business_Name is not null then nh1.Provider_Organization_Name_Legal_Business_Name
          else concat(rtrim(nh1.Provider_Last_Name_Legal_Name),', ',rtrim(nh1.Provider_First_Name),' ', 
            if(nh1.provider_credential_text is null,'',nh1.provider_credential_text))  
      end as from_provider_name,
      pl1.Healthcare_Provider_Taxonomy_Code as from_taxonomy_code
     from npi.nppes_header nh1
      left outer join npi.provider_licenses pl1 on pl1.npi = nh1.NPI
     where nh1.Provider_Business_Practice_Location_Address_State_Name = 'NY') fp
 join referral.referral2011 nr on nr.npi_from = fp.from_npi
 join 
 (
  select nh2.npi as to_npi,nh2.Provider_Business_Practice_Location_Address_State_Name as to_state,
      nh2.Provider_Business_Practice_Location_Address_Postal_Code as to_zip, nh2.Provider_Business_Practice_Location_Address_City_Name as to_city,
      nh2.Is_Sole_Proprietor as to_sole_provider,
      case 
        when nh2.Provider_Organization_Name_Legal_Business_Name is not null then nh2.Provider_Organization_Name_Legal_Business_Name
          else concat(rtrim(nh2.Provider_Last_Name_Legal_Name),', ',rtrim(nh2.Provider_First_Name),' ', 
            if(nh2.provider_credential_text is null,'',nh2.provider_credential_text))  
      end as to_provider_name,
     pl2.Healthcare_Provider_Taxonomy_Code as to_taxonomy_code
    from npi.nppes_header nh2
    left outer join npi.provider_licenses pl2 on pl2.npi = nh2.NPI
 ) tp
 on tp.to_npi = nr.npi_to
 left outer join npi.healthcare_provider_taxonomies pt1 on pt1.taxonomy_code = from_taxonomy_code
 left outer join npi.healthcare_provider_taxonomies pt2 on pt2.taxonomy_code = to_taxonomy_code
 ;
 
 use referral;
 drop table npi_summary_taxonomy;
 create table npi_summary_taxonomy (npi  char(10), 
 state varchar(2), 
 city varchar(255),
 zip varchar(16),
 sole_provider varchar(16),
 provider_name varchar(1023),
 sequence_id int,
 taxonomy_code varchar(16), 
 taxonomy_name varchar(1023)
 ); 
 
 insert into npi_summary_taxonomy
  (npi,state,zip,city,sole_provider,provider_name,sequence_id,taxonomy_code,taxonomy_name)
 select fp.*, 
  concat(pt1.provider_type,
    if(pt1.classification = '','',concat(' - ', pt1.classification)),
    if(pt1.specialization = '','',concat(' - ', pt1.specialization))) as taxonomy_name
  from 
  (
    select nh1.npi as npi,nh1.Provider_Business_Practice_Location_Address_State_Name as state,
      nh1.Provider_Business_Practice_Location_Address_Postal_Code as zip, nh1.Provider_Business_Practice_Location_Address_City_Name as city,
      nh1.Is_Sole_Proprietor as sole_provider,
      case 
        when nh1.Provider_Organization_Name_Legal_Business_Name is not null then nh1.Provider_Organization_Name_Legal_Business_Name
          else concat(rtrim(nh1.Provider_Last_Name_Legal_Name),', ',rtrim(nh1.Provider_First_Name),' ', 
            if(nh1.provider_credential_text is null,'',nh1.provider_credential_text))  
      end as provider_name,pl1.sequence_id,
      pl1.Healthcare_Provider_Taxonomy_Code as taxonomy_code
     from npi.nppes_header nh1
      left outer join npi.provider_licenses pl1 on pl1.npi = nh1.NPI
      
      ) fp
     left outer join npi.healthcare_provider_taxonomies pt1 on pt1.taxonomy_code = fp.taxonomy_code; 
     
  create index idx_npi_summary on referral.npi_summary_taxonomy (npi);
 
 select r.weight, nst1.npi as from_npi, nst1.state as from_state, nst1.city as from_city, nst1.zip as from_zip, nst1.sole_provider as from_sole_provider, 
  nst1.provider_name as from_provider_name, nst1.sequence_id as from_sequence_id, nst1.taxonomy_code as from_taxonomy_code, 
   nst1.taxonomy_name as from_taxonomy_name,
  nst2.npi as to_npi, nst2.state as to_state, nst2.city as to_city, nst2.zip as to_zip, nst2.sole_provider as to_sole_provider, 
  nst2.provider_name as to_provider_name, nst2.sequence_id as to_sequence_id, 
  nst2.taxonomy_code as to_taxonomy_code, nst2.taxonomy_name as to_taxonomy_name
 /* into outfile '/tmp/ny_referrals.csv'
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n' */
  from referral.npi_summary_taxonomy nst1 join referral.referral2011 r on nst1.npi = r.npi_from
  join referral.npi_summary_taxonomy nst2 on nst2.npi = r.npi_to
  where (nst1.state = 'NY' and nst2.state = 'NY')
    or (nst1.state = 'NY' and nst2.state != 'NY')
    or (nst1.state != 'NY' and nst2.state = 'NY')
    and nst1.sequence_id = 1 and nst2.sequence_id = 1 and 1 = 2;
  
  
  