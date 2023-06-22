#!/bin/bash 

cd './src/'
for lang in */; do
  [ -L "${lang%/}" ] && continue
  echo "[ * ] Update $lang "
  mkdir -p "../build/${lang%/}/LC_MESSAGES/"
  msgfmt "./${lang%/}/LC_MESSAGES/hestiacp.po" -o "../build/${lang%/}/LC_MESSAGES/hestiacp.mo"
done