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

drop table if exists  rxnorm_prescribe.ndc9_synthetic_rxcui;

create table rxnorm_prescribe.ndc9_synthetic_rxcui (
  synthetic_rxcui varchar(511),
  synthetic_label varchar(1023),
  compact_counter integer,
  ndc9 char(9));
SET group_concat_max_len=100000;

insert rxnorm_prescribe.ndc9_synthetic_rxcui (synthetic_rxcui, synthetic_label, compact_counter, ndc9)
  select cast(synthetic_rxcui_text as char(511)) as synthetic_rxcui, 
    cast(left(synthetic_label_text, 1023) as char(1023)) as synthetic_label, 
    t.compact_counter, t.ndc9  from (
    select GROUP_CONCAT(distinct rxcui order by rxcui asc separator '|') as synthetic_rxcui_text, 
        count(distinct rxcui) as compact_counter, ndc9, 
        GROUP_CONCAT(distinct label order by label asc separator '|') as synthetic_label_text from (
        select distinct r1.rxcui,  rn1.atv as ndc, left(rn1.atv,9) as ndc9, r1.str as label  
          from rxnorm.rxnconso r1 
          join rxnorm.rxnsat rn1 on r1.rxaui = rn1.rxaui and rn1.atn = 'NDC'
            where char_length(rn1.atv) = 11 and r1.SAB = 'RXNORM' and r1.SUPPRESS = 'N' and r1.TTY in ('SCD', 'SBD')) t group by ndc9) t
            order by compact_counter desc;
          
  
