

create table npi_summary_detailed as 
 select fp.*,
   concat(pt1.provider_type,
    if(pt1.classification = '','',concat(' - ', pt1.classification)),
    if(pt1.specialization = '','',concat(' - ', pt1.specialization))) as taxonomy_name,
    pt1.classification,
    pt1.specialization,
    a.address_flattened,
    a.zip5,
    a.zip4,
    a.latitude,
    a.longitude,
    a.geocode_method,
    hptp.depth as taxonomy_depth, hptp.flattened_taxonomy_string, hptp.is_advanced_practice_midwife, hptp.is_allergy_and_immunology, hptp.is_ambulance, hptp.is_anesthesiologist_assistant, hptp.is_anesthesiology, hptp.is_assistant_podiatric, hptp.is_assisted_living_facility, hptp.is_behavioral_analyst, hptp.is_chiropractor, hptp.is_christian_science_sanitorium, hptp.is_clinic_center, hptp.is_clinical_nurse_specialist, hptp.is_clinical_pharmacology, hptp.is_colon_and_rectal_surgery, hptp.is_counselor, hptp.is_dentist, hptp.is_denturist, hptp.is_dermatology, hptp.is_durable_medical_equipment__medical_supplies, hptp.is_electrodiagnostic_medicine, hptp.is_emergency_medicine, hptp.is_family_medicine, hptp.is_general_acute_care_hospital, hptp.is_general_practice, hptp.is_genetic_counselor_ms, hptp.is_hospitalist, hptp.is_internal_medicine, hptp.is_legal_medicine, hptp.is_marriage_and_family_therapist, hptp.is_massage_therapist, hptp.is_medical_genetics, hptp.is_medical_genetics_phd_medical_genetics, hptp.is_military_hospital, hptp.is_multispecialty, hptp.is_neurological_surgery, hptp.is_neuromusculoskeletal_medicine_and_omm, hptp.is_nuclear_medicine, hptp.is_nurse_anesthetist_certified_registered, hptp.is_nurse_practitioner, hptp.is_obstetrics_and_gynecology, hptp.is_ophthalmology, hptp.is_optometrist, hptp.is_orthopaedic_surgery, hptp.is_otolaryngology, hptp.is_pain_medicine, hptp.is_pathology, hptp.is_pediatrics, hptp.is_pharmacist, hptp.is_pharmacy, hptp.is_pharmacy_technician, hptp.is_physical_medicine_and_rehabilitation, hptp.is_physical_therapist, hptp.is_physician_assistant, hptp.is_plastic_surgery, hptp.is_podiatrist, hptp.is_preventive_medicine, hptp.is_psychiatric_hospital, hptp.is_psychiatric_unit, hptp.is_psychiatry_and_neurology, hptp.is_psychoanalyst, hptp.is_psychologist, hptp.is_radiology, hptp.is_registered_nurse, hptp.is_rehabilitation_hospital, hptp.is_religious_nonmedical_health_care_institution, hptp.is_single_specialty, hptp.is_social_worker, hptp.is_special_hospital, hptp.is_surgery, hptp.is_thoracic_surgery_cardiothoracic_vascular_surgery, hptp.is_transplant_surgery, hptp.is_urology, hptp.is_behavioral_health_and_social_service_providers, hptp.is_hospital, hptp.is_laboratory, hptp.is_managed_care_organization, hptp.is_nursing_care_facility, hptp.is_residential_treatment_facility, hptp.is_student, hptp.is_supplier, hptp.is_physician, hptp.is_addiction_medicine, hptp.is_bariatric_medicine, hptp.is_body_imaging, hptp.is_cardiovascular_disease, hptp.is_clinical_and_laboratory_immunology, hptp.is_clinical_biochemical_genetics, hptp.is_clinical_cardiac_electrophysiology, hptp.is_clinical_cytogenetic, hptp.is_clinical_genetics_md, hptp.is_clinical_molecular_genetics, hptp.is_critical_care_medicine, hptp.is_dermatopathology, hptp.is_diagnostic_neuroimaging, hptp.is_diagnostic_radiology, hptp.is_diagnostic_ultrasound, hptp.is_endocrinology_diabetes_and_metabolism, hptp.is_endodontics, hptp.is_gastroenterology, hptp.is_geriatric_medicine, hptp.is_hematology, hptp.is_hematology_and_oncology, hptp.is_hepatology, hptp.is_hospice_and_palliative_medicine, hptp.is_hypertension_specialist, hptp.is_infectious_disease, hptp.is_interventional_cardiology, hptp.is_interventional_pain_medicine, hptp.is_mohsmicrographic_surgery, hptp.is_magnetic_resonance_imaging_mri, hptp.is_medical_oncology, hptp.is_molecular_genetic_pathology, hptp.is_nephrology, hptp.is_neurology, hptp.is_neuroradiology, hptp.is_nuclear_radiology, hptp.is_oral_and_maxillofacial_pathology, hptp.is_oral_and_maxillofacial_radiology, hptp.is_oral_and_maxillofacial_surgery, hptp.is_orthodontics_and_dentofacial_orthopedics, hptp.is_pediatric_dentistry, hptp.is_pediatric_radiology, hptp.is_pediatric_surgery, hptp.is_periodontics, hptp.is_phd_medical_genetics, hptp.is_plastic_and_reconstructive_surgery, hptp.is_prosthodontics, hptp.is_psychiatry, hptp.is_pulmonary_disease, hptp.is_radiation_oncology, hptp.is_radiological_physics, hptp.is_rheumatology, hptp.is_sleep_medicine, hptp.is_sports_medicine, hptp.is_surgery_of_the_hand, hptp.is_surgical_critical_care, hptp.is_surgical_oncology, hptp.is_therapeutic_radiology, hptp.is_transplant_hepatology, hptp.is_trauma_surgery, hptp.is_vascular_and_interventional_radiology, hptp.is_vascular_surgery 
  from
  (
    select nh1.npi as npi,nh1.Provider_Business_Practice_Location_Address_State_Name as state,
      nh1.Provider_Business_Practice_Location_Address_Postal_Code as zip, nh1.Provider_Business_Practice_Location_Address_City_Name as city,
      nh1.Is_Sole_Proprietor as sole_provider,nh1.Provider_Gender_Code as gender_code,
      replace(nh1.Provider_Credential_Text,'.','') as credential,
      case
        when nh1.Provider_Organization_Name_Legal_Business_Name is not null then nh1.Provider_Organization_Name_Legal_Business_Name
          else concat(rtrim(nh1.Provider_Last_Name_Legal_Name),', ',rtrim(nh1.Provider_First_Name),' ',
            if(nh1.provider_credential_text is null,'',replace(nh1.Provider_Credential_Text,'.','')))
      end as provider_name,pl1.sequence_id,
      pl1.Healthcare_Provider_Taxonomy_Code as taxonomy_code
     from npi.nppes_header nh1
      left outer join npi.provider_licenses pl1 on pl1.npi = nh1.NPI
      ) fp
     left outer join npi.healthcare_provider_taxonomies pt1 on pt1.taxonomy_code = fp.taxonomy_code
     left outer join npi.healthcare_provider_taxonomy_processed hptp on hptp.npi = fp.npi
     join npi.nppes_contact nc on nc.npi = fp.npi and nc.address_type = 'practice'
     join npi.address a on a.address_hash = nc.address_hash;


  create index idx_npi_summary on npi_summary_detailed (npi);
  
  create table npi_summary_detailed_primary_taxonomy as
    select * from
  npi_summary_detailed where sequence_id = 1
  order by state, zip5, npi
  ;

create unique index pk_nsdpt_npi on nppes.npi_summary_detailed_primary_taxonomy(npi);

CREATE VIEW npi_summary_abridged_primary_taxonomy
AS
   SELECT npi,
          state,
          zip,
          city,
          sole_provider,
          gender_code,
          credential,
          provider_name,
          taxonomy_code,
          taxonomy_name,
          classification,
          specialization,
          address_flattened,
          zip5,
          zip4,
          latitude,
          longitude,
          geocode_method,
          taxonomy_depth,
          flattened_taxonomy_string,
          is_dentist,
          is_emergency_medicine,
          is_internal_medicine,
          is_nurse_practitioner,
          is_physician_assistant,
          is_registered_nurse,
          is_pathology,
          is_hospital,
          is_behavioral_health_and_social_service_providers,
          is_laboratory,
          is_student,
          is_physician,
          is_diagnostic_radiology,
          is_ambulance,
          is_chiropractor,
          is_dermatology,
          is_family_medicine,
          is_general_acute_care_hospital,
          is_hospitalist,
          is_radiology,
          is_podiatrist,
          is_psychiatry,
          is_nuclear_radiology,
          is_hematology_and_oncology
     FROM nppes.npi_summary_detailed_primary_taxonomy nsdpt;