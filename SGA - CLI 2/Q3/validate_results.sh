#!/bin/bash

# Check if marks.txt exists
if [ ! -f marks.txt ]; then
    echo "Error: marks.txt not found!"
    exit 1
fi

# Counters
one_fail=0
all_pass=0

# Loop through each line of marks.txt
while IFS=',' read -r roll name m1 m2 m3
do
    # Remove leading/trailing spaces
    roll=$(echo $roll | xargs)
    name=$(echo $name | xargs)
    m1=$(echo $m1 | xargs)
    m2=$(echo $m2 | xargs)
    m3=$(echo $m3 | xargs)

    fail_count=0

    # Check each mark
    for mark in $m1 $m2 $m3
    do
        if [ "$mark" -lt 33 ]; then
            fail_count=$((fail_count+1))
        fi
    done

    # Categorize student
    if [ $fail_count -eq 1 ]; then
        echo "$roll, $name failed in exactly one subject"
        one_fail=$((one_fail+1))
    elif [ $fail_count -eq 0 ]; then
        echo "$roll, $name passed in all subjects"
        all_pass=$((all_pass+1))
    fi

done < marks.txt

# Display counts
echo "Number of students who failed in exactly one subject: $one_fail"
echo "Number of students who passed in all subjects: $all_pass"
