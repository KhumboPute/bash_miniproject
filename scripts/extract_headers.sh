#!/usr/bin/bash

cd ../Data/ # Moving to the directory which contains the data
grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f1,2 > ../results/sequence_ids.txt # Obtaining sequence ids using cut command and grep
id_number=$(grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f1,2 | wc -l)
echo "Extracted $id_number  sequence identifiers"
