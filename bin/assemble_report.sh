#!/bin/bash


if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

input_dir="$1"

required_files=("country_dist.html" "hours_dist.html" "username_dist.html")
for file in "${required_files[@]}"; do
  if [ ! -f "$input_dir/$file" ]; then
    echo "Error: $file not found in $input_dir"
    exit 1
  fi
done

temp_file=$(mktemp)
cat "$input_dir/country_dist.html" "$input_dir/hours_dist.html" "$input_dir/username_dist.html" > "$temp_file"


./bin/wrap_contents.sh "$temp_file" "summary_plots" "$input_dir/failed_login_summary.html"


if [ ! -f "$input_dir/failed_login_summary.html" ]; then
  echo "Failed to create failed_login_summary.html."
  rm "$temp_file"
  exit 1
fi

rm "$temp_file"

echo "Report generated successfully: $input_dir/failed_login_summary.html"