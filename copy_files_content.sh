// ./copy_files_content.sh
#!/bin/bash

# Function to recursively find files and append their content to the output file
append_files_content() {
    local directory="$1"
    local output_file="$2"

    # Loop through files and directories
    for file in "$directory"/*; do
        # Ignore specific files and directories
        if [[ "$file" == *README.md || "$file" == *node_modules* || "$file" == *package-lock.json || "$file" == *package.json || "$file" == *dist/assets/index-BIv_I74q.js || "$file" == *dist/assets/index-HupOsEJb.css || "$file" == *dist/favicon.ico ]]; then
            continue
        fi

        # If it's a directory, recursively call this function
        if [ -d "$file" ]; then
            # Append content of files in the directory
            append_files_content "$file" "$output_file"
        elif [ -f "$file" ]; then
            # If it's a file, append its content to the output file
            echo -e "\n\n// $file" >> "$output_file"
            cat "$file" >> "$output_file"
        fi
    done
}

# Main script

# Output file name
output_file="output.txt"

# Clear output file if it exists
> "$output_file"

# Add content of files in the current directory and its immediate subdirectories
append_files_content "." "$output_file"

echo "Text files content copied to $output_file"
