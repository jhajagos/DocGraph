select * from rxnorm.rxnconso where rxaui = 1930240;

select * from rxnorm.rxnsat rs where atv like '000540018%';

select * from rxnorm_prescribe.ndc_drug_details where ndc like '000540018%';

select count(*) from rx_graph.rx_graph_ndc9;

select rrn.*, nddwa.synthetic_rxcui, nddwa.synthetic_label, nddwa.compact_counter, nddwa.synthetic_rxcui_key, 
    nddwa.sbd_rxcui, nddwa.sbd_rxaui, nddwa.semantic_branded_name, nddwa.rxn_available_string, nddwa.rxterm_form, 
    nddwa.rxn_human_drug, nddwa.SAB, nddwa.TTY, nddwa.SUPPRESS, nddwa.bn_rxaui, nddwa.bn_rxcui, nddwa.brand_name, 
    nddwa.dose_form_rxaui, nddwa.dose_form_rxcui, nddwa.dose_form, nddwa.scd_rxaui, nddwa.scd_rxcui, nddwa.semantic_clinical_drug, 
    nddwa.number_of_ingredients, nddwa.scdc_rxcui, nddwa.scdc_rxaui, nddwa.semantic_clinical_drug_component, nddwa.generic_name_rxcui, 
    nddwa.generic_name_rxaui, nddwa.generic_name, nddwa.dose_form_group_counter, nddwa.synthetic_dfg_rxcui, nddwa.synthetic_dfg_rxaui, 
    nddwa.synthetic_dose_form_group, nddwa.counter, nddwa.synthetic_atc5, nddwa.synthetic_atc5_name,
    nspt.*
  from rx_graph.rx_graph_ndc9 rrn 
    join rxnorm_prescribe.ndc9_drug_details_with_atc nddwa on (rrn.ndc9 = nddwa.ndc9)
    join referral.npi_summary_primary_taxonomy nspt on nspt.npi = rrn.npi
     where nspt.state = 'WY';
    