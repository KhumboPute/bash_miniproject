#!/usr/bin/bash

cd ../Data/

cat humchrx.txt | grep -i "kinase" | cut -c33-45,63- > ../results/protein_search_results.txt # Using cut and utilizing characters instead of delimiters

entry_count=$(cat humchrx.txt | grep -i "kinase" | cut -c33-45,63- | wc -l) # Counting the protein entries

echo "There are $entry_count hits"
