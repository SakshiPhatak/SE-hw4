grep -o -E "CSC510|sample" file* \
| uniq -c \
| grep -v -E "^\s*[012].*:CSC510$" \
| sed -E "s/\s+[0-9]*\s//g" \
| sed -E "s/:(CSC510|sample)$//g" \
| uniq