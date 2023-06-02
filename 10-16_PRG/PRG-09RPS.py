# Rock Paper Scissors:

# Assignment:

# The player plays against a computer opponent typing either a letter (rps) or an 
# entire word (rock paper scissors) to play their move.


import random

# Function to check if the move is valid
# Create a function that checks whether the move is valid or not.
def is_valid_move(move):
    valid_moves = ['r', 'p', 's', 'rock', 'paper', 'scissors']
    return move.lower() in valid_moves

# Function to generate the computer's move
# Create another function to create a computer move.
def generate_computer_move():
    moves = ['r', 'p', 's']
    return random.choice(moves)

# Function to check who wins the round
# Create another function to check who wins the round.
def check_round_winner(player_move, computer_move):
    if player_move == computer_move:
        return 'tie'
    elif (
        (player_move == 'r' and computer_move == 's') or
        (player_move == 'p' and computer_move == 'r') or
        (player_move == 's' and computer_move == 'p')
    ):
        return 'player'
    else:
        return 'computer'


# Finally, create a function that keeps track of the score.
# Function to keep track of the score
def play_game(rounds):
    player_score = 0
    computer_score = 0

    for _ in range(rounds):
        player_move = input("Enter your move: ")

        # Validate player's move
        while not is_valid_move(player_move):
            print("Invalid move! Please enter 'r', 'p', or 's'.")
            player_move = input("Enter your move: ")

        # Generate computer's move
        computer_move = generate_computer_move()

        print("Computer's move:", computer_move)

        # Determine the round winner
        round_winner = check_round_winner(player_move.lower(), computer_move)

        if round_winner == 'player':
            print("Player wins the round!")
            player_score += 1
        elif round_winner == 'computer':
            print("Computer wins the round!")
            computer_score += 1
        else:
            print("It's a tie!")

        print("Current score - Player: {}, Computer: {}".format(player_score, computer_score))
        print()

    print("Final score - Player: {}, Computer: {}".format(player_score, computer_score))

# Play the game with 5 rounds

play_game(5)
