__author__ = 'janos'

import sys
import re

def sub_re(match_re, sub_string):
    return match_re.string[:match_re.start(1)] + sub_string + match_re.string[match_re.end(1):]


def main(database_name, csv_file_name, set_identifier, template_name="template_create_provider_graph.sql"):
    re_csv_path = re.compile(r"^.+(/path/to/datafile/referral\.csv).+$")
    re_db_name = re.compile(r"^.+(PROVIDER_GRAPH_DATABASE_NAME).+$")
    re_set_indicator = re.compile(r"^.+(SET_INDICATOR).+$")
    sql_string = ""
    with open(template_name, "r") as f:
        for line in f:
            match_re_csv = re_csv_path.match(line)
            match_re_db_name = re_db_name.match(line)
            match_re_set_indicator = re_set_indicator.match(line)
            if match_re_csv:
                sql_string += sub_re(match_re_csv, csv_file_name)
            elif match_re_db_name:
                sql_string += sub_re(match_re_db_name, database_name)
            elif match_re_set_indicator:
                sql_string += sub_re(match_re_set_indicator, database_name)
            else:
                sql_string += line

    with open(set_identifier + ".provider_load.sql","w") as fw:
        fw.write(sql_string)

    print(sql_string)


if __name__ == "__main__":
    if len(sys.argv) == 1:
        main("provider_graph","/tmp/referral.2011.csv","medicare.2011")
    else:
        sys.argv(sys.argv[1], sys.argv[2], sys.argv[3])