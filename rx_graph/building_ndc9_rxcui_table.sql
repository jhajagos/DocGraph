/* This query was down with the full RxNorm Monthly File from October  */

use rxnorm;


select * from rxnconso where SAB='RXNORM' and TTY='SBD';
/* 21639 */

select * from rxnconso where SAB='RXNORM' and TTY='SBD' and SUPPRESS = 'N';

select * from rxnconso where SAB='RXNORM' and TTY='SBD' and SUPPRESS = 'O';

/* Create some indices */

create unique index idx_rxnconso_rxaui on rxnconso(rxaui);
create index idx_rxnconso_rxcui on rxnconso(rxcui);
create  index idx_rxnconso_sab on rxnconso(sab);
create  index idx_rxnsat_rxcui on rxnsat(rxcui);
create  index idx_rxnsat_rxaui on rxnsat(rxaui);
create  index idx_rxnsat_atn on rxnsat(atn);

  
select r1.rxcui, r1.str, r1.code, r1.sab,  rn1.atv from rxnconso r1 
  join rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC'
  where char_length(rn1.atv) = 11
  order by r1.rxcui;
  
  
select distinct r1.rxcui,  rn1.atv as ndc, left(rn1.atv,9) as ndc9 from rxnconso r1 
  join rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC'
    where char_length(rn1.atv) = 11
    order by r1.rxcui;
    

select distinct r1.rxcui,  rn1.atv as ndc, left(rn1.atv,9) as ndc9, r1.str as label 
  from rxnconso r1 
  join rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC' and r1.SAB = 'RXNORM'
    where char_length(rn1.atv) = 11
    order by r1.rxcui;
    

select distinct r1.rxcui,  rn1.atv as ndc, left(rn1.atv,9) as ndc9, r1.str as label 
  from rxnconso r1 
  join rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC'
    where char_length(rn1.atv) = 11 and r1.SAB = 'RXNORM'
    order by r1.rxcui;    

select count(distinct rxcui) as counter, ndc from (
select distinct r1.rxcui,  rn1.atv as ndc, left(rn1.atv,9) as ndc9 from rxnconso r1 
  join rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC'
    where char_length(rn1.atv) = 11 and r1.SAB = 'RXNORM') t group by ndc
    order by count(distinct rxcui) desc;
    
    
select GROUP_CONCAT(distinct rxcui order by rxcui asc separator '|') as synthectic_rxcui, 
count(distinct rxcui) as counter, ndc9, 
GROUP_CONCAT(distinct label order by label asc separator '|') as synthetic_label from (
select distinct r1.rxcui,  rn1.atv as ndc, left(rn1.atv,9) as ndc9, r1.str as label  
  from rxnconso r1 
  join rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC'
    where char_length(rn1.atv) = 11 and r1.SAB = 'RXNORM') t group by ndc9
    order by count(distinct rxcui) desc;
    
    
create table rx_graph.ndc9_rxnorm as 
  select GROUP_CONCAT(distinct rxcui order by rxcui asc separator '|') as synthectic_rxcui, 
    count(distinct rxcui) as counter, ndc9, 
    GROUP_CONCAT(distinct label order by label asc separator '|') as synthetic_label from (
    select distinct r1.rxcui,  rn1.atv as ndc, left(rn1.atv,9) as ndc9, r1.str as label  
      from rxnconso r1 
      join rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC'
        where char_length(rn1.atv) = 11 and r1.SAB = 'RXNORM') t group by ndc9
        order by count(distinct rxcui) desc;
        

create unique index idx_rx_graph_ndc9 on rx_graph.ndc9_rxnorm(ndc9);

select count(*) from rx_graph.rx_graph_ndc9_rxcui;
/* 27,772,953 */

select count(*) from rx_graph.rx_graph_ndc9_rxcui nn9 join rx_graph.ndc9_rxnorm nr on nr.ndc9 = nn9.ndc9;
/* 27,559,381 */

select count(*) from rx_graph.rx_graph_ndc9_rxcui nn9 join rx_graph.ndc9_rxnorm nr on nr.ndc9 = nn9.ndc9
  where nr.counter = 1
;
/* 26843180 */

select count(distinct ndc9) from rx_graph.rx_graph_ndc9_rxcui;
/* 14997 */

select count(distinct nr.synthectic_rxcui) from rx_graph.rx_graph_ndc9_rxcui nn9 
  join rx_graph.ndc9_rxnorm nr on nr.ndc9 = nn9.ndc9;
/* 5633*/

select cast(synthetic_rxcui_text as char(255)) as synthetic_rxcui, 
  cast(left(synthetic_label_text, 1023) as char(1023)) as synthetic_label, 
  t.* from (
  select GROUP_CONCAT(distinct rxcui order by rxcui asc separator '|') as synthetic_rxcui_text, 
      count(distinct rxcui) as compact_counter, ndc9, 
      GROUP_CONCAT(distinct label order by label asc separator '|') as synthetic_label_text from (
      select distinct r1.rxcui,  rn1.atv as ndc, left(rn1.atv,9) as ndc9, r1.str as label  
        from rxnconso r1 
        join rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC'
          where char_length(rn1.atv) = 11 and r1.SAB = 'RXNORM' and r1.SUPPRESS = 'N' and r1.TTY = 'SBD') t group by ndc9) t
          order by compact_counter desc;
          
          
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

select r1.*, null, null, null, r3.rxaui as in_rxaui, r3.rxcui as in_rxcui, r3.str as ingredient 
    from rxnorm_prescribe.rxnorm_sbd_ingredient_count r1
    join rxnorm.rxnrel rr1 on r1.sbd_rxcui = rr1.rxcui1 and rr1.RELA = 'constitutes' and r1.number_of_ingredients > 1
    join rxnorm.rxnconso r2 on r2.rxcui = rr1.rxcui2 and r2.TTY = 'SCDC' and r2.SAB = 'RXNORM'
    join rxnorm.rxnrel rr2 on r2.rxcui = rr2.rxcui1 and rr2.RELA = 'ingredient_of'
    join rxnorm.rxnconso r3 on r3.rxcui = rr2.rxcui2 and r3.TTY = 'MIN' and r3.SAB = 'RXNORM'