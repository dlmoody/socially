#!/bin/bash



mkdir lib


mkdir public


mkdir -p server/startup
echo "Everything in this folder will run on the server."> server/readme.md

echo "Put things you want to run first in here."> server/startup/readme.md

mkdir -p client/lib
mkdir model

touch model/readme.md
echo "This folder is loaded on client and server.
put your collections here" > model/readme.md

