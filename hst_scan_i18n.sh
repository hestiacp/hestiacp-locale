#!/bin/bash

echo "[ * ] Remove old hestiacp.pot and generate new one"
rm hestiacp.pot
echo "" > hestiacp.pot
find  ./hestiacp/ \( -name '*.php' -o -name '*.html' -o -name '*.sh' \) | xgettext --output=hestiacp.pot --language=PHP --join-existing -f -
OLDIFS=$IFS
IFS=$'\n'
# Scan the description string for list updates page
for string in $(awk -F'DESCR=' '/data=".+ DESCR=[^"]/ {print $2}' ./hestiacp/bin/v-list-sys-hestia-updates | cut -d\' -f2); do
	if [ -z "$(grep "\"$string\"" hestiacp.pot)" ]; then
		echo -e "\n#: ../../bin/v-list-sys-hestia-updates:"$(grep -n "$string" ./hestiacp/bin/v-list-sys-hestia-updates | cut -d: -f1)"\nmsgid \"$string\"\nmsgstr \"\"" >> hestiacp.pot
	fi
done
# Scan the description string for list server page
for string in $(awk -F'SYSTEM=' '/data=".+ SYSTEM=[^"]/ {print $2}' ./hestiacp/bin/v-list-sys-services | cut -d\' -f2); do
	if [ -z "$(grep "\"$string\"" hestiacp.pot)" ]; then
		echo -e "\n#: ../../bin/v-list-sys-services:"$(grep -n "$string" ./hestiacp/bin/v-list-sys-services | cut -d: -f1)"\nmsgid \"$string\"\nmsgstr \"\"" >> hestiacp.pot
	fi
done
IFS=$OLDIFS
ls ./