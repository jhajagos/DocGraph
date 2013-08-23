__author__ = 'janos'

"""
Graphson file format for Faunus

The Graphson file format for Fuanus differs in some important ways from the Graphson file format described at:
https://github.com/tinkerpop/blueprints/wiki/GraphSON-Reader-and-Writer-Library

Sample Graphson:

{"name":"saturn","type":"titan","_id":0,"_inE":[{"_label":"father","_id":12,"_outV":1}]}
{"name":"jupiter","type":"god","_id":1,"_outE":[{"_label":"lives","_id":13,"_inV":4},{"_label":"brother","_id":16,"_inV":3},{"_label":"brother","_id":14,"_inV":2},{"_label":"father","_id":12,"_inV":0}],"_inE":[{"_label":"brother","_id":17,"_outV":3},{"_label":"brother","_id":15,"_outV":2},{"_label":"father","_id":24,"_outV":7}]}

Basic rules:
    Each line describes a node and its in and out edges
    Each line is valid json object
    _id is a long integer
    name: label
    type: label

Inputs for conversion:

CSV file name describing nodes
    id field uniquely identifying
CSV file name describing edges
    source id field name
    destination id field name


In memory structures (This will limit the size of graph that can be exported):

ID field to long integer dictionary
source_id to edge data dictionary
destination_id to edge dictionary

Outline of program
    Read in the CSV file representing the edges any associated properties weights
    Keep counter of unique nodes seen
    Build edge dictionaries
    Iterate through nodes
        If there is no long integer translation than add to dict
        Build dictionary for node
        Add "_inE" []
        Add "_outE" []
    write JSON for each node
"""

import json
import os
import csv
import copy

PROTECTED_FIELD_NAMES = ["_label","_id", "_outE", "_inE"]

def logger(string_to_log):
    print(string_to_log)


def expand_file_name(file_name):
    expanded_file_name = os.path.abspath(file_name)
    return expanded_file_name


def main(csv_node_file_name, id_field_name, csv_edge_file_name, source_id_field_name, destination_id_field_name, edge_label_field_name = None,edge_label="connects", label_field_name = "Label"):
    unique_node_counter = 0
    edge_counter = 0
    node_id_to_long_dict = {}
    in_edge_dict = {}
    out_edge_dict = {}

    full_edge_file_name = expand_file_name(csv_edge_file_name)

    logger("Opening '%s' to read edges" % full_edge_file_name)
    with open(full_edge_file_name, "r") as fe:
        edge_reader = csv.DictReader(fe)

        for edge in edge_reader:
            source_id = edge[source_id_field_name]
            destination_id = edge[destination_id_field_name]

            if source_id in node_id_to_long_dict:
                source_long_id = node_id_to_long_dict[source_id]
            else:
                unique_node_counter += 1
                node_id_to_long_dict[source_id] = unique_node_counter
                source_long_id = unique_node_counter

            if destination_id in node_id_to_long_dict:
                destination_long_id = node_id_to_long_dict[destination_id]
            else:
                unique_node_counter += 1
                node_id_to_long_dict[destination_id] = unique_node_counter
                destination_long_id = unique_node_counter

            for field_name in edge:
                edge_data = {}

                if field_name in PROTECTED_FIELD_NAMES:
                    raise RuntimeError, "Field name '%s' is protected" % field_name

                if field_name not in [destination_id_field_name, source_id_field_name]:
                        edge_data[field_name] = edge[field_name]

                if edge_label_field_name is not None:
                    if edge_label_field_name == field_name:
                        edge_data["_label"] = edge[field_name]
                else:
                    edge_data["_label"] = edge_label

            edge_counter += 1
            edge_data["_id"] = edge_counter

            out_edge_data = copy.copy(edge_data)
            in_edge_data = edge_data

            out_edge_data["_inV"] = destination_long_id
            in_edge_data["_outV"] = source_long_id

            if source_long_id not in out_edge_dict:
                out_edge_dict[source_long_id] = [out_edge_data]
            else:
                out_edge_dict[source_long_id] += [out_edge_data]

            if destination_long_id not in in_edge_dict:
                in_edge_dict[destination_long_id] = [in_edge_data]
            else:
                in_edge_dict[destination_long_id] += [in_edge_data]

    full_node_file_name = expand_file_name(csv_node_file_name)

    logger("Opening '%s' to read in nodes" % full_node_file_name)
    with open(full_node_file_name, "r") as fn:
        node_reader = csv.DictReader(fn)

        output_graphson_file_name = full_node_file_name + ".graphson"
        with open(output_graphson_file_name,"w") as fj:
            nodes_read_in = 0
            for node in node_reader:
                node_data = {}
                for field_name in node:
                    if field_name in PROTECTED_FIELD_NAMES:
                        raise RuntimeError, "Field name '%s' is protected" % field_name

                    node_id = node[id_field_name]

                    if node_id not in node_id_to_long_dict:
                        unique_node_counter += 1
                        node_id_to_long_dict[node_id] = unique_node_counter
                        node_long_id = unique_node_counter
                    else:
                        node_long_id = node_id_to_long_dict[node_id]

                    if field_name not in [label_field_name]:
                        node_data[field_name] = node[field_name]
                    else:
                        node_data["_name"] = node[label_field_name]

                node_data["_id"] = node_long_id

                if node_long_id in out_edge_dict:
                    node_data["_outE"] = out_edge_dict[node_long_id]

                if node_long_id in in_edge_dict:
                    node_data["_inE"] = in_edge_dict[node_long_id]

                if nodes_read_in != 0:
                    fj.write("\n")

                json.dump(node_data,fj)

                nodes_read_in += 1

    logger("Read %s edges" % edge_counter)
    logger("Read %s nodes" % unique_node_counter)

if __name__ == "__main__":
    main("../graph_csv/bronx_core_provider_graph_nodes.csv","npi","../graph_csv/bronx_core_edge_list_with_weights.csv", "npi_from", "npi_to")
