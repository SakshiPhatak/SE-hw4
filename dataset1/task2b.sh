awk '{command="grep -o -E \x27CSC510\x27 " $1 " | uniq -c | awk \x27{print $1}\x27"; command | getline size; print $0, size}' \
| awk '{command="ls -l " $1 " | awk \x27{print $5}\x27"; command | getline size; print $0, size}' \
| sort -k2,2nr -k3,3nr \
| sed "s/file_/filtered_/" \
| awk '{print $1}'
