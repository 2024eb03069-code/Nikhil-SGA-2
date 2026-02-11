#!/bin/bash

INPUT="words.txt"

# Check if file exists
if [ ! -f "$INPUT" ]; then
    echo "Error: $INPUT not found."
    exit 1
fi

# Clean words: put one per line and remove punctuation
words=$(tr -sc '[:alnum:]' '\n' < "$INPUT")

# 1. Words containing ONLY vowels
# Pattern: Start of line, one or more vowels, end of line
echo "$words" | grep -i -E "^[aeiou]+$" > vowels.txt

# 2. Words containing ONLY consonants
# Pattern: Start of line, one or more non-vowel letters, end of line
echo "$words" | grep -i -E "^[bcdfghjklmnpqrstvwxyz]+$" > consonants.txt

# 3. Mixed words starting with a consonant
# Pattern: Starts with a consonant, contains at least one vowel later
echo "$words" | grep -i -E "^[bcdfghjklmnpqrstvwxyz].*[aeiou].*" > mixed.txt

echo "Analysis complete."
echo "Vowels only: $(cat vowels.txt | xargs)"
echo "Consonants only: $(cat consonants.txt | xargs)"
echo "Mixed (starts with consonant): $(cat mixed.txt | xargs)"
