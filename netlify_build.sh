#!/bin/sh

git clone https://github.com/kristus123/bloggy.git

rm -r bloggy/content/blog/

cp -r blog/ bloggy/content/

cd bloggy
npm run generate
cd ..

cat <<EOL > bloggy/dist/_redirects
line 1 content
line 2 content
line 3 content
EOL
