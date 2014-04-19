/* Run against a UMLS database with all english language sources and all sources */

/*
use umls2013ab;
*/

/* For HCPCS codes utilize the UMLS to add header terms */

drop table hcpcs_umls_mapping;

create table  hcpcs_umls_mapping as
  select t.*, tt.* from (
  select mr.CUI, mr.AUI, mr.SAB,  ms.VSAB, ms.SRL as source_release_level, mr.LUI, mr.SUI, mr.CODE as code, mr.STR as description 
    from mrconso mr  join mrsab ms on ms.RSAB = mr.SAB and ms.SABIN = 'Y'
      where mr.SAB in ('CPT', 'HCDT', 'HCPCS')
   and TTY = 'PT'
  ) t
  join mrrel mr1 on mr1.AUI1 = t.AUI and mr1.REL = 'PAR'
  join
  (select mr.CUI as header_CUI, mr.LUI as header_LUI, mr.SUI as header_SUI, mr.AUI as header_AUI, 
    mr.SAB as header_SAB,  mr.CODE as header_code, mr.STR as header_description 
      from mrconso mr 
      where mr.SAB in ('MTHCH', 'MTHHH')
   and TTY = 'HT') tt
   on tt.header_AUI = mr1.AUI2

  ;
 /* 15425 */
 
create index idx_hum_cui on hcpcs_umls_mapping(cui);
create index idx_mc_cui on mrconso(cui);

create table synthetic_mrsty as 
select CUI, GROUP_CONCAT(distinct STN order by STN asc separator '|') as synthetic_STN,
  GROUP_CONCAT(distinct STY order by STN asc separator '|') as synthetic_STY
from mrsty group by CUI;

create index idx_sms_cui on synthetic_mrsty(CUI);

drop table hcpcs_umls_mapping_enhanced1;
create table hcpcs_umls_mapping_enhanced1 as 
  select hum.*, sm.synthetic_STN, sm.synthetic_STY from hcpcs_umls_mapping hum join synthetic_mrsty sm on hum.CUI = sm.CUI; 

drop table cui_flattened_str_open;

create table cui_flattened_str_open as 
  select mr.CUI, count(*) as alternative_counter, 
      GROUP_CONCAT(distinct STR order by SAB, TTY asc separator '|') as alternative_description, 
      GROUP_CONCAT(distinct AUI order by SAB, TTY asc separator '|') as alternative_AUI, 
      GROUP_CONCAT(distinct TTY order by SAB, TTY asc separator '|')  as alternative_TTY,
      GROUP_CONCAT(distinct SAB order by SAB, TTY asc separator '|')  as alternative_SAB
    from MRCONSO mr where mr.SRL = 0
    group by mr.CUI
    ; 

create index idx_cfso_cui on cui_flattened_str_open(cui);

drop table hcpcs_umls_mapping_enhanced2;
create table hcpcs_umls_mapping_enhanced2
  select hume.*, cfso.alternative_description, cfso.alternative_AUI, cfso.alternative_TTY,cfso.alternative_SAB  from hcpcs_umls_mapping_enhanced1 hume left outer join   
    cui_flattened_str_open cfso on 
        cfso.CUI = hume.CUI;
    ;

create table hcpcs_umls_mapping_enhanced
  select *, 
    case 
      when source_release_level = 0 then description
      when popped_description != description then popped_description
      else concat('(h) ',header_description)
      end as cleaned_description
      from     
    (select *, 
      case when locate('|', alternative_description) then
        left(alternative_description, locate('|', alternative_description) - 1) 
       else alternative_description end as popped_description
      from hcpcs_umls_mapping_enhanced2) t;


/* 

The final table has the following output:

CUI	AUI	SAB	VSAB	source_release_level	LUI	SUI	code	description	header_CUI	header_LUI	header_SUI	header_AUI	header_SAB	header_code	header_description	synthetic_STN	synthetic_STY	alternative_description	alternative_AUI	alternative_TTY	alternative_SAB	popped_description	cleaned_description
C0187190	A0331401	CPT	CPT2013	3	L0225864	S0300971	25920	Disarticulation through wrist	C0519308	L0695805	S0803165	A13076486	MTHCH	Level 4: 25900-25931	Amputation on the Musculoskeletal System of the Forearm and Wrist	B1.3.1.3	Therapeutic or Preventive Procedure	disarticulation through wrist|wrist disarticulation	A18652480|A18578061|A8483499	PT|SY|PN	CHV|MTH	disarticulation through wrist	(h) Amputation on the Musculoskeletal System of the Forearm and Wrist
C1384684	A0331443	CPT	CPT2013	3	L0225897	S0301004	25927	Transmetacarpal amputation	C0519308	L0695805	S0803165	A13076486	MTHCH	Level 4: 25900-25931	Amputation on the Musculoskeletal System of the Forearm and Wrist	B1.3.1.3	Therapeutic or Preventive Procedure	Transmetacarpal amputation (procedure)	A13083935	PN	MTH	Transmetacarpal amputation (procedure)	Transmetacarpal amputation (procedure)
C0186539	A0644161	CPT	CPT2013	3	L0225107	S0589047	25900	Amputation, forearm, through radius and ulna	C0519308	L0695805	S0803165	A13076486	MTHCH	Level 4: 25900-25931	Amputation on the Musculoskeletal System of the Forearm and Wrist	B1.3.1.3	Therapeutic or Preventive Procedure	Amputation thru forearm|Amputation through forearm|Amputation of forearm through radius AND ulna|Forearm amputation	A16987112|A8350934|A13083931|A8368657	AB|PT|PN|ET	ICD9CM|MTH|MTHICD9	Amputation thru forearm	Amputation thru forearm
C0186542	A0644162	CPT	CPT2013	3	L0502091	S0589049	25909	Amputation, forearm, through radius and ulna; re-amputation	C0519308	L0695805	S0803165	A13076486	MTHCH	Level 4: 25900-25931	Amputation on the Musculoskeletal System of the Forearm and Wrist	B1.3.1.3	Therapeutic or Preventive Procedure	Amputation of forearm through radius AND ulna, reamputation	A13083927	PN	MTH	Amputation of forearm through radius AND ulna, reamputation	Amputation of forearm through radius AND ulna, reamputation
C0186541	A0644163	CPT	CPT2013	3	L0225112	S0589050	25907	Amputation, forearm, through radius and ulna; secondary closure or scar revision	C0519308	L0695805	S0803165	A13076486	MTHCH	Level 4: 25900-25931	Amputation on the Musculoskeletal System of the Forearm and Wrist	B1.3.1.3	Therapeutic or Preventive Procedure	Amputation, forearm, through radius and ulna; secondary closure or scar revision	A13083926	PN	MTH	Amputation, forearm, through radius and ulna; secondary closure or scar revision	(h) Amputation on the Musculoskeletal System of the Forearm and Wrist

by combining the CUI,STY,cleaned_description can be used as a description. When possible the mapping goes to a description from a
public domain STR 

A cleaned_description which starts with (h) indicates that there is no alternative description.

*/

