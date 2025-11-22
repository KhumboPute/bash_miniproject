# Bash Mini-Project: Genomic Data Analysis

## Student Information
**Name**: KHUMBO PUTE
**Student ID**: MB300-0004/2024
**Course**: PUB 3127 - Computing for Biologists
**Date Started**: 11/20/2025
**Date Completed**: 11/22/2025

---

## Project Description
This project analyzes genomic scaffold data and protein database records using bash command-line tools. The analysis includes:
- Counting and filtering DNA sequences from FASTA files
- Identifying high-quality scaffolds based on length and coverage criteria
- Extracting and analyzing protein information from database files
- Automating bioinformatics workflows with bash scripts

---

## Repository Contents

```
└── bash_miniproject
    ├── ASSIGNMENT.md
    ├── Data
    │   ├── IP-004_S38_L001_scaffolds.fasta
    │   └── humchrx.txt
    ├── README.md
    ├── results
    │   ├── analysis_summary.txt
    │   ├── filtered_sequences.txt
    │   ├── gene_names_sorted.txt
    │   ├── high_quality_scaffolds.txt
    │   ├── longest_sequence.txt
    │   ├── protein_count.txt
    │   ├── protein_search_results.txt
    │   ├── sequence_count.txt
    │   └── sequence_ids.txt
    └── scripts
        ├── extract_genes.sh
        ├── extract_headers.sh
        ├── filter_by_length.sh
        ├── high_quality_scaffolds.sh
        ├── longest_sequence.sh
        ├── protein_entry_count.sh
        ├── run_analysis.sh
        ├── search_proteins.sh
        └── sequence_count.sh
```
---

## Requirements

### Software
- Bash shell (Linux, macOS, or WSL on Windows)
- Git and GitHub account
- Basic Unix tools: `grep`, `cut`, `sort`, `uniq`, `wc`, `head`, `tail`
- Text editor (nano, vim, VS Code, etc.)

### Data Files
The `Data/` directory contains:
1. **IP-004_S38_L001_scaffolds.fasta** (~10 MB) - Genomic scaffolds from sequencing assembly
2. **humchrx.txt** (~152 KB) - UniProt protein entries for human chromosome X

---

## Usage Instructions

### Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/KhumboPute/bash_miniproject.git
   cd bash_miniproject
   ```

2. Verify data files are present:
   ```bash
   ls -lh Data/
   ```

### Running the Scripts

#### Script 1: Extract Headers
```bash
./scripts/extract_headers.sh
```
**Purpose**: Extracts all sequence headers from the FASTA file
**Output**: `results/sequence_ids.txt` - List of NODE identifiers

#### Script 2: Find Longest Sequence
```bash
./scripts/longest_sequence.sh
```
**Purpose**: Identifies the scaffold with the longest sequence
**Output**: `results/longest_sequence.txt` - Details of the longest scaffold

#### Script 3: Filter by Length
```bash
./scripts/filter_by_length.sh 5000
```
**Purpose**: Filters scaffolds with length >= specified minimum
**Output**: `results/filtered_sequences.txt` - Filtered scaffold headers

#### Script 4: High-Quality Scaffolds
```bash
./scripts/high_quality_scaffolds.sh
```
**Purpose**: Identifies scaffolds meeting both length and coverage criteria
**Output**: `results/high_quality_scaffolds.txt` - High-quality scaffold list

#### Script 5: Extract Gene Names
```bash
./scripts/extract_genes.sh
```
**Purpose**: Extracts unique gene names from protein database
**Output**: `results/gene_names_sorted.txt` - Sorted unique gene names

#### Script 6: Search Proteins
```bash
./scripts/search_proteins.sh "kinase"
```
**Purpose**: Searches for proteins matching a keyword
**Output**: `results/protein_search_results.txt` - Matching protein entries

#### Script 7: Protein entry count
```bash
./scripts/protein_entry_count.sh
```
**Purpose**:Count the number of proteins from the protein database
**Output**:`results/protein_count.txt`- Number of proteins in the database

#### Script 8: Sequence Count
```bash
./scripts/sequence_count.sh
```
**Purpose**:Count the number of sequences in the FASTA file
**Output**:`results/sequence_count.txt`- Number of DNA sequences in the FASTA file


### Running the Master Script
```bash
./scripts/run_analysis.sh ./Data/
```
**Purpose**: Runs all analyses in sequence and generates a comprehensive summary
**Output**:
- All result files from individual scripts
- `results/analysis_summary.txt` - Summary of all analyses with counts and timestamp

---

## Analysis Results Summary

### FASTA File Analysis
- **Total number of sequences**: 35079
- **Longest sequence**: NODE_1
- **Number of sequences with length >= 5000**: 283
- **Number of high-quality scaffolds** (length >= 10000, coverage >= 5.0): 33

### Protein Database Analysis
- **Total protein entries**: 890
- **Number of unique genes**: 888
- **Example protein search result** (e.g., for "kinase"): 38

### Key Findings
- How fast the code completed my intended task, the code took too long to write but it executed in seconds
- How to read through complicated information to extract what you want
- Breaking down huge problems into smaller ones to accomplish the task
---

## Scripts Description

| Script Name | Purpose | Key Commands Used |
|-------------|---------|-------------------|
| `extract_headers.sh` | Extract NODE identifiers from FASTA file | grep, cut |
| `longest_sequence.sh` | Find the scaffold with the longest sequence | grep, sort, head |
| `filter_by_length.sh` | Filter scaffolds by minimum length | grep, cut, for,if |
| `high_quality_scaffolds.sh` | Identify high-quality scaffolds | grep, cut, for,if |
| `extract_genes.sh` | Extract unique gene names from protein file | cut, sort, uniq |
| `search_proteins.sh` | Search for proteins by keyword | grep |
| `run_analysis.sh` | Master script that runs all analyses | [calls all other scripts] |

---

## Challenges and Solutions

**Challenge 1**: I did'nt know the type of backup file for the editor I used (Nano)
**Solution**: I went online and found out that if you enable the back up option when opening nano using a flag -f, it creates a backup file starting with a .filename~, so I added it in the gitignore file.

**Challenge 2**: After pushing my repository, git online wasn't showing the folders for results and scripts
**Solution**: I went on google, apparently its a problem if the directories are empty, so the solution suggested was to create a .gitkeep file in each of the folders and I also used the flag -f to override the gitignore for the results directory.

**Challenge 3**: Making comparisons using floats which is different from integers
**Solution**: I googled the syntax for working with float when dealing with coverage

**Challenge**: Handling errors using if statements
**Solution**: I googled the structure then replaced the variables with  what I wanted
---

## What I Learned
- New bash commands or concepts you learned: Using command line arguments in scripts
- How command-line tools can be useful for bioinformatics : Command line can help in dealing with large files
- Any insights about version control with Git : I can make changes in my files while keeping the originals
- How this project relates to your research interests: Probably I will deal with files from databases

---

## References

- [Introduction to Linux Lectures](https://github.com/amelgh/Introduction_To_Linux/tree/master/Lectures)
- Course materials: PUB 3127 - Computing for Biologists
- Bash manual: `man bash`
- FASTA format: [https://en.wikipedia.org/wiki/FASTA_format](https://en.wikipedia.org/wiki/FASTA_format)

---

## License
This project is for educational purposes as part of PUB 3127 coursework.

---

## Acknowledgments
- **Instructor**: Dr. Kibet
- **Institution**: Pan African University of Science, Technology and Innovation
- Data sources: [Sequencing data and UniProt database]
