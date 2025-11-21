#!/usr/bin/bash

cd ../Data/

longest_sequence=$(grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'_' -f4 | sort -n | tail -1) # Getting the highest length

seq_length=$(grep "length_$longest_sequence" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f4) # isolating the length into a variable
coverage=$(grep "length_$longest_sequence" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f6) # isolating coverage into a variable
sequence_id=$(grep "length_$longest_sequence" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f1,2) # isolating sequence id into a variable

touch ../results/longest_sequence.txt 
echo "Longest sequence: $sequence_id" > ../results/longest_sequence.txt
echo "Length: $seq_length" >> ../results/longest_sequence.txt
echo "coverage: $coverage" >> ../results/longest_sequence.txt
