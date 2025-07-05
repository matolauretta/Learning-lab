#!/bin/bash

# Variables and Conditionals usage example
# Define a variable
name="Mato"
last_name="Lauretta"
city="Córdoba, Argentina"
# Calculate age based on birthdate (March 17, 1987)
birth_year=1987
birth_month=3
birth_day=17

current_year=$(date +%Y)
current_month=$(date +%m)
current_day=$(date +%d)

# Function to calculate age based on birthdate
calculate_age() {
    local b_year=$1
    local b_month=$2
    local b_day=$3
    local age=$((current_year - b_year))
    if [ "$current_month" -lt "$b_month" ] || { [ "$current_month" -eq "$b_month" ] && [ "$current_day" -lt "$b_day" ]; }; then
        age=$((age - 1))
    fi
    echo "$age"
}

age=$(calculate_age "$birth_year" "$birth_month" "$birth_day")

# Print the variable
echo "Hello, my name is $name $last_name. I live in $city and I am $age years old."

# Reading user input, ovewrite the variable
echo "What is your name?"
read name
echo "What is your last name?"
read last_name
echo "Which city were you born in?"
read city
while true; do
    read -p "What is your birthdate? (YYYY-MM-DD): " birth_date
    if [[ "$birth_date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        break
    else
        echo "Invalid date format. Please use YYYY-MM-DD."
    fi
done
birth_year=$(echo "$birth_date" | cut -d '-' -f 1)
birth_month=$(echo "$birth_date" | cut -d '-' -f 2)
birth_day=$(echo "$birth_date" | cut -d '-' -f 3)

age=$(calculate_age "$birth_year" "$birth_month" "$birth_day")
# Print the new values
echo "Hello, $name $last_name from $city! You are $age years old."
