
use RxNorm;

select * from RxNorm.RxnConso where sab='ATC' and (TTY = 'RXN_PT' or TTY = 'RXN_IN') order by code;


select * from RxNorm.RxnConso where sab='ATC' and (TTY = 'PT') order by str;


/* 661 */

select * from RxNorm.RxnConso where sab='ATC' and (TTY = 'PT' or TTY = 'IN') order by code;

select * from RxNorm.RxnConso where sab='ATC' and (TTY = 'IN') order by code;
/* 4516 */

/* 557 */

select * from RxNorm.RxnConso r1 
join RxNorm.RxnConso r2 on 
r2.RXCUI = r1.RXCUI and (r2.sab in ('RXNORM'))
where r1.sab='ATC' and r1.TTY = 'IN' and r2.TTY = 'IN'
order by r1.code;

/* 2742 */


select * from RxNorm.RxnConso r1 
join RxNorm.RxnConso r2 on 
r2.RXCUI = r1.RXCUI and (r2.sab in ('RXNORM'))
where r1.sab='ATC' and r1.TTY = 'IN' and r2.TTY = 'IN'
order by r1.str;
/* 2742 */

select count(*), r1.str from RxNorm.RxnConso r1 
join RxNorm.RxnConso r2 on 
r2.RXCUI = r1.RXCUI and (r2.sab in ('RXNORM'))
where r1.sab='ATC' and r1.TTY = 'IN' and r2.TTY = 'IN'
group by r1.str having count(*) > 1 order by count(*) desc;

/* 312 */
create index idx_rxn_code on RxNorm.RxnConso(code);
create index idx_rel_rc1 on RxNorm.RxnRel(rxcui1);
create index idx_rel_rc2 on RxNorm.RxnRel(rxcui2);
create index idx_rel_ra1 on RxNorm.RxnRel(rxaui1);
create index idx_rel_ra2 on RxNorm.RxnRel(rxaui2);

create index idx_rel_rela on RxNorm.RxnRel(rela);

create index idx_rel_rela on RxNorm.RxnCONSO(rela);

select * from RxnREL where sab = 'ATC';

select distinct RELA from RxnREL where sab = 'RXNORM';

select distinct ATN from RxnSat where sab = 'RXNORM';

select distinct * from RxnSat where sab = 'RXNORM' and ATN like 'RXTERM_FORM';


select * from RxnSat where sab = 'ATC';
select * from RxnREL where sab = 'RXNORM' and rela = 'ingredient_of';


  select tt.rxcui, tt.STR, tt.CODE, r5.str, r5.rxcui from RxnREL  rr join (
    select distinct r3.rxcui, r3.str, r3.code from RxnConso r3 join 
      (select r1.str from RxNorm.RxnConso r1 
        join RxNorm.RxnConso r2 on 
        r2.RXCUI = r1.RXCUI and (r2.sab in ('RXNORM'))
        where r1.sab='ATC' and r1.TTY = 'IN' and r2.TTY = 'IN'
        group by r1.str having count(*) > 1) t on t.str = r3.str 
      and r3.TTY = 'IN' and r3.SAB = 'ATC') tt 
    on rr.SAB = 'RXNORM' and rr.RELA = 'ingredient_of' 
    and rr.RXCUI2 = tt.rxcui
    join RxnConso r5 on r5.rxcui = rr.rxcui1 and r5.sab = 'RXNORM' and TTY = 'SCDF'
    order by tt.str, tt.code, r5.str
    
    
    
/* Create the ATC Table */
    
    
create table rxnorm_prescribe.atc_ingredients as         
select t.*, r4.STR as ATC4_Name, r3.STR as ATC3_Name, r2.STR as ATC2_Name,
 r1.STR as ATC1_Name
from rxnorm.rxnconso r4 join        
  (select r1.rxcui, r1.CODE as ATC5,
    left(CODE,5) as ATC4,
    left(CODE,4) as ATC3,
    left(CODE,3) as ATC2,
    left(CODE,1) as ATC1,
     r1.STR as ATC5_Name
      from rxnorm.RxnConso r1 where r1.SAB = 'ATC' and r1.TTY = 'IN') t
   on t.ATC4 = r4.Code and r4.SAB = 'ATC' and r4.tty = 'PT'
   join rxnorm.rxnconso r3 on t.ATC3 = r3.Code and r3.SAB = 'ATC' and r3.tty = 'PT'
   join rxnorm.rxnconso r2 on t.ATC2 = r2.Code and r2.SAB = 'ATC' and r2.tty = 'PT'
   join rxnorm.rxnconso r1 on t.ATC1 = r1.Code and r1.SAB = 'ATC' and r1.tty = 'PT'
   order by t.ATC5;
   
select distinct atc2, atc2_Name from atc_ingredients;
  
select distinct atc3, atc3_Name from atc_ingredients;
   
select distinct atc4, atc4_Name from atc_ingredients;   

select distinct rela from rxnrel where sab='RXNORM'
select distinct TTY from rxnconso where sab='RXNORM'
   
select distinct t.indicator, t.counter, r2.str as dosage_form, ai.*, r2.rxcui as rxcui_dosage from atc_ingredients ai join 
   rxnrel rr1 on ai.rxcui = rr1.RXCUI2 and rela = 'ingredient_of' and rr1.SAB = 'RXNORM'
   join RxnConso r1 on r1.rxcui = rr1.RXCUI1 and r1.TTY = 'SCDF'
   join rxnrel rr2 on rr2.RXCUI2 = r1.RXCUI and rr2.rela = 'has_dose_form' and rr2.SAB = 'RXNORM' 
   join RxnConso r2 on r2.rxcui = rr2.RXCUI1 and r2.TTY = 'FN'
   left outer join 
    (select zz.atc5_name, 1 as indicator, count(*) as counter 
      from atc_ingredients zz group by zz.atc5_name having count(*) > 1) t
   on t.atc5_name = ai.atc5_name
   order by ai.atc5_name, ai.atc5, r2.str
    ;
  create index idx_dd_scd_rxcui on rxnorm_prescribe.drug_details(scd_rxcui);

create table rxnorm_prescribe.atc_ingredient_link_to_in_rxcui1    
  select distinct ai.*, dd.dose_form, dd.rxn_human_drug, dd.rxterm_form 
    from rxnorm_prescribe.drug_details dd
  join  rxnorm_prescribe.relation_between_ingredient_clinical_drug rcd on dd.scd_rxcui = rcd.scd_rxcui
  join rxnorm_prescribe.ingredient_details id on id.in_rxaui = rcd.in_rxaui
  join rxnorm_prescribe.atc_ingredients ai on ai.rxcui = id.in_rxcui
  order by ATC5_Name, ATC5;
  ;

create table rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2  
select t.* from (
  select ail.*, t.counter from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui1 ail join (  
    select rxcui, ATC5_Name, count(distinct atc5) as counter from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui1
    group by ATC5_Name) t where t.rxcui = ail.rxcui) t order by counter desc, atc5_name, atc5;
  ;

drop table rxnorm_prescribe.atc_ingredient_link_to_in_rxcui3;  



 select count(*) as counter, 
  dose_form, rxterm_form ,atc1_name from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where counter = 1 and atc1 = 'A'
  group by dose_form, rxterm_form ,atc1_name
  order by count(*) desc;
  ;
 
 ('Ophthalmic Gel', 'Topical Solution', 'Otic Solution', 'Topical Lotion', 'Topical Foam', 'Vaginal Cream', 'Transdermal Patch','Irrigation Solution','TOPICAL SPRAY','Topical Gel','Topical Ointment','Topical Cream','Ophthalmic Solution')

create table rxnorm_prescribe.atc_ingredient_link_to_in_rxcui3   
 select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where counter > 1;

delete from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui3 where rxn_human_drug is NULL;
 
 /*Enemas and rectal foams for treatment of e.g. ulcerative colitis are classified here. Oral budesonide for treatment of morbus Crohn is also classified here. */

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc4 = 'A07EA' and 
  (dose_form like ('Rectal%') or dose_form like 'Enema%');


/* 

New search    Hide text from Guidelines
A ALIMENTARY TRACT AND METABOLISM
A01 STOMATOLOGICAL PREPARATIONS

A01A STOMATOLOGICAL PREPARATIONS

This group comprises agents for treatment of conditions of mouth and teeth. It is difficult to differentiate between preparations for use in the mouth and preparations for use in the throat. Preparations mainly used in gingivitis, stomatitis etc. should be classified in this group.

Preparations for the treatment of throat infections, (lozenges for common cold conditions) are classified in R02 - Throat preparations.

Preparations containing local anesthetics, see N01B - Anesthetics, local, and R02AD - Anesthetics, local */

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc3 = 'A01A' and dose_form in ('Mouthwash', 'Oral Gel', 'Oral Paste', 'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge');

/*
This group comprises plain antacid drugs, antacids in combination with antiflatulents and antacids in combination with other drugs.

Antacids in combination with liquorice root or linseed are classified in this group.


Plain antiflatulents, see A03AX - Other drugs for functional gastrointestinal disorders.
*/

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A02' and dose_form not in ('Prefilled Applicator','Mouthwash', 'Oral Gel', 'Oral Paste', 'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution');

/*
Unsure about
2541	A02BA01	A02BA	A02B	A02	A	cimetidine	H2-receptor antagonists	DRUGS FOR PEPTIC ULCER AND GASTRO-OESOPHAGEAL REFLUX DISEASE (GORD)	DRUGS FOR ACID RELATED DISORDERS	ALIMENTARY TRACT AND METABOLISM	Injectable Solution	US	Sol	1
283742	A02BC05	A02BC	A02B	A02	A	esomeprazole	Proton pump inhibitors	DRUGS FOR PEPTIC ULCER AND GASTRO-OESOPHAGEAL REFLUX DISEASE (GORD)	DRUGS FOR ACID RELATED DISORDERS	ALIMENTARY TRACT AND METABOLISM	Injectable Solution	US	Sol	1
4278	A02BA03	A02BA	A02B	A02	A	famotidine	H2-receptor antagonists	DRUGS FOR PEPTIC ULCER AND GASTRO-OESOPHAGEAL REFLUX DISEASE (GORD)	DRUGS FOR ACID RELATED DISORDERS	ALIMENTARY TRACT AND METABOLISM	Injectable Solution	US	Sol	1
40790	A02BC02	A02BC	A02B	A02	A	pantoprazole	Proton pump inhibitors	DRUGS FOR PEPTIC ULCER AND GASTRO-OESOPHAGEAL REFLUX DISEASE (GORD)	DRUGS FOR ACID RELATED DISORDERS	ALIMENTARY TRACT AND METABOLISM	Injectable Solution	US	Sol	1
9143	A02BA02	A02BA	A02B	A02	A	ranitidine	H2-receptor antagonists	DRUGS FOR PEPTIC ULCER AND GASTRO-OESOPHAGEAL REFLUX DISEASE (GORD)	DRUGS FOR ACID RELATED DISORDERS	ALIMENTARY TRACT AND METABOLISM	Injectable Solution	US	Sol	1
*/

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A03' and dose_form not in ('Prefilled Applicator','Mouthwash', 'Oral Gel', 'Oral Paste', 'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment');

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A04' and dose_form not in ('Prefilled Applicator','Mouthwash', 'Oral Gel', 'Oral Paste', 'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution');

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A05' and dose_form not in ('Prefilled Applicator','Mouthwash', 'Oral Gel', 'Oral Paste', 'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution');
/* no records */

/* DRUGS FOR CONSTIPATION */
select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A06' and dose_form not in ('Mouthwash', 'Oral Gel', 'Oral Paste', 'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution', 
'Oral Spray', 'Injectable Solution', 'Nasal Spray', 'Ophthalmic Gel', 'Ophthalmic Ointment', 'Mucosal Spray', 'Injectable Suspension'
);

/*ANTIDIARRHEALS, INTESTINAL ANTIINFLAMMATORY/ANTIINFECTIVE AGENTS*/

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A07' and atc4 != 'A07EA' and dose_form not in ('Mouthwash', 'Oral Gel', 'Oral Paste', 
'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution', 
'Oral Spray', 'Injectable Solution', 'Nasal Spray', 'Ophthalmic Gel', 'Ophthalmic Ointment', 'Mucosal Spray', 
'Injectable Suspension', 'Otic Solution', 'Otic Suspension','Augmented Topical Cream', 'Augmented Topical Lotion', 'Augmented Topical Ointment',
'Dry Powder Inhaler', 'Inhalant Solution', 'Medicated Pad', 'Medicated Shampoo', 'Metered Dose Inhaler', 'Nasal Inhaler', 'Ophthalmic Suspension',
'Otic Suspension','Powder Spray', 'Prefilled Applicator', 'Topical Cream', 'Topical Foam', 'Topical Gel', 'Topical Lotion', 'Topical Powder',
'Topical Solution', 'Topical Spray', 'Vaginal Cream', 'Vaginal Suppository'
);

/* Antiobesity */
select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A08' and dose_form not in ('Mouthwash', 'Oral Gel', 'Oral Paste', 
'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution', 
'Oral Spray', 'Injectable Solution', 'Nasal Spray', 'Ophthalmic Gel', 'Ophthalmic Ointment', 'Mucosal Spray', 
 'Otic Solution', 'Otic Suspension','Augmented Topical Cream', 'Augmented Topical Lotion', 'Augmented Topical Ointment',
'Dry Powder Inhaler', 'Inhalant Solution', 'Medicated Pad', 'Medicated Shampoo', 'Metered Dose Inhaler', 'Nasal Inhaler', 'Ophthalmic Suspension',
'Otic Suspension','Powder Spray', 'Prefilled Applicator', 'Topical Cream', 'Topical Foam', 'Topical Gel', 'Topical Lotion', 'Topical Powder',
'Topical Solution', 'Topical Spray', 'Vaginal Cream', 'Vaginal Suppository'
);

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A09' and dose_form not in ('Mouthwash', 'Oral Gel', 'Oral Paste', 
'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution', 
'Oral Spray', 'Injectable Solution', 'Nasal Spray', 'Ophthalmic Gel', 'Ophthalmic Ointment', 'Mucosal Spray', 
'Otic Solution', 'Otic Suspension','Augmented Topical Cream', 'Augmented Topical Lotion', 'Augmented Topical Ointment',
'Dry Powder Inhaler', 'Inhalant Solution', 'Medicated Pad', 'Medicated Shampoo', 'Metered Dose Inhaler', 'Nasal Inhaler', 'Ophthalmic Suspension',
'Otic Suspension','Powder Spray', 'Prefilled Applicator', 'Topical Cream', 'Topical Foam', 'Topical Gel', 'Topical Lotion', 'Topical Powder',
'Topical Solution', 'Topical Spray', 'Vaginal Cream', 'Vaginal Suppository'
);

/* Diabetes drugs */
select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A10';

/* Vitamins */
select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A11' and dose_form
not in ('Mouthwash', 'Oral Gel', 'Oral Paste', 
'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution', 
'Oral Spray', 'Injectable Solution', 'Nasal Spray', 'Ophthalmic Gel', 'Ophthalmic Ointment', 'Mucosal Spray', 
'Otic Solution', 'Otic Suspension','Augmented Topical Cream', 'Augmented Topical Lotion', 'Augmented Topical Ointment',
'Dry Powder Inhaler', 'Inhalant Solution', 'Medicated Pad', 'Medicated Shampoo', 'Metered Dose Inhaler', 'Nasal Inhaler', 'Ophthalmic Suspension',
'Otic Suspension','Powder Spray', 'Prefilled Applicator', 'Topical Cream', 'Topical Foam', 'Topical Gel', 'Topical Lotion', 'Topical Powder',
'Topical Solution', 'Topical Spray', 'Vaginal Cream', 'Vaginal Suppository'
);

/* MINERAL SUPPLEMENTS */
select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A12' and dose_form
not in ('Mouthwash', 'Oral Gel', 'Oral Paste', 
'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution', 
'Oral Spray', 'Injectable Solution', 'Nasal Spray', 'Ophthalmic Gel', 'Ophthalmic Ointment', 'Mucosal Spray', 
'Otic Solution', 'Otic Suspension','Augmented Topical Cream', 'Augmented Topical Lotion', 'Augmented Topical Ointment',
'Dry Powder Inhaler', 'Inhalant Solution', 'Medicated Pad', 'Medicated Shampoo', 'Metered Dose Inhaler', 'Nasal Inhaler', 'Ophthalmic Suspension',
'Otic Suspension','Powder Spray', 'Prefilled Applicator', 'Topical Cream', 'Topical Foam', 'Topical Gel', 'Topical Lotion', 'Topical Powder',
'Topical Solution', 'Topical Spray', 'Vaginal Cream', 'Vaginal Suppository', 'Nasal Solution', 'Nasal Gel'
);


select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A13';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A14';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'A15';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'B01';

/* epinephrine */
select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'B02' not in ('Metered Dose Inhaler', 'Nasal Spray', 'Topical Solution', 'Topical Spray','Transdermal Patch');

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'B03';


select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'B04';

/* TODO IV needs to be done separately */

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'B05' and dose_form
not in ('Mouthwash', 'Oral Gel', 'Oral Paste', 
'Oral Foam', 'Toothpaste', 'Chewing Gum', 'Lozenge', 'Irrigation Solution','Topical Ointment', 'Ophthalmic Solution', 
'Oral Spray', 'Injectable Solution', 'Nasal Spray', 'Ophthalmic Gel', 'Ophthalmic Ointment', 'Mucosal Spray', 
'Otic Solution', 'Otic Suspension','Augmented Topical Cream', 'Augmented Topical Lotion', 'Augmented Topical Ointment',
'Dry Powder Inhaler', 'Inhalant Solution', 'Medicated Pad', 'Medicated Shampoo', 'Metered Dose Inhaler', 'Nasal Inhaler', 'Ophthalmic Suspension',
'Otic Suspension','Powder Spray', 'Prefilled Applicator', 'Topical Cream', 'Topical Foam', 'Topical Gel', 'Topical Lotion', 'Topical Powder',
'Topical Solution', 'Topical Spray', 'Vaginal Cream', 'Vaginal Suppository', 'Nasal Solution', 'Nasal Gel','Paste', 'Rectal Suppository',
'Ophthalmic Irrigation Solution', 'Medicated Liquid Soap', 'Drug Implant'
);

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'C10'

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'D'; /* detailed */

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc3 = 'D01A' and dose_form like '%Topical%';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc2 = 'D07' and dose_form like '%Topical%';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'G' and dose_form not like 'Otic%' 
and dose_form not like 'Ophthalmic%' and dose_form not like '%Topical%' and dose_form not like '%Shampoo%' and dose_form not like '%Lozenge%';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'H';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'J'
and (dose_form not like 'Vagina%' and dose_form not like 'Topical%' and dose_form not like 'Otic%'
and dose_form not like 'Ophthalmic%' and dose_form not like 'Medicated%' and dose_form not like 'Irrigation%' 
and dose_form not like 'Inhalant');
;

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'L'; /* Checked */

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'M' and dose_form not like 'Ophthalmic%' 
and dose_form not like 'Ophthalmic%' and dose_form not like 'Nasal%';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'N' and dose_form not like 'Ophthalmic%' 
and dose_form not like 'Ophthalmic%';

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'P'; /* Check v route */

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'R'; /* In depth */

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'S' and (dose_form like 'Ophthalmic%' or dose_form like 'Otic%') ;

select * from rxnorm_prescribe.atc_ingredient_link_to_in_rxcui2 where atc1 = 'V';

select distinct ATC1, ATC1_Name FROM rxnorm_prescribe.atc_ingredients