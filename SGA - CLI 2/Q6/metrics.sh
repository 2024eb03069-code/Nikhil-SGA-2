#!/bin/bash

# Check if input.txt exists
if [ ! -f input.txt ]; then
    echo "Error: input.txt not found!"
    exit 1
fi

# Convert file to one word per line, remove punctuation
words=$(tr -s '[:space:]' '\n' < input.txt | tr -d '[:punct:]')

# Longest word
longest=$(echo "$words" | awk '{ print length, $0 }' | sort -nr | head -1 | cut -d' ' -f2-)
echo "Longest word: $longest"

# Shortest word
shortest=$(echo "$words" | awk '{ print length, $0 }' | sort -n | head -1 | cut -d' ' -f2-)
echo "Shortest word: $shortest"

# Average word length
total_chars=$(echo "$words" | awk '{sum += length($0)} END {print sum}')
total_words=$(echo "$words" | wc -l)
avg=$(echo "scale=2; $total_chars / $total_words" | bc)
echo "Average word length: $avg"

# Unique words count
unique=$(echo "$words" | tr '[:upper:]' '[:lower:]' | sort | uniq | wc -l)
echo "Total unique words: $unique"
