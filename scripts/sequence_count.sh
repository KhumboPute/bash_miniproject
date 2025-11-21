#!/usr/bin/bash

cd ../Data/ # Move from scripts directory to the data directory
grep -c ">" IP-004_S38_L001_scaffolds.fasta > ../results/sequence_count.txt # Counting the number of sequences and saving in results directory
