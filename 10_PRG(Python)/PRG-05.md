# Conditions
## Introduction:

Very often, you will want to run a piece of code only when certain conditions are met. For example, you might want to write something to an error log only if the reply you receive from a server contains an error.
Python makes use of the if, elif, and else statements.
Requirements:
* Python
* VS Code

## Key-terms
if  
elif  
else  

## Opdracht

### Gebruikte bronnen
https://pythonprogramminglanguage.com/if-statements/

### Ervaren problemen
input is altijd een string dus om numerieke vergelijkingen te kunnen maken moet de waarde worden omgezet in een integer:

```
number = int(input("Please enter a number:"))
```

### Resultaat
**Exercise 1:**
* Create a new script.
* Use the input() function to ask the user of your script for their name. If the name they input is your name, print a personalized welcome message. If not, print a different personalized message.
```
name = input("What's your name?")
if name == "Jon":
    print("Welcome Jon so good to see you again!")
else:
    print("You are " + name + ", not Jon. Please leave.")
```
*output*

```
python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-05ex1.py
What's your name?Jon
Welcome Jon so good to see you again!
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers> & C:/Users/TechGrounds/AppData/Local/Microsoft/WindowsApps/python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-05ex1.py
What's your name?Coen
You are Coen, not Jon. Please leave.
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers> 
```




Exercise 2:
Create a new script.
Ask the user of your script for a number. Give them a response based on whether the number is higher than, lower than, or equal to 100.

Make the game repeat until the user inputs 100.

```
while True: 
    number = int(input("Please enter a number:"))
    
    if number > 100:
        print(number, " is too large!")
    elif number < 100:
        print(number, " is too small!")
    else:
        print(number, "is the number we're looking for! You win!!")
        break
```

*output:*

```
python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-05ex2.py
Please enter a number:34
34  is too small!
Please enter a number:101
101  is too large!
Please enter a number:100
100 is the number we're looking for! You win!!
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers> 
```


