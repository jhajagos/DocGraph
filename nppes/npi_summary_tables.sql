
 use referral;

 drop table npi_summary_taxonomy;
 create table npi_summary_taxonomy (npi  char(10), 
   state varchar(2),
   city varchar(255),
   zip varchar(16),
   zip5 varchar(5),
   sole_provider varchar(16),
   provider_name varchar(1023),
   sequence_id int,
   taxonomy_code varchar(16),
   taxonomy_name varchar(1023),
   flattened_taxonomy_string varchar(1023),
   is_ambulance boolean,
   is_anesthesiology boolean,
   is_chiropractor boolean,
   is_clinic_center boolean,
   is_dentist boolean,
   is_dermatology boolean,
   is_emergency_medicine boolean,
   is_family_medicine boolean,
   is_internal_medicine boolean,
   is_pathology boolean,
   is_physical_therapist boolean,
   is_physician_assistant boolean,
   is_radiology boolean,
   is_registered_nurse boolean,
   is_surgery boolean,
   is_hospital boolean,
   is_laboratory boolean,
   is_physician boolean,
   is_diagnostic_radiology boolean,
   is_nuclear_radiology boolean,
   latitude float,
   longitude float
 ); 
 
insert into npi_summary_taxonomy
  (npi,state,zip,city,sole_provider,provider_name,sequence_id,taxonomy_code,taxonomy_name,
    flattened_taxonomy_string,
    is_ambulance,
    is_anesthesiology,
    is_chiropractor,
    is_clinic_center,
    is_dentist,
    is_dermatology,
    is_emergency_medicine,
    is_family_medicine,
    is_internal_medicine,
    is_pathology,
    is_physical_therapist,
    is_physician_assistant,
    is_radiology,
    is_registered_nurse,
    is_surgery,
    is_hospital,
    is_laboratory,
    is_physician,
    is_diagnostic_radiology,
    is_nuclear_radiology
  )
 select fp.*,
   concat(pt1.provider_type,
    if(pt1.classification = '','',concat(' - ', pt1.classification)),
    if(pt1.specialization = '','',concat(' - ', pt1.specialization))) as taxonomy_name,
    flattened_taxonomy_string,
    is_ambulance,
    is_anesthesiology,
    is_chiropractor,
    is_clinic_center,
    is_dentist,
    is_dermatology,
    is_emergency_medicine,
    is_family_medicine,
    is_internal_medicine,
    is_pathology,
    is_physical_therapist,
    is_physician_assistant,
    is_radiology,
    is_registered_nurse,
    is_surgery,
    is_hospital,
    is_laboratory,
    is_physician,
    is_diagnostic_radiology,
    is_nuclear_radiology
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
     left outer join npi.healthcare_provider_taxonomies pt1 on pt1.taxonomy_code = fp.taxonomy_code
     left outer join npi.healthcare_provider_taxonomy_processed hptp on hptp.npi = fp.npi
     ;

  update npi_summary_taxonomy set zip5 = left(zip, 5);

  create index idx_npi_summary on npi_summary_taxonomy (npi);

  create view npi_summary_primary_taxonomy as
    select * from
  npi_summary_taxonomy where sequence_id = 1;
