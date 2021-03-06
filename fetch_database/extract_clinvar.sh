chr="$1"
sta="$2"
end="$3"
gene="$4"

if [ "$#" -eq 5 ]; then
    clinvar="$5"
fi

if [ "$#" -eq 6 ]; then
    clinvar="$6"
    clinvar_loc="$5"
fi

# fecth clinvar database file
# clinvar_20180429
{
    wget ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/${clinvar}.vcf.gz
    wget ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/${clinvar}.vcf.gz.tbi
}||{
    wget ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/${clinvar_loc}/${clinvar}.vcf.gz
    wget ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/${clinvar_loc}/${clinvar}.vcf.gz.tbi
#    echo "the input for clivar version is not updated, go to the website ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/"
}||{
    echo "the input for clivar version is not correct, go to the website ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/ or ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/archive_2.0/2018" 
}
# extract variants based on their locations
tabix ${clinvar}.vcf.gz ${chr}:${sta}-${end} > ../data/clinvar_${chr}_${sta}-${end}_${gene}.vcf
Rscript extract_patho_annotation.R ../data/clinvar_${chr}_${sta}-${end}_${gene}.vcf ../data/clinvar_${chr}_${sta}-${end}_${gene}_info.table

