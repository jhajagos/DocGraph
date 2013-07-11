/* Nodes which are a complete graph 3 */
/*
    2 - 3
    | /
    1
 */
use brooklyn_core_graph;
drop table if exists provider_three_complete_graph;
create table provider_three_complete_graph(id integer not null AUTO_INCREMENT,
  npi1 char(10), npi2 char(10), npi3 char(10),
  id1 integer, id2 integer, id3 integer,
  weight12 double, weight23 double,  weight31 double,min_weight double,
  set_indicator varchar(100), primary key(id));


/* This query is taking over five days to run */

insert into provider_three_complete_graph
  (npi1, npi2, npi3, id1, id2, id3, weight12, weight23, weight31, min_weight)
select
  pug1.npi1 as npi1,pug2.npi1 as npi2,pug3.npi2 as npi3,
  pug1.id as id1,pug2.id as id2,pug3.id as id3,
  pug1.mean_weight, pug2.mean_weight, pug3.mean_weight,
  case
    when pug1.mean_weight <= pug2.mean_weight and pug1.mean_weight <= pug3.mean_weight
      then pug1.mean_weight
    when pug2.mean_weight <= pug1.mean_weight and pug2.mean_weight <= pug3.mean_weight
      then pug2.mean_weight
    when pug3.mean_weight <= pug2.mean_weight and pug3.mean_weight <= pug1.mean_weight
      then pug3.mean_weight
  end as min_weight
  from provider_undirected_graph pug1
  join provider_undirected_graph pug2
    on pug1.npi2 = pug2.npi1
  join provider_undirected_graph pug3
  on pug3.npi2 = pug2.npi2 and pug3.npi1 = pug1.npi1
  ;

create index idx_p3cg_npi1 on provider_three_complete_graph(npi1);
create index idx_p3cg_npi2 on provider_three_complete_graph(npi2);
create index idx_p3cg_npi3 on provider_three_complete_graph(npi3);

/* Nodes which are a complete graph 4 */
/*
    2 - 3
    | X |
    1 - 4
*/

drop table if exists provider_four_complete_graph;
create table provider_four_complete_graph(id integer not null auto_increment,
  npi1 char(10), npi2 char(10), npi3 char(10), npi4 char(10),
  id1 integer, id2 integer, id3 integer, id4 integer,
  set_indicator varchar(100), primary key(id));

/*
insert into provider_four_complete_graph
  (npi1, npi2, npi3, npi4, id1, id2, id3, id4, min_weight)
    select ptcg1.npi1, ptcg1.npi2, ptcg1.npi3, ptcg2.npi3, ptcg1.id1, ptcg1.id2, ptcg1.id3, ptcg2.id3,
      case when ptcg1.min_weight < ptcg2.min_weight then ptcg1.min_weight else ptcg2.min_weight end as min_weight
     from provider_three_complete_graph ptcg1
      join provider_three_complete_graph ptcg2
    on ptcg1.npi1 = ptcg2.npi1 and
     ptcg1.npi3 = ptcg2.npi2;

create table provider_npis_in_triangles (npi char(10) not null, primary key(npi));

insert into provider_npis_in_triangles (npi)
  select distinct npi1 from provider_three_complete_graph
    union
  select distinct npi2 from provider_three_complete_graph
    union
  select distinct npi3 from provider_three_complete_graph;


insert into provider_npis_in_four_complete (npi)
  select distinct npi1 from provider_three_complete_graph
    union
  select distinct npi2 from provider_three_complete_graph
    union
  select distinct npi3 from provider_three_complete_graph
    union
  select distinct npi4 from provider_three_complete_graph;

*/