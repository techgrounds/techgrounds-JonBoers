# Functions

## Introduction:  
You’ve already seen and used a couple of functions, like print() and input(). A function is a block of code that only runs when it is called. Functions are recognizable by the brackets () next to the function name. These brackets serve as a place to input data into a function.
Functions return data as a result.

Besides the built-in functions, you can also write custom functions, or import functions from a library or package.  
**Requirements:**  
* Python
* VS Code




## Key-terms
**random:**  
the random.randint() function is used to generate a random integer between the specified range. It takes two arguments: a lower bound and an upper bound. ex.:

```
random.randint(0, 100)
```

whereas:
```
print(random.random(0, 100))
```
...will return a float.

**function:**

Information can be passed into functions as arguments.

Arguments are specified after the function name, inside the parentheses. You can add as many arguments as you want, just separate them with a comma.

The following example has a function with one argument (fname). When the function is called, we pass along a first name, which is used inside the function to print the full name:

Example
```
def my_function(fname):
  print(fname + " Refsnes")

my_function("Emil")
my_function("Tobias")
my_function("Linus")
```
*output:*
```
Emil Refsnes
Tobias Refsnes
Linus Refsnes
```

**Arbitrary arguments:**

Arbitrary Arguments, *args
If you do not know how many arguments that will be passed into your function, add a * before the parameter name in the function definition.

This way the function will receive a tuple of arguments, and can access the items accordingly:

ExampleGet your own Python Server
If the number of arguments is unknown, add a * before the parameter name:
```
def my_function(*kids):
  print("The youngest child is " + kids[2])

my_function("Emil", "Tobias", "Linus")
```

## Opdracht
### Gebruikte bronnen
https://www.w3schools.com/python/module_random.asp  
https://www.w3schools.com/python/python_functions.asp  
https://www.w3schools.com/python/gloss_python_function_arbitrary_arguments.asp  
### Ervaren problemen

### Resultaat

**Exercise 1:**  

* Create a new script.
* Import the random package.
* Print 5 random integers with a value between 0 and 100.

```
import random 

for i in range(5):
    random_number = random.randint(0, 100)
    print(random_number)
```
*output:*
```
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers> & C:/Users/TechGrounds/AppData/Local/Microsoft/WindowsApps/python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-06ex1.py
56
4 
72
81
75
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers> & C:/Users/TechGrounds/AppData/Local/Microsoft/WindowsApps/python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-06ex1.py
40
1
62
48
33
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers>
```

**Exercise 2:**  

* Create a new script.
* Write a custom function myfunction() that prints “Hello, world!” to the terminal. Call myfunction.
```
def myfunction():
  print("Hello, world!")

myfunction()
```
*output:*
```
python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-06ex2.py
Hello, world!
```

* Rewrite your function so that it takes a string as an argument. Then, it should print 
```
“Hello, <string>!”.
```
```
def myfunction(myname):
  print("Hello, " + myname + "!") 

myfunction("Jon")
```
*output:*
```
python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-06ex2.py
Hello, Jon!
```

**Exercise 3:**  

* Create a new script.
Copy the code below into your script.
```
def avg():
	# write your code here


# you are not allowed to edit any code below here
x = 128
y = 255
z = avg(x,y)
print("The average of",x,"and",y,"is",z)  
```
* Write the custom function avg() so that it returns the average of the given parameters. You are not allowed to edit any code below the second comment.

```
def avg(*args):
	# write your code here
    return sum(args) / len(args)
    
# you are not allowed to edit any code below here
x = 128
y = 255
z = avg(x,y)
print("The average of",x,"and",y,"is",z)
```
*output:*
```
python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-06ex3.py
The average of 128 and 255 is 191.5
```

