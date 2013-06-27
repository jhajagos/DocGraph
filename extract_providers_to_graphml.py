"""
Script to extract a subgraph from the DocGraph data set that is loaded in a MySQL
database.

Database connection is made through ODBC connection

"""


__author__ = 'Janos G. Hajagos'

import pyodbc as odbc
import networkx as nx
import pprint

REFERRAL_TABLE_NAME = "referral.referral2011"
NPI_DETAIL_TABLE_NAME = "referral.npi_summary_taxonomy"
FIELD_NAME_FROM_RELATIONSHIP = "npi_from"
FIELD_NAME_TO_RELATIONSHIP = "npi_to"
FIELD_NAME_WEIGHT = "weight"


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


def add_nodes_to_graph(cursor, graph, node_type, label_name = None):
    i = 0
    for node in cursor:
        attributes = row_to_dictionary(node)
        if label_name:
            if label_name in attributes:
                attributes["Label"] = attributes[label_name]
        attributes["node_type"] = node_type
        graph.add_node(node.npi,attributes)
        i += 1
    logger("Imported %s nodes" % i)
    return graph


def add_edges_to_graph(cursor, graph, name="shares patients"):
    i = 0
    counter_dict = {}

    for edge in cursor:
        if edge.to_node_type == 'C' and edge.from_node_type == 'C':
            edge_type = 'core-to-core'
        elif edge.to_node_type == 'L' and edge.from_node_type == 'C':
            edge_type = 'leaf-to-core'
        elif edge.to_node_type == 'C' and edge.from_node_type == 'L':
            edge_type = 'core-to-leaf'
        elif edge.to_node_type == 'L' and edge.from_node_type == 'L':
            edge_type = 'leaf-to-leaf'
        else:
            edge_type = "None"

        if edge_type in counter_dict:
            counter_dict[edge_type] += 1
        else:
            counter_dict[edge_type] = 0

        graph.add_edge(edge[0], edge[1], weight=edge[2], edge_type=edge_type)
        i += 1

    logger("Imported %s edges" % i)
    logger("Edge types imported")
    logger(pprint.pformat(counter_dict))
    return graph

def main(where_criteria, referral_table_name=REFERRAL_TABLE_NAME, npi_detail_table_name=NPI_DETAIL_TABLE_NAME,
         field_name_to_relationship=FIELD_NAME_TO_RELATIONSHIP, field_name_from_relationship=FIELD_NAME_FROM_RELATIONSHIP,
         file_name_prefix="",add_leaf_to_leaf_edges=False, node_label_name = "provider_name"):
    cursor = get_new_cursor()

    cursor.execute("drop table if exists npi_to_export_to_graph;")
    cursor.execute("create table npi_to_export_to_graph (npi char(10),node_type char(1));")

    # Get NPI from each side of the relationship
    query_first_part = """select distinct npi from %s rt1 join %s tnd1 on rt1.%s = tnd1.npi where %s""" % (referral_table_name,npi_detail_table_name,field_name_from_relationship, where_criteria)
    query_second_part = """select distinct npi from %s rt2 join %s tnd2 on rt2.%s = tnd2.npi where %s""" % (referral_table_name,npi_detail_table_name,field_name_to_relationship, where_criteria)
    query_to_execute = "insert into npi_to_export_to_graph (npi,node_type)select t.*,'C' from (\n%s\nunion\n%s)\nt;" % (query_first_part, query_second_part)

    logger(query_to_execute)
    cursor.execute(query_to_execute)

    query_to_execute = "select * from npi_to_export_to_graph neg join %s tnd on tnd.npi = neg.npi" % npi_detail_table_name
    logger(query_to_execute)

    logger("Adding indices")
    cursor.execute("create unique index idx_primary_npi_graph on npi_to_export_to_graph(npi);")

    logger("Populating core nodes")
    cursor.execute(query_to_execute)
    ProviderGraph = nx.DiGraph()
    ProviderGraph = add_nodes_to_graph(cursor, ProviderGraph, "core", label_name = node_label_name)

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

    query_to_execute = """select * from npi_to_export_to_graph neg join %s tnd on tnd.npi = neg.npi where
    neg.node_type = 'L'""" % npi_detail_table_name
    logger(query_to_execute)
    cursor.execute(query_to_execute)
    ProviderGraph = add_nodes_to_graph(cursor, ProviderGraph, "leaf", label_name=node_label_name)

    logger("Populating edges")

    query_first_part_edges = """select rt1.%s,rt1.%s, rt1.%s,
  neg1.node_type as to_node_type, negf.node_type as from_node_type
   from %s rt1 join npi_to_export_to_graph neg1 on rt1.%s = neg1.npi
       join npi_to_export_to_graph negf on negf.npi = rt1.%s
  where neg1.node_type = 'C'""" % (field_name_to_relationship, field_name_from_relationship, FIELD_NAME_WEIGHT, referral_table_name, field_name_to_relationship, field_name_from_relationship)

    query_second_part_edges = """select rt2.%s, rt2.%s, rt2.%s,
  negt.node_type as to_node_type, neg2.node_type as from_node_type
   from %s rt2 join npi_to_export_to_graph neg2 on rt2.%s = neg2.npi
       join npi_to_export_to_graph negt on negt.npi = rt2.%s
  where neg2.node_type = 'C'""" % (field_name_to_relationship, field_name_from_relationship, FIELD_NAME_WEIGHT, referral_table_name, field_name_from_relationship, field_name_to_relationship)

    query_to_execute = "%s\nunion\n%s" % (query_first_part_edges, query_second_part_edges)
    #TODO: Remove inline
    logger(query_to_execute)
    cursor.execute(query_to_execute)
    ProviderGraph = add_edges_to_graph(cursor, ProviderGraph)

    query_to_execute = """select rt3.%s, rt3.%s, rt3.%s,
    negt3.node_type as to_node_type, negf3.node_type as from_node_type
  from %s rt3 join npi_to_export_to_graph negt3 on rt3.%s = negt3.npi
  join npi_to_export_to_graph negf3 on rt3.%s = negf3.npi
  where negt3.node_type = 'L' and negf3.node_type = 'L'
  ;""" % (field_name_to_relationship, field_name_from_relationship, FIELD_NAME_WEIGHT, referral_table_name, field_name_to_relationship, field_name_from_relationship)

    if add_leaf_to_leaf_edges: # Danger is that there are too many leaves
        logger("Add leafing edges")
        logger(query_to_execute)
        cursor.execute(query_to_execute)

    logger("Writing GraphML file")
    nx.write_graphml(ProviderGraph, file_name_prefix + "provider_graph.graphml")

if __name__ == "__main__":
    main("zip like '11215%' or zip like '11212%'", file_name_prefix="brooklyn_sample")
