#!/bin/bash
# This script demonstrates the use of loops in bash

primary_colors="red blue yellow"
index=1

for word in $primary_colors; do
    counter=0
    length=${#word}

    while [ $counter -lt $length ]; do
        ((counter++))
    done

    echo "The $index primary color $word has $counter letters."
    ((index++))
done

echo "Enter a list of your favorite colors (space-separated):"
read -a colors
echo "You entered ${#colors[@]} colors."
echo "You entered: ${colors[*]}"

for word in ${colors[@]}; do
    length=${#word}
    number=1
    until [ "$number" -eq $length ]; do
        ((number++))
    done
     echo "The word '$word' has $number letters."
done