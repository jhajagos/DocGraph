/* Build the branded drug tables */

drop table if exists rxnorm_prescribe.rxnorm_sbd1;

create table rxnorm_prescribe.rxnorm_sbd1 as
  select * from (
    select r.RXCUI as SBD_RXCUI, r.RXAUI as SBD_RXAUI, r.STR as semantic_branded_name, rn1.atv as rxn_available_string, 
    rn2.atv as rxterm_form, rn3.atv as rxn_human_drug,
    r.SAB, r.TTY, 
    r.SUPPRESS 
    /* ,rs.SVER, rs.SCIT */ 
    from rxnorm.RxnConso r
      left outer join rxnorm.rxnsat rn1 on rn1.RXAUI = r.RXAUI and rn1.ATN = 'RXN_AVAILABLE_STRENGTH'
      left outer join rxnorm.rxnsat rn2 on rn2.RXAUI = r.RXAUI and rn2.ATN = 'RXTERM_FORM'
      left outer join rxnorm.rxnsat rn3 on rn3.RXAUI = r.RXAUI and rn3.ATN = 'RXN_HUMAN_DRUG'
      /*join rxnorm.rxnsab rs on rs.RSAB = r.SAB*/
      where r.TTY in ('SBD') and r.SAB='RXNORM' and r.SUPPRESS = 'N') t where rxn_human_drug is not NULL;
  
create index rxn_sbdrxcui on rxnorm_prescribe.rxnorm_sbd1(SBD_RXCUI);  

drop table if exists rxnorm_prescribe.rxnorm_sbd2;

create table rxnorm_prescribe.rxnorm_sbd2 as
  select distinct r1.*, r2.rxaui as bn_rxaui, r2.rxcui as bn_rxcui, r2.str as brand_name
    from rxnorm_prescribe.rxnorm_sbd1 r1
       join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'ingredient_of'
       join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'BN' and r2.SAB = 'RXNORM'
         order by r1.sbd_rxaui, rr1.RELA;
         
drop table if exists rxnorm_prescribe.rxnorm_sbd3;        
create table rxnorm_prescribe.rxnorm_sbd3 as
  select distinct r1.*, r2.rxaui as dose_form_rxaui, r2.rxcui as dose_form_rxcui, r2.str as dose_form
    from rxnorm_prescribe.rxnorm_sbd2 r1
       join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'dose_form_of'
       join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'DF' and r2.SAB = 'RXNORM'
         order by r1.sbd_rxaui, rr1.RELA;

drop table if exists rxnorm_prescribe.rxnorm_sbd4;         
create table rxnorm_prescribe.rxnorm_sbd4 as
  select distinct r1.*, r2.rxaui as scd_rxaui, r2.rxcui as scd_rxcui, r2.str as semantic_clinical_drug
    from rxnorm_prescribe.rxnorm_sbd3 r1
       join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'has_tradename'
       join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCD' and r2.SAB = 'RXNORM'
         order by r1.sbd_rxaui, rr1.RELA;
         
/* Build the semantic clinical drug table */
drop table if exists rxnorm_prescribe.rxnorm_scd1;

create table rxnorm_prescribe.rxnorm_scd1 as
  select * from (
    select r.RXCUI as SCD_RXCUI, r.RXAUI as SCD_RXAUI, r.STR as semantic_clinical_drug, rn1.atv as rxn_available_string, 
    rn2.atv as rxterm_form, rn3.atv as rxn_human_drug,
    r.SAB, r.TTY, 
    r.SUPPRESS 
    /* ,rs.SVER, rs.SCIT */ 
    from rxnorm.RxnConso r
      left outer join rxnorm.rxnsat rn1 on rn1.RXAUI = r.RXAUI and rn1.ATN = 'RXN_AVAILABLE_STRENGTH'
      left outer join rxnorm.rxnsat rn2 on rn2.RXAUI = r.RXAUI and rn2.ATN = 'RXTERM_FORM'
      left outer join rxnorm.rxnsat rn3 on rn3.RXAUI = r.RXAUI and rn3.ATN = 'RXN_HUMAN_DRUG'
      /*join rxnorm.rxnsab rs on rs.RSAB = r.SAB*/
      where r.TTY in ('SCD') and r.SAB='RXNORM' and r.SUPPRESS = 'N') t where rxn_human_drug is not null;
      
drop table if exists rxnorm_prescribe.rxnorm_scd2;        
create table rxnorm_prescribe.rxnorm_scd2 as
  select distinct r1.*, r2.rxaui as dose_form_rxaui, r2.rxcui as dose_form_rxcui, r2.str as dose_form
    from rxnorm_prescribe.rxnorm_scd1 r1
       join rxnorm.rxnrel rr1 on r1.scd_rxcui = rr1.rxcui1 and rr1.RELA = 'dose_form_of'
       join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'DF' and r2.SAB = 'RXNORM'
         order by r1.scd_rxaui, rr1.RELA;      
         

drop table if exists rxnorm_prescribe.rxnorm_scd3;        
create table rxnorm_prescribe.rxnorm_scd3 as
  select * from rxnorm_prescribe.rxnorm_scd2; /*where SCD_RXCUI not in (select distinct SCD_RXCUI from rxnorm_prescribe.rxnorm_sbd4);*/


create index idx_rs3_scd_rxcui on rxnorm_prescribe.rxnorm_scd(SCD_RXAUI);
/* Build ingredient count tables */         

drop table if exists rxnorm_prescribe.rxnorm_scd_ingredient_count;         
create table rxnorm_prescribe.rxnorm_scd_ingredient_count as         
  select SCD_RXCUI, SCD_RXAUI, count(*) as number_of_ingredients from rxnorm_prescribe.rxnorm_scd1 r1  
    join rxnorm.rxnrel rr1 on r1.scd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes'
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM'
    group by SCD_RXCUI, SCD_RXAUI;

drop table if exists rxnorm_prescribe.rxnorm_scd_1_ingredient_1;
create table rxnorm_prescribe.rxnorm_scd_1_ingredient_1 as 
  select r1.*, r2.rxaui as scdc_rxaui, r2.rxcui as scdc_rxcui, r2.str as semantic_clinical_drug_component 
    from rxnorm_prescribe.rxnorm_scd_ingredient_count r1
    join rxnorm.rxnrel rr1 on r1.scd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes' and r1.number_of_ingredients = 1
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM';
        
drop table if exists rxnorm_prescribe.rxnorm_scd_1_ingredient_2;
create table rxnorm_prescribe.rxnorm_scd_1_ingredient_2 as 
  select r1.*, r2.rxaui as in_rxaui, r2.rxcui as in_rxcui, r2.str as ingredient
      from rxnorm_prescribe.rxnorm_scd_1_ingredient_1 r1
      join rxnorm.rxnrel rr1 on r1.scdc_rxcui = rr1.rxcui1 and rr1.RELA = 'ingredient_of' 
      join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'IN' and r2.SAB = 'RXNORM';

drop table if exists rxnorm_prescribe.rxnorm_sbd_ingredient_count;         
create table rxnorm_prescribe.rxnorm_sbd_ingredient_count as         
  select SBD_RXCUI, SBD_RXAUI, count(*) as number_of_ingredients from rxnorm_prescribe.rxnorm_sbd1 r1  
    join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes'
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM'
    group by SBD_RXCUI, SBD_RXAUI;    
    
drop table if exists rxnorm_prescribe.rxnorm_sbd_1_ingredient_1;
create table rxnorm_prescribe.rxnorm_sbd_1_ingredient_1 as 
  select r1.*, r2.rxaui as scdc_rxaui, r2.rxcui as scdc_rxcui, r2.str as semantic_clinical_drug_component 
    from rxnorm_prescribe.rxnorm_sbd_ingredient_count r1
    join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes' and r1.number_of_ingredients = 1
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM';
  
drop table if exists rxnorm_prescribe.rxnorm_sbd_1_ingredient_2;
create table rxnorm_prescribe.rxnorm_sbd_1_ingredient_2 as 
  select r1.*, r2.rxaui as in_rxaui, r2.rxcui as in_rxcui, r2.str as ingredient
      from rxnorm_prescribe.rxnorm_sbd_1_ingredient_1 r1
      join rxnorm.rxnrel rr1 on r1.scdc_rxcui = rr1.rxcui1 and rr1.RELA = 'ingredient_of' 
      join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'IN' and r2.SAB = 'RXNORM';
      
 /*
select * from rxnorm_prescribe.rxnorm_sbd_ingredient_count where number_of_ingredients > 1;*/
/* 3013 */

select r1.*, null, null, null, r3.rxaui as in_rxaui, r3.rxcui as in_rxcui, r3.str as ingredient, r3.TTY
  from rxnorm_prescribe.rxnorm_sbd_ingredient_count r1
    join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes' and r1.number_of_ingredients > 1
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM'
    join rxnorm.rxnrel rr2 on r2.rxcui = rr2.rxcui1 and rr2.RELA = 'ingredients_of'
    join rxnorm.rxnconso r3 on r3.rxcui = rr2.rxcui2 and r3.TTY = 'MIN' and r3.SAB = 'RXNORM'
    join rxnorm.rxnrel rr3 on r3.rxcui = rr3.RXCUI1
    join rxnorm.rxnconso r4 on r4.rxcui = rr3.rxcui2;
    

create index idx_rsb4_scd_rxaui on rxnorm_prescribe.rxnorm_sbd4(sbd_rxaui);    

drop table if exists rxnorm_prescribe.scd_multiple_ingredients1;
create table rxnorm_prescribe.scd_multiple_ingredients1 as
  select null as sbd_rxaui, null as sbd_rxcui, null as semantic_branded_drug, 
    r3.rxcui as scd_rxcui, r3.STR as semantic_clinical_drug, r3.rxaui as scd_rxaui,
    r1.rxcui as MIN_RXCUI, 
    r1.rxaui as MIN_RXAUI, r1.STR as ingredients
    from rxnorm.RxnConso r1 
      join rxnorm.RxnREL rr1 on r1.rxcui = rr1.RXCUI1 and rr1.rela = 'has_ingredients'
      join rxnorm.RxnConso r2 on r2.rxcui = rr1.RXCUI2 and r2.SAB = 'RXNORM'
      join rxnorm.rxnrel rr2 on r2.rxcui = rr2.RXCUI1
      join rxnorm.rxnconso r3 on r3.rxcui = rr2.rxcui2 and r3.SAB = 'RXNORM' and r3.TTY in ('SCD')
  where r1.TTY = 'MIN' and r1.SAB = 'RXNORM';

drop table if exists rxnorm_prescribe.scd_multiple_ingredients2;
create table rxnorm_prescribe.scd_multiple_ingredients2 as 
  select rsic.SCD_RXCUI, rsic.SCD_RXAUI, rsic.number_of_ingredients, null as scdc_rxaui, null as scdc_rxcui, 
  null as semantic_clinical_drug_component, mi.MIN_RXCUI, mi.min_RXAUI, mi.ingredients   
    from  
    rxnorm_prescribe.rxnorm_scd_ingredient_count rsic
    join rxnorm_prescribe.sbd_multiple_ingredients1 mi on rsic.scd_rxaui = mi.scd_rxaui;

drop table if exists rxnorm_prescribe.scd_generic_name1;
create table rxnorm_prescribe.scd_generic_name1 as 
  select * from rxnorm_prescribe.rxnorm_scd_1_ingredient_2 t1;
  
alter table rxnorm_prescribe.scd_generic_name1 modify scdc_rxaui varchar(8); 
alter table rxnorm_prescribe.scd_generic_name1 modify scdc_rxcui varchar(8); 
alter table rxnorm_prescribe.scd_generic_name1 modify semantic_clinical_drug_component varchar(3000); 
  
insert into  rxnorm_prescribe.scd_generic_name1 (SCD_RXCUI,
SCD_RXAUI,
number_of_ingredients,
scdc_rxaui,
scdc_rxcui,
semantic_clinical_drug_component,
in_rxaui,
in_rxcui,
ingredient)
  select * from rxnorm_prescribe.scd_multiple_ingredients2;

drop table if exists rxnorm_prescribe.scd_generic_name2;  
create table rxnorm_prescribe.scd_generic_name2 as   
  select gn.SCD_RXCUI, gn.SCD_RXAUI, gn.number_of_ingredients, gn.scdc_rxcui, gn.scdc_rxaui, 
   gn.semantic_clinical_drug_component, gn.in_rxcui as generic_name_rxcui, gn.in_rxaui as generic_name_rxaui, 
   gn.ingredient as generic_name
     from rxnorm_prescribe.scd_generic_name1 gn;

drop table if exists rxnorm_prescribe.sbd_multiple_ingredients1;
create table rxnorm_prescribe.sbd_multiple_ingredients1 as
  select distinct r3.rxaui as sbd_rxaui, r3.rxcui as sbd_rxcui, r3.STR as semantic_branded_drug, rsbd.SCD_RXAUI, 
    rsbd.semantic_clinical_drug, rsbd.SCD_RXAUI as SCD_RXCUI,  r1.rxcui as MIN_RXCUI, 
    r1.rxaui as MIN_RXAUI, r1.STR as ingredients  from rxnorm.RxnConso r1 
      join rxnorm.RxnREL rr1 on r1.rxcui = rr1.RXCUI1 and rr1.rela = 'has_ingredients'
      join rxnorm.RxnConso r2 on r2.rxcui = rr1.RXCUI2 and r2.SAB = 'RXNORM'
      join rxnorm.rxnrel rr2 on r2.rxcui = rr2.RXCUI1
      join rxnorm.rxnconso r3 on r3.rxcui = rr2.rxcui2 and r3.SAB = 'RXNORM' and r3.TTY in ('SBD')
      join rxnorm_prescribe.rxnorm_sbd4 rsbd on rsbd.sbd_rxaui = r3.rxaui
      where r1.TTY = 'MIN' and r1.SAB = 'RXNORM';
  
drop table if exists rxnorm_prescribe.sbd_multiple_ingredients2;
create table rxnorm_prescribe.sbd_multiple_ingredients2 as 
  select rsic.SBD_RXCUI, rsic.SBD_RXAUI, rsic.number_of_ingredients, null as scdc_rxaui, null as scdc_rxcui, 
  null as semantic_clinical_drug_component, mi.MIN_RXCUI, mi.min_RXAUI, mi.ingredients   
    from  
    rxnorm_prescribe.rxnorm_sbd_ingredient_count rsic
    join rxnorm_prescribe.sbd_multiple_ingredients1 mi on rsic.sbd_rxaui = mi.sbd_rxaui;

drop table if exists rxnorm_prescribe.sbd_generic_name1;
create table rxnorm_prescribe.sbd_generic_name1 as 
  select * from rxnorm_prescribe.rxnorm_sbd_1_ingredient_2 t1;
  
alter table rxnorm_prescribe.sbd_generic_name1 modify scdc_rxaui varchar(8); 
alter table rxnorm_prescribe.sbd_generic_name1 modify scdc_rxcui varchar(8); 
alter table rxnorm_prescribe.sbd_generic_name1 modify semantic_clinical_drug_component varchar(3000); 
  
insert into  rxnorm_prescribe.sbd_generic_name1 (SBD_RXCUI,
SBD_RXAUI,
number_of_ingredients,
scdc_rxaui,
scdc_rxcui,
semantic_clinical_drug_component,
in_rxaui,
in_rxcui,
ingredient)
  select * from rxnorm_prescribe.sbd_multiple_ingredients2;

drop table if exists rxnorm_prescribe.sbd_generic_name2;  
create table rxnorm_prescribe.sbd_generic_name2 as   
  select gn.SBD_RXCUI, gn.SBD_RXAUI, gn.number_of_ingredients, gn.scdc_rxcui, gn.scdc_rxaui, 
   gn.semantic_clinical_drug_component, gn.in_rxcui as generic_name_rxcui, gn.in_rxaui as generic_name_rxaui, 
   gn.ingredient as generic_name
     from rxnorm_prescribe.sbd_generic_name1 gn;

drop table if exists rxnorm_prescribe.dose_form_to_dose_form_group;

create table rxnorm_prescribe.dose_form_to_dose_form_group as
  select t.df_rxaui as dose_form_rxaui, t.dose_form, count(*) as counter, 
    group_concat(distinct dfg_rxcui order by dfg_rxcui asc separator '|') as synthetic_dfg_rxcui,
    group_concat(distinct dfg_rxaui order by dfg_rxaui asc separator '|') as synthetic_dfg_rxaui,
    group_concat(distinct dose_form_group order by dfg_rxaui asc separator '|') as synthetic_dose_form_group
    from (select distinct r2.rxcui as dose_rxcui, r2.rxaui as df_rxaui, r2.str as dose_form, 
      r1.rxcui as dfg_rxcui, r1.rxaui as dfg_rxaui, r1.str as dose_form_group  
    from rxnorm.rxnconso r1 join rxnorm.rxnrel rr1 on r1.rxcui = rr1.RXCUI1
      join rxnorm.rxnconso r2 on r2.rxcui = rr1.RXCUI2 where r1.SAB = 'RXNORM' and r2.SAB = 'RXNORM'
      and r1.TTY = 'DFG' and r2.TTY='DF') t group by t.df_rxaui, t.dose_form
      order by synthetic_dose_form_group, dose_form;


/* Build the main sbd drug details table */
drop table if exists rxnorm_prescribe.sbd_drug_details;
create table rxnorm_prescribe.sbd_drug_details as      
 select rs4.SBD_RXCUI as sbd_rxcui, rs4.SBD_RXAUI as sbd_rxaui, rs4.semantic_branded_name,
    rs4.rxn_available_string, 
    rs4.rxterm_form, rs4.rxn_human_drug, rs4.SAB, rs4.TTY, rs4.SUPPRESS, 
    rs4.bn_rxaui, rs4.bn_rxcui, rs4.brand_name, rs4.dose_form_rxaui, rs4.dose_form_rxcui, 
    rs4.dose_form, rs4.scd_rxaui, rs4.scd_rxcui, rs4.semantic_clinical_drug,
    gn2.number_of_ingredients, gn2.scdc_rxcui, gn2.scdc_rxaui, 
    gn2.semantic_clinical_drug_component, gn2.generic_name_rxcui, gn2.generic_name_rxaui, gn2.generic_name,
    dfdfg.counter as dose_form_group_counter, dfdfg.synthetic_dfg_rxcui, dfdfg.synthetic_dfg_rxaui, dfdfg.synthetic_dose_form_group
  from rxnorm_prescribe.rxnorm_sbd4 rs4 
  join rxnorm_prescribe.sbd_generic_name2 gn2 on rs4.SBD_RXAUI = gn2.SBD_RXAUI
  left outer join rxnorm_prescribe.dose_form_to_dose_form_group dfdfg on dfdfg.dose_form_rxaui = rs4.dose_form_rxaui
  ;

/* Build the main scd drug details table */

drop table if exists rxnorm_prescribe.scd_drug_details;
create table rxnorm_prescribe.scd_drug_details as      
 select null sbd_rxcui, null as sbd_rxaui, null as semantic_branded_name,
    rs3.rxn_available_string, 
    rs3.rxterm_form, rs3.rxn_human_drug, rs3.SAB, rs3.TTY, rs3.SUPPRESS, 
    null as bn_rxaui, null as bn_rxcui, null as brand_name, rs3.dose_form_rxaui, rs3.dose_form_rxcui, 
    rs3.dose_form, rs3.scd_rxaui, rs3.scd_rxcui, rs3.semantic_clinical_drug,
    gn2.number_of_ingredients, gn2.scdc_rxcui, gn2.scdc_rxaui, 
    gn2.semantic_clinical_drug_component, gn2.generic_name_rxcui, gn2.generic_name_rxaui, gn2.generic_name,
    dfdfg.counter as dose_form_group_counter, dfdfg.synthetic_dfg_rxcui, dfdfg.synthetic_dfg_rxaui, dfdfg.synthetic_dose_form_group
  from rxnorm_prescribe.rxnorm_scd3 rs3 
  join rxnorm_prescribe.scd_generic_name2 gn2 on rs3.SCD_RXAUI = gn2.SCD_RXAUI
  left outer join rxnorm_prescribe.dose_form_to_dose_form_group dfdfg on dfdfg.dose_form_rxaui = rs3.dose_form_rxaui;
 
drop table if exists rxnorm_prescribe.drug_details;
create table rxnorm_prescribe.drug_details
  select * from rxnorm_prescribe.sbd_drug_details;

alter table rxnorm_prescribe.drug_details modify sbd_rxaui varchar(8);
alter table rxnorm_prescribe.drug_details modify sbd_rxcui varchar(8);
alter table rxnorm_prescribe.drug_details modify bn_rxcui varchar(8);
alter table rxnorm_prescribe.drug_details modify bn_rxaui varchar(8);
alter table rxnorm_prescribe.drug_details modify brand_name	varchar(3000);
alter table rxnorm_prescribe.drug_details modify semantic_branded_name	varchar(3000);

insert into rxnorm_prescribe.drug_details 
  select * from rxnorm_prescribe.scd_drug_details;


  
  
create index dd_sdbd_rxcui on rxnorm_prescribe.drug_details(sbd_rxcui);
create index dd_sbbd_rxaui on rxnorm_prescribe.drug_details(sbd_rxaui);
create index dd_scbd_rxcui on rxnorm_prescribe.drug_details(scd_rxcui);
create index dd_scbd_rxaui on rxnorm_prescribe.drug_details(scd_rxaui);


drop table if exists rxnorm_prescribe.ndc_drug_details;

create table rxnorm_prescribe.ndc_drug_details as
  select distinct left(rs.ATV,11) as ndc, dd.*, now() as created_at 
    from rxnorm_prescribe.drug_details dd join rxnorm.rxnsat rs on rs.rxaui = dd.sbd_rxaui
      and rs.ATN = 'NDC' and dd.TTY = 'SBD';
      
alter table rxnorm_prescribe.ndc_drug_details modify sbd_rxaui varchar(8);
alter table rxnorm_prescribe.ndc_drug_details modify sbd_rxcui varchar(8);
alter table rxnorm_prescribe.ndc_drug_details modify bn_rxcui varchar(8);
alter table rxnorm_prescribe.ndc_drug_details modify bn_rxaui varchar(8);
alter table rxnorm_prescribe.ndc_drug_details modify brand_name	varchar(3000);
alter table rxnorm_prescribe.ndc_drug_details modify semantic_branded_name	varchar(3000);
  
insert into rxnorm_prescribe.ndc_drug_details
  select distinct left(rs.ATV,11) as ndc, dd.*, now() as created_at 
    from rxnorm_prescribe.drug_details dd join rxnorm.rxnsat rs on rs.rxaui = dd.scd_rxaui
      and rs.ATN = 'NDC' and dd.TTY = 'SCD';
      
create unique index idx_ndd_ndc on rxnorm_prescribe.ndc_drug_details(ndc);
      
      
create unique index idx_uniq_ndc_dd on rxnorm_prescribe.ndc_drug_details(ndc);
 
/*select * from rxnorm_prescribe.ndc_drug_details; */
/* 39369 */
/* Build Ingredient Tables Linking to Component Tables */

drop table if exists rxnorm_prescribe.ingredient1;

create table rxnorm_prescribe.ingredient1 as
  select r1.rxaui as in_rxaui, r1.rxcui as in_rxcui, TTY, r1.str as ingredient, 
    rs1.atv as rxn_activated, rs2.ATV as rxn_obsoleted, rs3.ATV as unii_code
    from rxnorm.rxnconso r1 
    left outer join rxnorm.rxnsat rs1 on rs1.rxaui = r1.rxaui and rs1.ATN = 'RXN_ACTIVATED'
    left outer join rxnorm.rxnsat rs2 on rs2.rxaui = r1.rxaui and rs2.ATN ='RXN_OBSOLETED'
    left outer join rxnorm.rxnsat rs3 on rs3.rxaui = r1.rxaui and rs3.ATN ='UNII_CODE'
    where r1.SAB = 'RXNORM' and r1.TTY in ('IN');
    

drop table if exists  rxnorm_prescribe.ingredient2;
 
create table rxnorm_prescribe.ingredient2 as
  select i1.*, related_form, pin_rxaui, pin_rxcui from rxnorm_prescribe.ingredient1 i1 left outer join 
    (select r1.rxcui as in_rxcui, r1.rxaui as in_rxaui, rr1.rela, r2.str as related_form, 
      r2.tty, r2.rxcui as pin_rxcui, r2.rxcui as pin_rxaui from rxnorm.rxnconso r1 
      join rxnorm.rxnrel rr1 on rr1.rxcui1 = r1.rxcui
      join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.SAB = 'RXNORM' and rr1.RELA = 'form_of'
      where r1.SAB='RXNORM' and r1.tty in ('IN')) t on t.in_rxaui = i1.in_rxaui;

drop table if exists rxnorm_prescribe.relation_between_ingredient_component1;
      
create table rxnorm_prescribe.relation_between_ingredient_component1
 select r1.str as ingredient, r1.rxcui as in_rxcui, r1.rxaui as in_rxaui, rr1.rela, 
  r2.str as semantic_clinical_drug_component, r2.tty, r2.rxaui as scdc_rxaui, r2.rxcui as scdc_rxcui 
  from rxnorm.rxnconso r1 
    join rxnorm.rxnrel rr1 on r1.rxcui = rr1.rxcui1
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.SAB = 'RXNORM' and r2.tty = 'SCDC'
    where r1.SAB = 'RXNORM' and r1.TTY = 'IN';


drop table if exists rxnorm_prescribe.relation_between_ingredient_clinical_drug1;
      
create table rxnorm_prescribe.relation_between_ingredient_clinical_drug1 as     
 select distinct ric.*, rr1.rela as rela1, r2.RXCUI as scd_rxcui, r2.RXAUI as scd_rxaui, r2.STR as semantic_clinical_drug 
  from rxnorm_prescribe.relation_between_ingredient_component1 ric 
  join rxnorm.rxnrel rr1 on ric.scdc_rxcui = rr1.RXCUI1
  join rxnorm.rxnconso r2 on r2.rxcui = rr1.RXCUI2 and r2.TTY = 'SCD';