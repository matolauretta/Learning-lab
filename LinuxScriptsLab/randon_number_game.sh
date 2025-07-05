#!/bin/bash

# This script implements a simple random number guessing game.
if command -v shuf >/dev/null 2>&1; then
    SHUF_CMD="shuf"
elif command -v gshuf >/dev/null 2>&1; then
    SHUF_CMD="gshuf"
else
    SHUF_CMD=""
fi

if [ -n "$SHUF_CMD" ]; then
    random_number=$($SHUF_CMD -i 1-10 -n 1)
else
    random_number=$(( ( RANDOM % 10 ) + 1 ))
fi

echo "Welcome to the random number guessing game!"
echo "I have selected a random number between 1 and 10."    
echo "Can you guess what it is?"
while true; do
    read -p "Enter your guess: " user_guess

    if [[ ! $user_guess =~ ^([1-9]|10)$ ]]; then
        echo "Please enter a valid number between 1 and 10."
        continue
    fi

    if (( user_guess < random_number )); then
        echo "Too low! Try again."
    elif (( user_guess > random_number )); then
        echo "Too high! Try again."
    else
        echo "Congratulations! You guessed the number $random_number correctly!"
        break
    fi
done