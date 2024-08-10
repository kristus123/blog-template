#!/bin/bash


blog_categories="["

folders=$(find blog -mindepth 1 -maxdepth 1 -type d)
for folder in $folders; do
    name=$(basename "$folder")
    path="$folder"
    blog_categories+="{\"name\":\"$name\", \"path\":\"$path\"},"
done

blog_categories+="]"

echo "$blog_categories"

git clone https://github.com/kristus123/bloggy.git

rm -r bloggy/content/blog/
cp -r blog/ bloggy/content/

rm -r bloggy/static/public/
cp -r public/ bloggy/static/

# Delete the 'home button'
sed -i '/<center>/,/<\/center>/{//!d;}' bloggy/layouts/cv.vue


input_file="bloggy/pages/content/index.vue"
sed -i "s|REPLACE_WITH_FOLDER_INFO|$blog_categories|" "$input_file"


cd bloggy
npm install
export NODE_OPTIONS=--openssl-legacy-provider
npm run generate

