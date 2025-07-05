#!/bin/bash

if [ $# -lt 1 ]; then
    echo "usage: $0 followed by a least one name"
    echo "Usage: $0 <name1> [<name2> ...]"
    exit 1
fi

echo "you entered $# names"

number_of_names=$#
while [ $# -gt 0 ]; do
    name=$1
    echo "Hello, $name!"
    shift
done
