#!/bin/bash


folders=$(find blog -mindepth 1 -maxdepth 1 -type d)

# Initialize an empty JSON array
json_array="["

# Iterate over each folder and append to the JSON array
for folder in $folders; do
    name=$(basename "$folder")
    path="$folder"
    json_array+="{\"name\":\"$name\", \"path\":\"$path\"},"
done

# Close the JSON array
json_array+="]"

# Display the generated JSON (for debugging)
echo "$json_array"

git clone https://github.com/kristus123/bloggy.git
rm -r bloggy/content/blog/
cp -r blog/ bloggy/content/

input_file="bloggy/pages/content/index.vue"
sed -i "s|REPLACE_WITH_FOLDER_INFO|$json_array|" "$input_file"


cd bloggy
npm install
export NODE_OPTIONS=--openssl-legacy-provider
npm run generate

cat <<EOL > dist/_redirects
/ /content 301
EOL

cd ..

