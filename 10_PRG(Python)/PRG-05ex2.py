while True: 
    number = int(input("Please enter a number:"))
    
    if number > 100:
        print(number, " is too large!")
    elif number < 100:
        print(number, " is too small!")
    else:
        print(number, "is the number we're looking for! You win!!")
        break