#!/bin/bash

# Check if both directories exist
if [ ! -d "dirA" ] || [ ! -d "dirB" ]; then
    echo "Error: dirA or dirB does not exist!"
    exit 1
fi

echo "Files only in dirA:"
comm -23 <(ls dirA | sort) <(ls dirB | sort)

echo ""
echo "Files only in dirB:"
comm -13 <(ls dirA | sort) <(ls dirB | sort)

echo ""
echo "Files with same name and content check:"
for file in $(ls dirA); do
    if [ -f "dirB/$file" ]; then
        if cmp -s "dirA/$file" "dirB/$file"; then
            echo "$file: SAME content"
        else
            echo "$file: DIFFERENT content"
        fi
    fi
done
