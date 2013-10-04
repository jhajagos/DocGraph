__author__ = 'janos'

from extract_providers_to_graphml import *

def main():
    #extract_provider_network("state = 'HI'", file_name_prefix="hi_")
    #extract_provider_network("zip like '11215%' or zip like '11212%'", file_name_prefix="brooklyn_sample")
    #extract_provider_network("city like 'Brooklyn%' and state = 'NY'", add_leaf_nodes=False, file_name_prefix="brooklyn_core")
    extract_provider_network("city like 'Albany' and state = 'NY'", add_leaf_nodes=False, file_name_prefix="albany_core")
    extract_provider_network("city like 'Jamestown' and state = 'NY'", add_leaf_nodes=False, file_name_prefix="jamestown_core")
    extract_provider_network("city like 'Bronx' and state = 'NY'", add_leaf_nodes=False, file_name_prefix="bronx_core")
    extract_provider_network("city like 'Jamestown' and state = 'NY'", add_leaf_nodes=True, file_name_prefix="jamestown_core_and_leaf")

if __name__ == "__main__":
    main()