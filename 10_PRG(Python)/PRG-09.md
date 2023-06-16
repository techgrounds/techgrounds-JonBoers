# Mini project Python

Introduction:
Now that you’ve encountered the basic puzzle pieces, it’s time to build something. Depending on how comfortable you are with Python, you can choose one of the following games to build:
Number guessing (Beginner)
Rock paper scissors (Intermediate)
Tic-Tac-Toe (Hard)

## Requirements:
* Python
* VS Code



## Key-terms


## Opdracht

## Number Guessing:
* Generate a random number between 1 and 100 (or any other range).
* The player guesses a number. For every wrong answer the player receives a clue.
* When the player guesses the right number, display a score.

## Rock Paper Scissors:
* The player plays against a computer opponent typing either a letter (rps) or an entire word (rock paper scissors) to play their move.
* Create a function that checks whether the move is valid or not.
* Create another function to create a computer move.
* Create another function to check who wins the round.
* Finally, create a function that keeps track of the score.
* The game should be played in a predetermined number of rounds.

## Tic-Tac-Toe:
* Generate a 3x3 board on the command line.
* This is a 2-player game, where one player inputs “X” and the other player inputs “O”.
* Bonus: create a single-player version that you can play against the computer.

### Gebruikte bronnen

https://www.programiz.com/python-programming/modules/random


### Ervaren problemen

### Resultaat
```
## Number Guessing:
# Generate a random number between 1 and 100 (or any other range).
# The player guesses a number. For every wrong answer the player receives a clue.
# When the player guesses the right number, display a score.

import random

def play_guessing_game():
    # Generate a random number between 1 and 100 (or any other range).
    secret_number = random.randint(1, 100)
    attempts = 0

    while True:
        guess = int(input("Enter your guess (between 1 and 100): "))
        attempts += 1

        if guess < secret_number:
            print("Too low! Try again.")
        elif guess > secret_number:
            print("Too high! Try again.")
        else:
            print(f"Congratulations! You guessed the number in {attempts} attempts.")
            break

play_guessing_game()
```

