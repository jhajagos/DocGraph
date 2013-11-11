
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
    
    
create table atc_ingredients as         
select t.*, r4.STR as ATC4_Name, r3.STR as ATC3_Name, r2.STR as ATC2_Name,
 r1.STR as ATC1_Name
from rxnconso r4 join        
  (select r1.rxcui, r1.CODE as ATC5,
    left(CODE,5) as ATC4,
    left(CODE,4) as ATC3,
    left(CODE,3) as ATC2,
    left(CODE,1) as ATC1,
     r1.STR as ATC5_Name
      from RxnConso r1 where r1.SAB = 'ATC' and r1.TTY = 'IN') t
   on t.ATC4 = r4.Code and r4.SAB = 'ATC' and r4.tty = 'PT'
   join rxnconso r3 on t.ATC3 = r3.Code and r3.SAB = 'ATC' and r3.tty = 'PT'
   join rxnconso r2 on t.ATC2 = r2.Code and r2.SAB = 'ATC' and r2.tty = 'PT'
   join rxnconso r1 on t.ATC1 = r1.Code and r1.SAB = 'ATC' and r1.tty = 'PT'
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