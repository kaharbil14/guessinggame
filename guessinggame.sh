#!/bin/bash
# guessinggame.sh - guess how many files are in the current directory

# Count the regular (non-hidden) files in the current directory
function count_files {
    find . -maxdepth 1 -type f ! -name '.*' | wc -l
}

# Ask the user for a guess and keep asking until it is a number
function get_guess {
    local answer
    while true; do
        read -p "Your guess: " answer
        if [[ $answer =~ ^[0-9]+$ ]]; then
            echo "$answer"
            return
        fi
        echo "Please enter a whole number." >&2
    done
}

actual=$(count_files)

echo "Welcome to the Guessing Game!"
echo "How many files are in the current directory?"

guess=$(get_guess)

while [[ $guess -ne $actual ]]
do
    if [[ $guess -lt $actual ]]
    then
        echo "Too low! Try again."
    else
        echo "Too high! Try again."
    fi
    guess=$(get_guess)
done

echo "Congratulations! You guessed correctly."
echo "There are $actual files in this directory."
