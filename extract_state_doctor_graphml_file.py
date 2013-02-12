__author__ = 'Janos G. Hajagos'

import pyodbc as odbc
import networkx as nx

REFERRAL_TABLE_NAME = "referral.referral2011"
NPI_DETAIL_TABLE_NAME = "referral.npi_summary_taxonomy"
FIELD_NAME_FROM_RELATIONSHIP = "npi_from"
FIELD_NAME_TO_RELATIONSHIP = "npi_to"

def logger(string_to_write):
    print(string_to_write)

def get_new_cursor(dsn_name="referral"):
    logger("Opening connection %s" % dsn_name)
    connection = odbc.connect("DSN=%s" % dsn_name, autocommit=True)
    return connection.cursor()

def row_to_dictionary(row_obj,exclude_None = True):
    column_names = [desc[0] for desc in row_obj.cursor_description]
    row_dict = {}
    for i in range(len(column_names)):
        if exclude_None:
            if row_obj[i] is not None:
                row_dict[column_names[i]] = row_obj[i]
    return row_dict

def add_nodes_to_graph(cursor, graph, node_type):
    i = 0
    for node in cursor:
        attributes = row_to_dictionary(node)
        attributes["node_type"] = node_type
        graph.add_node(node.npi,attributes)
        i += 1
    logger("Imported %s nodes" % i)
    return graph

def add_edges_to_graph(cursor, graph, name="shares patients"):
    i = 0
    for edge in cursor:
        graph.add_edge(edge[0],edge[1],weight=edge[2])
        i += 1

    logger("Imported %s edges" % i)
    return graph

def main(where_criteria, referral_table_name=REFERRAL_TABLE_NAME, npi_detail_table_name=NPI_DETAIL_TABLE_NAME, field_name_to_relationship=FIELD_NAME_TO_RELATIONSHIP, field_name_from_relationship=FIELD_NAME_FROM_RELATIONSHIP):
    cursor = get_new_cursor()

    cursor.execute("drop table if exists npi_to_export_to_graph;")
    cursor.execute("create table npi_to_export_to_graph (npi char(10),node_type char(1));")

    # Get NPI from each side of the relationship
    query_first_part = """select distinct npi from %s rt1 join %s tnd1 on rt1.%s = tnd1.npi where %s""" % (referral_table_name,npi_detail_table_name,field_name_from_relationship, where_criteria)
    query_second_part = """select distinct npi from %s rt2 join %s tnd2 on rt2.%s = tnd2.npi where %s""" % (referral_table_name,npi_detail_table_name,field_name_to_relationship, where_criteria)
    query_to_execute = "insert into npi_to_export_to_graph (npi,node_type)select t.*,'C' from (\n%s\nunion\n%s)\nt;" % (query_first_part, query_second_part)

    logger(query_to_execute)
    cursor.execute(query_to_execute)

    ProviderGraph = nx.DiGraph()

    query_to_execute = "select * from npi_to_export_to_graph neg join %s tnd on tnd.npi = neg.npi" % npi_detail_table_name
    logger(query_to_execute)

    logger("Adding indices")
    cursor.execute("create unique index idx_primary_npi_graph on npi_to_export_to_graph(npi);")

    logger("Populating core nodes")
    cursor.execute(query_to_execute)
    ProviderGraph = add_nodes_to_graph(cursor, ProviderGraph, "core")

    logger("Adding leaf nodes")

    query_to_execute = """insert into npi_to_export_to_graph (npi,node_type)
    select t.npi,'L'  from (
  select distinct rt1.%s as npi FROM npi_to_export_to_graph neg1 join %s rt1 on rt1.%s = neg1.npi
    union
  select distinct rt2.%s as npi FROM npi_to_export_to_graph neg2 join %s rt2 on rt2.%s = neg2.npi
  ) t where npi not in (select npi from npi_to_export_to_graph)""" % (field_name_from_relationship, referral_table_name, field_name_to_relationship, field_name_to_relationship, referral_table_name, field_name_from_relationship)

    logger(query_to_execute)
    cursor.execute(query_to_execute)

    logger("Populating leaf nodes")

    query_to_execute = "select * from npi_to_export_to_graph neg join %s tnd on tnd.npi = neg.npi where neg.node_type = 'L'" % npi_detail_table_name
    logger(query_to_execute)
    cursor.execute(query_to_execute)
    ProviderGraph = add_nodes_to_graph(cursor, ProviderGraph, "leaves")

    logger("Populating edges")

    query_to_execute = """select rt.%s,rt.%s,rt.weight from %s rt join npi_to_export_to_graph neg on rt.%s = neg.npi
  where neg.node_type = 'C'
  union
select rt.%s,rt.%s,rt.weight from %s rt join npi_to_export_to_graph neg on rt.%s = neg.npi
  where neg.node_type = 'C'
    """ % (field_name_from_relationship,field_name_to_relationship, referral_table_name, field_name_from_relationship, field_name_from_relationship, field_name_to_relationship, referral_table_name, field_name_to_relationship)

    logger(query_to_execute)
    cursor.execute(query_to_execute)
    ProviderGraph = add_edges_to_graph(cursor,ProviderGraph)

    logger("Writing GraphML file")

    nx.write_graphml(ProviderGraph, "provider_graph.graphml")

if __name__ == "__main__":
    main("state = 'WY'")
