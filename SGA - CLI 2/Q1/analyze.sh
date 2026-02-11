
#!/bin/bash


# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi

path=$1

# Check if the argument is a file
if [ -f "$path" ]; then
    echo "File analysis:"
    echo "Lines: $(wc -l < "$path")"
    echo "Words: $(wc -w < "$path")"
    echo "Characters: $(wc -c < "$path")"

# Check if the argument is a directory
elif [ -d "$path" ]; then
    echo "Directory analysis:"
    echo "Total files: $(ls -1 "$path" | wc -l)"
    echo "Text files (.txt): $(ls "$path"/*.txt 2>/dev/null | wc -l)"

# Path does not exist
else
    echo "Error: Path does not exist."
    exit 1
fi
