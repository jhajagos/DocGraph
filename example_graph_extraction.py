__author__ = 'janos'

from extract_providers_to_graphml import *

def main():
    extract_provider_network("state = 'HI'", file_name_prefix="hi_")
    extract_provider_network("zip like '11215%' or zip like '11212%'", file_name_prefix="brooklyn_sample")
    extract_provider_network("city like 'Brooklyn%' and state = 'NY'", add_leaf_nodes=False, file_name_prefix="brooklyn_core")
    extract_provider_network("npi in ('1801180138','1033149372','1679795181','109522833')", add_leaf_to_leaf_edges=False,file_name_prefix="fraud_case")
    main("npi='1275534935'", add_leaf_nodes=True, add_leaf_to_leaf_edges=True, file_name_prefix="chiro_investigation")


if __name__ == "__main__":
    main()