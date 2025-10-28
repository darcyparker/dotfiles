#!/usr/bin/env bash
for file in *.jpg *.JPG; do
  # Check if the file exists (handles the case where no files match the glob)
  if [ -f "$file" ]; then
    echo "Processing: $file"
    exiftool -all= -overwrite_original "$file"
  fi
done
