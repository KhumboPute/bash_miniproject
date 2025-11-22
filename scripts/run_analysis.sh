#!/usr/bin/bash

# Written by Khumbo Pute, 11/22/2025
# This is a master script

# For exploring FASTA files, sequence filtering, and protein database analysis
# The script takes path to the data directory as an argument

# Checking if an argument was passed
if [ $# -eq 0 ]; then # checking if atleast one argument was passed
	echo "Error: No directory provided"
	echo "Syntax: ./analysis.sh /PATH/TO/DIRECTORY"
	exit 1
fi


# A variable the stores the first command line  argumenAccepts the data directory as a command-line argumentAccepts the data directory as a command-line argumentt as the PATH to data directory
# To run the script > run_analysis.sh /PATH/To/DATA
data_directory="$1"

# Checking if the argument passed is a directory
if [ ! -d "$data_directory" ]; then # Checking if the directory exists
	echo "Error: Not a valid directory"
	exit 1
fi

# Changing to the data directory
cd $data_directory

# Checking if the required input files are in the directory
required_files=("IP-004_S38_L001_scaffolds.fasta" "humchrx.txt") # creating the list of required file
missing_files=() # an empty variable to store the missing file names

for file in "${required_files[@]}"; do # Checking if the file is available in the directory
	[ ! -f "$data_directory/$file" ] && missing_file+=("$file") # If a file is missing, it's added to the missing list
done

if [ ${#missing_file[@]} -gt 0 ]; then # Checking if there are missing variable 
	echo "Error: Missing file: ${missing_file[*]}"
	exit 1
fi

# Creating the results directtory in the same directory with the data to send all the output
mkdir ../results
echo "results directory created..."

# FASTA exploration
# This section will count the number of sequences, extract sequence headers, and find the longest sequence
# The output files will be sent to the results directory

# Counting the number of sequences
grep -c ">" IP-004_S38_L001_scaffolds.fasta > ../results/sequence_count.txt
sequence_count=$(grep -c ">" IP-004_S38_L001_scaffolds.fasta)
echo "Counting number of sequences in the FASTA file: DONE..."
echo "There are $sequence_count sequences in the FASTA file"

# Extracting sequence headers
grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f1,2 > ../results/sequence_ids.txt 
id_number=$(grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f1,2 | wc -l)
echo "Extracted $id_number  sequence identifiers"
echo "Extracting sequence identifiers from the FASTA file: DONE..."

# Finding the longest sequence from the FASTA file
longest_sequence=$(grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'_' -f4 | sort -n | tail -1) # Getting the highest leng>

seq_length=$(grep "length_$longest_sequence" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f4) # isolating t>
coverage=$(grep "length_$longest_sequence" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f6) # isolating cov>
sequence_id=$(grep "length_$longest_sequence" IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f1,2) # isolatin>

touch ../results/longest_sequence.txt # Creating the output file
echo "Longest sequence: $sequence_id" > ../results/longest_sequence.txt
echo "Length: $seq_length" >> ../results/longest_sequence.txt
echo "coverage: $coverage" >> ../results/longest_sequence.txt
echo "Finding the longest sequence in the FASTA file: DONE..."

# Sequence filtering and statistics

# Filtering the sequences by length
echo "Starting sequence filtering and statistics"
minimum_length=5000  # Creating the variable to hold the minimum base length

length_list=$(grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'_' -f4) # Creating a list of sequence lengths from the data

# For loop iteration through the length list
# An if statement checking if the length meet the minimum length

for length in $length_list; do
        if [ "$length" -ge "$minimum_length" ]; then
                grep "length_$length" IP-004_S38_L001_scaffolds.fasta >> ../results/filtered_sequences.txt
        fi
done
echo "Filtering of sequences by minimum length of 5000: DONE..."
 
# Counting the number of generated sequences
sequence_count2=$(cat ../results/filtered_sequences.txt | wc -l)

echo "Found $sequence_count2 sequences with >= $minimum_length bases"

# Selecting high quality scaffolds based on length and coverage
minimum_length2=10000
minimum_coverage=5.0


length_list=$(grep ">" IP-004_S38_L001_scaffolds.fasta | cut -d'_' -f4) # Generating a list of the sequence lengths

for length in $length_list; do # Using a for loop to iterate over the length list
        if [ "$length" -ge "$minimum_length2" ]; then # comparisons on integers
                cov=$(grep "length_$length" IP-004_S38_L001_scaffolds.fasta | cut -d'_' -f6)
                if [ -n "$cov" ] && [ $(echo "$cov >= $minimum_coverage" | bc -l) -eq 1 ]; then # comparisons on float are >
                        grep "length_$length" IP-004_S38_L001_scaffolds.fasta >> ../results/high_quality_scaffolds.txt
                fi

        fi
done

sequence_count3=$(cat ../results/high_quality_scaffolds.txt | wc -l)
echo "Selecting high quality scaffold sequences based on length and coverage: DONE..."
echo "Found $sequence_count3 sequences high quality scaffolds"

# Protein Database Analysis
# Protein entry count
entry_count1=$(cat humchrx.txt | cut -d' ' -f1 | tail -898 | head -890 |wc -l) # Counting the number of entries after trimmi>
echo "Counting protein entries from the database: DONE..."
echo "There are $entry_count1 protein entries" > ../results/protein_count.txt

# Extracting genes from the database
cat humchrx.txt | cut -d' ' -f1 | tail -898 | head -890 |sort -u > ../results/gene_names_sorted.txt # Sorting alphabeticall>
echo "Extracting genes from the database: DONE..."

# Searching for specific proteins
cat humchrx.txt | grep -i "kinase" | cut -c33-45,63- > ../results/protein_search_results.txt # Using cut and utilizing char>
echo "Searching for kinase proteins among the entries: DONE..."
entry_count2=$(cat humchrx.txt | grep -i "kinase" | cut -c33-45,63- | wc -l) # Counting the protein entries

echo "There are $entry_count2 kinase hits"

# Creating analysis summary
# The summary for total sequences in FASTA file
# Number of high quality scaffolds among the sequences
# Total protein entries
# Date and time the analysis was done

touch ../results/analysis_summary.txt
echo "The total number of sequences in the FASTA file is: $sequence_count" > ../results/analysis_summary.txt
echo "The number of high quality scaffolds among the sequences is: $sequence_count3" >> ../results/analysis_summary.txt
echo "The number of protein entries in the database is: $entry_count1" >> ../results/analysis_summary.txt
date >> ../results/analysis_summary.txt

echo "DONE"

