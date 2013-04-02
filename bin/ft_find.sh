#!/bin/bash
# ft_find.sh <file_extension> <grep_pcre>
# Searches my typical project layout for matching files of grep_pcre,
# limited by file_extension
set -f
find . -type d \( -path './lib' -o -path './src' -o -path './bin' -o -path './share' -o -path './.*' \) -prune -o -type f -name "*.$1" -print0 | xargs -0 grep -n -P "$2" > __quickfix__ && vim -q __quickfix__ -c 'copen'
set +f
