__author__ = 'janos'

from extract_providers_to_graphml import *

def main():
    extract_provider_network("state = 'HI'", file_name_prefix="hi_")
    extract_provider_network("zip like '11215%' or zip like '11212%'", file_name_prefix="brooklyn_sample")
    extract_provider_network("city like 'Brooklyn%' and state = 'NY'", add_leaf_nodes=False, file_name_prefix="brooklyn_core")



if __name__ == "__main__":
    main()