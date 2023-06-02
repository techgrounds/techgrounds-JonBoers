import random

board = [[' ', ' ', ' '],
         [' ', ' ', ' '],
         [' ', ' ', ' ']]

def print_board(board):
    for row in board:
        print('|'.join(row))
        print('-----')

def play_game():
    player = 'X'
    while True:
        print_board(board)
        if player == 'X':
            row = int(input("Enter the row number (0-2): "))
            col = int(input("Enter the column number (0-2): "))
        else:
            row, col = get_computer_move()
            print(f"Computer plays at row {row}, column {col}")
        
        if board[row][col] == ' ':
            board[row][col] = player
            if check_winner(player):
                print_board(board)
                if player == 'X':
                    print("Congratulations! You win!")
                else:
                    print("Sorry, the computer wins.")
                break
            if player == 'X':
                player = 'O'
            else:
                player = 'X'
        else:
            print("That cell is already occupied. Try again.")

def get_computer_move():
    available_moves = []
    for row in range(3):
        for col in range(3):
            if board[row][col] == ' ':
                available_moves.append((row, col))
    return random.choice(available_moves)

def check_winner(player):
    for row in board:
        if row.count(player) == 3:
            return True
    for col in range(3):
        if board[0][col] == player and board[1][col] == player and board[2][col] == player:
            return True
    if board[0][0] == player and board[1][1] == player and board[2][2] == player:
        return True
