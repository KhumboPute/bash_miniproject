#!/usr/bin/bash

cd ../Data/

search_word=$1

cat humchrx.txt | grep -i "$search_word" | cut -c33-45,63- > ../results/protein_search_results.txt # Using cut and utilizing characters instead of delimiters

entry_count=$(cat humchrx.txt | grep -i "$search_word" | cut -c33-45,63- | wc -l) # Counting the protein entries

echo "There are $entry_count hits"
