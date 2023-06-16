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
        row = int(input("Enter the row number (0-2): "))
        col = int(input("Enter the column number (0-2): "))
        
        if board[row][col] == ' ':
            board[row][col] = player
            if check_winner(player):
                print_board(board)
                print(f"Player {player} wins!")
                break
            if player == 'X':
                player = 'O'
            else:
                player = 'X'
        else:
            print("That cell is already occupied. Try again.")

def check_winner(player):
    for row in board:
        if row.count(player) == 3:
            return True
    for col in range(3):
        if board[0][col] == player and board[1][col] == player and board[2][col] == player:
            return True
    if board[0][0] == player and board[1][1] == player and board[2][2] == player:
        return True
    if board[0][2] == player and board[1][1] == player and board[2][0] == player:
        return True
    return False

play_game()
