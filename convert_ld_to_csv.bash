TMPDIR="."

# if 10 Phenotypes, second number should be 10 that is 1..10
for i in {1..9}
do
   SNP=$(head -n ${i} snps.txt | tail -n 1)

   sed -e 's/\t/,/g' -e 's/   */,/g' ${SNP}.plink.ld > ./LDcsv/${SNP}.ld.csv
done
