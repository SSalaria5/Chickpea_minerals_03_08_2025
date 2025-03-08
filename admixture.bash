#!/usr/bin/env bash

# Path to your sorted PLINK file (without extension)
PLINK_FILE="plink_sorted"  # Update to match your PLINK base file name

# Loop through multiple K values (from 1 to 11)
for K in {1..11}
do
    echo "Running admixture for K=$K"
    # Run admixture with 5-fold cross-validation and 16 cores
    /project/dthavar/dilthavar/software/admixture ${PLINK_FILE}.bed $K -j16 --cv=5 | tee log${K}.out
done

