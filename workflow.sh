#!/bin/bash

VCF_FILE="/data-shared/vcf_examples/luscinia_vars.vcf.gz"

zcat "$VCF_FILE" | \
grep -v -e "^#" -e "INDEL" | \
awk '{print $4, $5}' | \
sed -E "s/([^ ]+) ([^,]+),(.+)/\1 \2\n\1 \3/" | \
awk '{
    ref=$1; alt=$2;
    if ((ref=="A" && alt=="G") || (ref=="G" && alt=="A") || (ref=="C" && alt=="T") || (ref=="T" && alt=="C"))
        type="transition";
    else
        type="transversion";
    print ref "\t" alt "\t" type;
}' > results/substitution_type.tsv

Rscript data-analysis.R
