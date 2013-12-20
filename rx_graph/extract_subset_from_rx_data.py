__author__ = 'janos'

import csv
import pyodbc as odbc
import hashlib
import random
import sys


def main(restriction, file_name_prefix):
    cursor = get_new_cursor()
    provider_dict = {}

    query_string = query(restriction)
    logger(query_string)
    cursor.execute(query_string)
    logger("Writing results")

    file_name = file_name_prefix + "medicare_rx_2011.csv"

    with open(file_name, "wb") as fw:
        csv_writer = csv.writer(fw)
        i = 0
        salting_phrase = get_salting_phrase(50)
        logger("Salting phrase is '%s'" % salting_phrase)

        for row in cursor:
            if i == 0:
                column_names = [desc[0] for desc in row.cursor_description]
                column_names += ["encrypted_npi"]
                csv_writer.writerow(column_names)
            npi = row[1]
            if npi in provider_dict:
                provider_dict[npi] += 1
            else:
                provider_dict[npi] = 1
            row_to_write = list(row)
            row_to_write += [encrypt_with_salted_phrase(salting_phrase, npi)]
            csv_writer.writerow(row_to_write)

            if i % 100 == 0 and i > 0:
                logger("Wrote %s row" % i)
            i += 1
    logger("Extract includes %s providers" % len(provider_dict))

def get_salting_phrase(phrase_length=50):
    phrase = ""
    for i in range(phrase_length):
        phrase += random_chr()
    return phrase


def random_chr():
    return chr(random.randint(32,126))


def encrypt_with_salted_phrase(salting_phrase, string_to_encrypt):
    return hashlib.sha1(salting_phrase + str(string_to_encrypt)).hexdigest()

def logger(string_to_log=""):
    print(string_to_log)

def get_new_cursor(dsn_name="referral"):
    logger("Opening connection %s" % dsn_name)
    connection = odbc.connect("DSN=%s" % dsn_name, autocommit=True)
    return connection.cursor()


def query(restriction = None):
    query_string = """select rrn.*, nddwa.synthetic_rxcui, nddwa.synthetic_label, nddwa.compact_counter, nddwa.synthetic_rxcui_key,
    nddwa.sbd_rxcui, nddwa.sbd_rxaui, nddwa.semantic_branded_name, nddwa.rxn_available_string, nddwa.rxterm_form,
    nddwa.rxn_human_drug, nddwa.SAB, nddwa.TTY, nddwa.SUPPRESS, nddwa.bn_rxaui, nddwa.bn_rxcui, nddwa.brand_name,
    nddwa.dose_form_rxaui, nddwa.dose_form_rxcui, nddwa.dose_form, nddwa.scd_rxaui, nddwa.scd_rxcui, nddwa.semantic_clinical_drug,
    nddwa.number_of_ingredients, nddwa.scdc_rxcui, nddwa.scdc_rxaui, nddwa.semantic_clinical_drug_component, nddwa.generic_name_rxcui,
    nddwa.generic_name_rxaui, nddwa.generic_name, nddwa.dose_form_group_counter, nddwa.synthetic_dfg_rxcui, nddwa.synthetic_dfg_rxaui,
    nddwa.synthetic_dose_form_group, nddwa.counter, nddwa.synthetic_atc5, nddwa.synthetic_atc5_name,
    nspt.*
  from rx_graph.rx_graph_ndc9 rrn
    left outer join rxnorm_prescribe.ndc9_drug_details_with_atc nddwa on (rrn.ndc9 = nddwa.ndc9)
    join referral.npi_summary_primary_taxonomy nspt on nspt.npi = rrn.npi"""

    if restriction is not None:
        query_string_with_restriction = query_string + " where " + restriction

    return query_string_with_restriction




if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])