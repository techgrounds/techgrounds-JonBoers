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

