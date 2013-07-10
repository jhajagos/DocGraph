/* This is a template file that is customized by generate_provider_graph_load_sql.py */

create database provider_graph;
use provider_graph;

/* npis_key is constructed in such a way that (assume there are no self loops)
 e.g., npi_from = 1234567890 and npi_to 9876543210
 npi_from > npi_to = |1234567890||9876543210|
 and
 npi_from = 9876543210 and npi_to 1234567890
 npi_from < npi_to = |1234567890||9876543210|

 This will allow us to easily create an undirected graph to work with.
 */

drop table if exists provider_directed_graph;
create table provider_directed_graph (id integer not null auto_increment, npi_from char(10), npi_to char(10),
  weight integer, log2_weight double, ln_weight double, log10_weight double,
  npi1 char(10), npi2 char(10),
  npis_key char(24), set_indicator varchar(100), primary key(id));


/* Load data from CSV */
LOAD DATA INFILE '/temp/referral.2011.csv' INTO TABLE provider_directed_graph
      FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\0'
      LINES TERMINATED BY '\n'
       (@npi_from, @npi_to, @weight)
       set
       npi_from = case @npi_from when '' then NULL else @npi_from end,
       npi_to = case @npi_to when '' then NULL else @npi_to end,
       weight = case @weight when '' then NULL else @weight end;

/* Apply math transforms */

update provider_directed_graph set log2_weight = log2(weight),
    ln_weight = ln(weight),
    log10_weight = log10(weight),
    npi1 = case when npi_from < npi_to then npi_from else npi_to end,
    npi2 = case when npi_from < npi_to then npi_to else npi_from end;

update provider_directed_graph set
  npis_key = concat('|',npi1,'||', npi2, '|'),
  set_indicator = 'provider_graph';

/* Create indexes on the table */

create index idx_pdg_npi_to on provider_directed_graph(npi_to);
create index idx_pdg_npi_from on provider_directed_graph(npi_from);
create index idx_pdg_npi1 on provider_directed_graph(npi1);
create index idx_pdg_npi2 on provider_directed_graph(npi2);
create index idx_pdg_npis_key on provider_directed_graph(npis_key);


/*
original_weight_relation
ftg -- from weight is greater than to weight
ftl -- from weight is less than to weight
fte -- from weight is equal to to
fto -- from weight only

original_link_type
1 - only a single link
2 - directional link
*/


drop table if exists provider_undirected_graph;

create table provider_undirected_graph (id integer not null auto_increment,
  npi1 char(10), npi2 char(10), original_link_type smallint, min_weight integer,
  max_weight integer, original_weight_relation char(3), weight_range integer, mean_weight double, mean_log2_weight double,
  mean_ln_weight double, mean_log10_weight double, npis_key char(24), set_indicator varchar(100), primary key(id));

/* Create indexes */

create index idx_pug_npi1 on provider_undirected_graph(npi1);
create index idx_pug_npi2 on provider_undirected_graph(npi2);
create index idx_pug_npis_key on provider_undirected_graph(npis_key);

/* Populated undirected graph */

insert into provider_undirected_graph
  (original_link_type, min_weight, max_weight, npis_key, npi1, npi2, set_indicator, original_weight_relation, weight_range, mean_weight,
     mean_log2_weight,
    mean_ln_weight, mean_log10_weight)
select *, log2(mean_weight) as mean_log2_weight, ln(mean_weight) as mean_ln_weight, log10(mean_weight) as mean_log10_weight
  from
  (select *,
    case
      when original_link_type = 1 then 'fto'
      when min_weight = max_weight then 'fte'
    else 'ft'
    end as original_weight_relation,
    max_weight - min_weight as weight_range,
    (min_weight + max_weight) / 2.0 as mean_weight
    from
      (select count(*) as original_link_type,min(weight) as min_weight,
        max(weight) as max_weight, npis_key, npi1, npi2, set_indicator
        from provider_directed_graph group by npis_key) t) tt;

 /* This allows us to know which direction the weight relation originally went in */

/* This update join is taking several days on MySQL while the above took 7 hours */


update provider_undirected_graph pug join provider_directed_graph pdg
    on (pdg.npi_from = pug.npi1 and pdg.npi_to = pug.npi2
   and pug.original_link_type = 2 and pug.original_weight_relation = 'ft')
    set pug.original_weight_relation = case when pdg.weight = min_weight then 'ftl' when pdg.weight = max_weight then 'ftg' end;