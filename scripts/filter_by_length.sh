#!/usr/bin/bash


cd ../Data/ # Changing directory to location where data is stored

minimum_length="$1" # Creating the variable to hold the first argument from the command line

length_list=$(grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'_' -f4) # Creating a list of sequence lengths from the data

# For loop iteration through the length list
# An if statement checking if the length meet the minimum length

for length in $length_list; do
	if [ "$length" -ge "$minimum_length" ]; then
		grep "length_$length" IP-004_S38_L001_scaffolds.fasta >> ../results/filtered_sequences.txt 
	fi
done

# Counting the number of generated sequences
sequence_count=$(cat ../results/filtered_sequences.txt | wc -l)

echo "Found $sequence_count sequences with >= $minimum_length bases"
