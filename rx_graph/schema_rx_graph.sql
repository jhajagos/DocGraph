
drop table if exists rx_graph_brand_name;

create table rx_graph_brand_name (id integer not null auto_increment,
  npi char(10),
  brand_name varchar(128),
  claim_count Integer,
  claim_count_raw Integer,
  claim_count_compound Integer,
  quantity_sum Integer,
  day_supply_sum Integer,
  gross_drug_cost_sum Float,
   primary key(id));


LOAD DATA INFILE '/tmp/npi_bn.csv' INTO TABLE rx_graph_brand_name
      FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\0'
      LINES TERMINATED BY '\n'
      IGNORE 1 LINES
       (@npi, @brand_name, @claim_count, @claim_count_raw, @claim_count_compound, @quantity_sum, @day_supply_sum, @gross_drug_cost_sum)
       set
        npi = case @npi when '' then NULL else @npi end,
        brand_name = case @brand_name when '' then NULL else @brand_name end,
        claim_count = case @claim_count when '' then NULL else @claim_count end,
        claim_count_raw = case @claim_count_raw when '' then NULL else @claim_count_raw end,
        claim_count_compound = case @claim_count_compound when '' then NULL else @claim_count_compound end,
        quantity_sum = case @claim_count_compound when '' then NULL else @claim_count_compound end,
        day_supply_sum = case @day_supply_sum when '' then NULL else @day_supply_sum end,
        gross_drug_cost_sum = case @gross_drug_cost_sum when '' then NULL else @gross_drug_cost_sum end;

drop table rx_graph_ndc9_rxcui;
drop table if exists rx_graph_ndc9;

create table rx_graph_ndc9 (id integer not null auto_increment,
npi char(10),
ndc9 char(9),
rxcui_name varchar(1023),
claim_count  Integer,
claim_count_raw1  Integer,
claim_count_cmpnd2  Integer,
quantity_sum  Integer,
day_supply_sum Integer,
gross_drug_cost_sum DOUBLE,
primary key(id));

LOAD DATA INFILE '/tmp/npi_ndc9.csv' INTO TABLE rx_graph_ndc9
      FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\0'
      LINES TERMINATED BY '\n'
      IGNORE 1 LINES
       (@npi, @ndc9, @claim_count, @claim_count_raw1, @claim_count_cmpnd2, @quantity_sum, @day_supply_sum, @gross_drug_cost_sum)
       set
        npi = case @npi when '' then NULL else @npi end,
        ndc9 = case @ndc9 when '' then NULL else @ndc9 end,
        claim_count = case @claim_count when '' then NULL else @claim_count end,
        claim_count_raw1 = case @claim_count_raw1 when '' then NULL else @claim_count_raw1 end,
        claim_count_cmpnd2 = case @claim_count_cmpnd2 when '' then NULL else @claim_count_cmpnd2 end,
        quantity_sum = case @quantity_sum when '' then NULL else @quantity_sum end,
        day_supply_sum = case @day_supply_sum when '' then NULL else @day_supply_sum end,
        gross_drug_cost_sum = case @gross_drug_cost_sum when '' then NULL else @gross_drug_cost_sum end;

create index idx_rx_npi_ndc9_ndc9 on rx_graph_ndc9_rxcui(ndc9);
create index idx_rx_npi_ndc9_npi on rx_graph_ndc9_rxcui(npi);

