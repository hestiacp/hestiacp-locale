#!/bin/bash 

languages=$(ls -d "./src/*/" | awk -F'/' '{print $(NF-1)}')
for lang in $languages; do
  echo "[ * ] Update $lang "
  msgfmt "./src/$lang/LC_MESSAGES/hestiacp.po" -o "./build/$lang/LC_MESSAGES/hestiacp.mo"
done