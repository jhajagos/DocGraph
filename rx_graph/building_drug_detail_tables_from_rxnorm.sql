
         
select r1.RXCUI, r1.RXAUI, r1.STR, r1.Code, rn1.ATN, rn1.ATV  from rxnorm.rxnconso r1 
   join rxnorm.rxnsat rn1 on r1.rxaui = rn1.rxaui
     where r1.SAB='RXNORM' and r1.TTY='SBD' and r1.SUPPRESS = 'N'
     order by r1.rxaui, rn1.ATN, rn1.ATV
    ;
/*
RXCUI	RXAUI	STR	ATN	ATV
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	NDC	00009377805
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	RXN_AVAILABLE_STRENGTH	0.01 MG/ML
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	RXN_HUMAN_DRUG	US
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	RXTERM_FORM	Sol
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	UMLSAUI	A10449292
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	UMLSCUI	C0592377
*/

select r1.RXCUI, r1.RXAUI, r1.STR, r1.CODE, r1.TTY, rr1.rela, 
  r2.RXCUI, r2.RXAUI, r2.STR, r2.CODE, r2.TTY from rxnorm.rxnconso r1 
   join rxnorm.rxnrel rr1 on r1.rxcui = rr1.rxcui1
   join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2
     where r1.SAB='RXNORM' and r1.TTY='SBD' and r1.SUPPRESS = 'N' and r2.SAB = 'RXNORM'
     order by r1.rxaui, rr1.RELA
    ;
    
    
 /* 
 
 RXCUI	RXAUI	STR	CODE	TTY	rela	RXCUI1	RXAUI1	STR1	CODE1	TTY1
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	152571	SBD	constitutes	329016	1505760	Alprostadil 0.01 MG/ML	329016	SCDC
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	152571	SBD	constitutes	564985	2280366	Alprostadil 0.01 MG/ML [Caverject]	564985	SBDC
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	152571	SBD	dose_form_of	316949	1479803	Injectable Solution	316949	DF
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	152571	SBD	has_tradename	242690	1252463	Alprostadil 0.01 MG/ML Injectable Solution	242690	SCD
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	152571	SBD	has_tradename	242690	3293373	alprostadil 10 MCG/ML Injectable Solution	242690	SY
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	152571	SBD	ingredient_of	477639	1001687	Caverject	477639	BN
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	152571	SBD	inverse_isa	362552	2053418	Alprostadil Injectable Solution [Caverject]	362552	SBDF
152571	1002288	Alprostadil 0.01 MG/ML Injectable Solution [Caverject]	152571	SBD	inverse_isa	1176398	3831882	Caverject Injectable Product	1176398	SBDG

*/
drop table rxnorm_prescribe.rxnorm_sbd1;

create table rxnorm_prescribe.rxnorm_sbd1 as
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
    where r.TTY = 'SBD' and r.SAB='RXNORM' and r.SUPPRESS = 'N';
  
create index rxn_sbdrxcui on rxnorm_prescribe.rxnorm_sbd1(SBD_RXCUI);  

drop table rxnorm_prescribe.rxnorm_sbd2;

create table rxnorm_prescribe.rxnorm_sbd2 as
  select distinct r1.*, r2.rxaui as bn_rxaui, r2.rxcui as bn_rxcui, r2.str as brand_name
    from rxnorm_prescribe.rxnorm_sbd1 r1
       join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'ingredient_of'
       join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'BN' and r2.SAB = 'RXNORM'
         order by r1.sbd_rxaui, rr1.RELA;
         
drop table rxnorm_prescribe.rxnorm_sbd3;        
create table rxnorm_prescribe.rxnorm_sbd3 as
  select distinct r1.*, r2.rxaui as dose_form_rxaui, r2.rxcui as dose_form_rxcui, r2.str as dose_form
    from rxnorm_prescribe.rxnorm_sbd2 r1
       join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'dose_form_of'
       join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'DF' and r2.SAB = 'RXNORM'
         order by r1.sbd_rxaui, rr1.RELA;

drop table rxnorm_prescribe.rxnorm_sbd4;         
create table rxnorm_prescribe.rxnorm_sbd4 as
  select distinct r1.*, r2.rxaui as scd_rxaui, r2.rxcui as scd_rxcui, r2.str as semantic_clinical_drug
    from rxnorm_prescribe.rxnorm_sbd3 r1
       join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'has_tradename'
       join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCD' and r2.SAB = 'RXNORM'
         order by r1.sbd_rxaui, rr1.RELA;
         
create table rxnorm_prescribe.rxnorm_sbd_ingredient_count as         
  select SBD_RXCUI, SBD_RXAUI, count(*) as number_of_ingredients from rxnorm_prescribe.rxnorm_sbd1 r1  
    join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes'
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM'
    group by SBD_RXCUI, SBD_RXAUI;

select * from rxnorm_prescribe.rxnorm_sbd_ingredient_count where ingredient_count=1;

create table rxnorm_prescribe.rxnorm_sbd_1_ingredient_1 as 
  select r1.*, r2.rxaui as scdc_rxaui, r2.rxcui as scdc_rxcui, r2.str as semantic_clinical_drug_component 
    from rxnorm_prescribe.rxnorm_sbd_ingredient_count r1
    join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes' and r1.number_of_ingredients = 1
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM';
  
/* 7500 */

create table rxnorm_prescribe.rxnorm_sbd_1_ingredient_2 as 
  select r1.*, r2.rxaui as in_rxaui, r2.rxcui as in_rxcui, r2.str as ingredient
      from rxnorm_prescribe.rxnorm_sbd_1_ingredient_1 r1
      join rxnorm.rxnrel rr1 on r1.scdc_rxcui = rr1.rxcui1 and rr1.RELA = 'ingredient_of' 
      join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'IN' and r2.SAB = 'RXNORM';
      
 
select * from rxnorm_prescribe.rxnorm_sbd_ingredient_count where number_of_ingredients > 1;
/* 3013 */

select distinct rela from rxnorm.rxnrel;;

select r1.*, null, null, null, r3.rxaui as in_rxaui, r3.rxcui as in_rxcui, r3.str as ingredient, r3.TTY
    from rxnorm_prescribe.rxnorm_sbd_ingredient_count r1
    join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes' and r1.number_of_ingredients > 1
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM'
    join rxnorm.rxnrel rr2 on r2.rxcui = rr2.rxcui1 and rr2.RELA = 'ingredients_of'
    join rxnorm.rxnconso r3 on r3.rxcui = rr2.rxcui2 and r3.TTY = 'MIN' and r3.SAB = 'RXNORM'
    join rxnorm.rxnrel rr3 on r3.rxcui = rr3.RXCUI1
    join rxnorm.rxnconso r4 on r4.rxcui = rr3.rxcui2
    

create index idx_rsb4_scd_rxaui on rxnorm_prescribe.rxnorm_sbd4(sbd_rxaui);    

drop table rxnorm_prescribe.multiple_ingredients1;

create table rxnorm_prescribe.multiple_ingredients1 as
select distinct r3.rxaui as sbd_rxaui, r3.rxcui as sbd_rxcui, r3.STR as semantic_branded_drug, rsbd.SCD_RXAUI, 
  rsbd.semantic_clinical_drug, rsbd.SCD_RXAUI as SCD_RXCUI,  r1.rxcui as MIN_RXCUI, 
  r1.rxaui as MIN_RXAUI, r1.STR as ingredients  from rxnorm.RxnConso r1 
    join rxnorm.RxnREL rr1 on r1.rxcui = rr1.RXCUI1 and rr1.rela = 'has_ingredients'
    join rxnorm.RxnConso r2 on r2.rxcui = rr1.RXCUI2 and r2.SAB = 'RXNORM'
    join rxnorm.rxnrel rr2 on r2.rxcui = rr2.RXCUI1
    join rxnorm.rxnconso r3 on r3.rxcui = rr2.rxcui2 and r3.SAB = 'RXNORM' and r3.TTY = 'SBD'
    join rxnorm_prescribe.rxnorm_sbd4 rsbd on rsbd.sbd_rxaui = r3.rxaui
    where r1.TTY = 'MIN' and r1.SAB = 'RXNORM';
  
/*
SBD_RXCUI
SBD_RXAUI
number_of_ingredients
scdc_rxaui
scdc_rxcui
semantic_clinical_drug_component
in_rxaui
in_rxcui
ingredient
*/

create table rxnorm_prescribe.multiple_ingredients2 as 
  select rsic.SBD_RXCUI, rsic.SBD_RXAUI, rsic.number_of_ingredients, null as scdc_rxaui, null as scdc_rxcui, 
  null as semantic_clinical_drug_component, mi.MIN_RXCUI, mi.min_RXAUI, mi.ingredients   
    from  
    rxnorm_prescribe.rxnorm_sbd_ingredient_count rsic
    join rxnorm_prescribe.multiple_ingredients1 mi on rsic.sbd_rxaui = mi.sbd_rxaui;


drop table rxnorm_prescribe.generic_name1;

create table rxnorm_prescribe.generic_name1 as 
  select * from rxnorm_prescribe.rxnorm_sbd_1_ingredient_2 t1;
  
alter table rxnorm_prescribe.generic_name1 modify scdc_rxaui varchar(8); 
alter table rxnorm_prescribe.generic_name1 modify scdc_rxcui varchar(8); 
alter table rxnorm_prescribe.generic_name1 modify semantic_clinical_drug_component varchar(3000); 
  
insert into  rxnorm_prescribe.generic_name1 (SBD_RXCUI,
SBD_RXAUI,
number_of_ingredients,
scdc_rxaui,
scdc_rxcui,
semantic_clinical_drug_component,
in_rxaui,
in_rxcui,
ingredient)
  select * from rxnorm_prescribe.multiple_ingredients2;
  
create table rxnorm_prescribe.generic_name2 as   
  select gn.SBD_RXCUI, gn.SBD_RXAUI, gn.number_of_ingredients, gn.scdc_rxcui, gn.scdc_rxaui, 
   gn.semantic_clinical_drug_component, gn.in_rxcui as generic_name_rxcui, gn.in_rxaui as generic_name_rxaui, 
   gn.ingredient as generic_name
     from rxnorm_prescribe.generic_name1 gn;

create table rxnorm_prescribe.drug_details as      
  select rs4.SBD_RXCUI as sbd_rxcui, rs4.SBD_RXAUI as sbd_rxaui, rs4.semantic_branded_name,
    rs4.rxn_available_string, 
    rs4.rxterm_form, rs4.rxn_human_drug, rs4.SAB, rs4.TTY, rs4.SUPPRESS, 
    rs4.bn_rxaui, rs4.bn_rxcui, rs4.brand_name, rs4.dose_form_rxaui, rs4.dose_form_rxcui, 
    rs4.dose_form, rs4.scd_rxaui, rs4.scd_rxcui, rs4.semantic_clinical_drug,
    gn2.number_of_ingredients, gn2.scdc_rxcui, gn2.scdc_rxaui, 
    gn2.semantic_clinical_drug_component, gn2.generic_name_rxcui, gn2.generic_name_rxaui, gn2.generic_name
from rxnorm_prescribe.rxnorm_sbd4 rs4 join rxnorm_prescribe.generic_name2 gn2 on rs4.SBD_RXAUI = gn2.SBD_RXAUI;

drop table rxnorm_prescribe.ndc_drug_details;

create table rxnorm_prescribe.ndc_drug_details as    
  select distinct left(rs.ATV,11) as ndc, dd.*, now() as created_at 
  from rxnorm_prescribe.drug_details dd join rxnorm.rxnsat rs on rs.rxaui = dd.sbd_rxaui
    and rs.ATN = 'NDC';
    

create unique index idx_uniq_ndc_dd on rxnorm_prescribe.ndc_drug_details(ndc);
 
 
select * from rxnorm_prescribe.ndc_drug_details;