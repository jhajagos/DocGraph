/* Nodes which are a complete graph 3 */
/*
    2 - 3
    | /
    1
 */

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
  from provider_graph.provider_undirected_graph pug1
  join provider_graph.provider_undirected_graph pug2
    on pug1.npi2 = pug2.npi1
  join provider_graph.provider_undirected_graph pug3
  on pug3.npi2 = pug2.npi2 and pug3.npi1 = pug1.npi1
  ;

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
  weight12 double, weight23 double,  weight31 double, weight34 double, weight42 double, weight14 double,
  mean_weight double, npis_key123 char(36), npis_key134 char(36),
  npis_key_complete_graph_4 char(48), set_indicator varchar(100), primary key(id));
