# Data types and comments
Introduction:
Under the hood, a computer can only see strings of zeros and ones. Programming languages make use of data types to tell the computer how to interpret those strings.
For example, when the computer needs to read the binary string 01000001, it will need to know the data type to determine whether it means 65 or “A”.

This is a non-exhaustive list of some of the most important data types in Python:  
* boolean  
A binary state that is either True or False.
boolean = True  
* string  
Technically an array of characters. Strings are denoted using “ ” double quotes or ‘ ’ single quotes.
```
string = "This is a string"
```

*  int  
An integer is a whole number. Ints can be both positive and negative.
```
integer = 6
```
* float  
A floating-point number is a decimal number.
```
floating_point = 18.5
```


Comments are lines that do not get processed as code. This can be used for multiple purposes. For example, you can write a short description of what a block of code does. You can also ‘comment out’ some code, so that it is temporarily removed. This can be useful for testing and debugging.  

**Requirements:**  

* Python
* VS Code

## Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

## Opdracht
### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat

**Exercise 1:**  

* Create a new script.
* Copy the code below into your script.
```
a = 'int'
b = 7
c = False
d = "18.5"
```

* Determine the data types of all four variables (a, b, c, d) using a built in function.
* Make a new variable x and give it the value b + d. Print the value of x. This will raise an error. Fix it so that print(x) prints a float.
* Write a comment above every line of code that tells the reader what is going on in your script.   

```
#this sets variable a to string
a = 'int'
#this sets variable b to integer
b = 7
#this sets variable c to boolean
c = False
#this sets veraible d to string
d = "18.5" 
#this prints the datatypes of the variables
print("type a is: ",  type(a)) 
print("type b is: ",  type(b)) 
print("type c is: ",  type(c)) 
print("type d is: ",  type(d)) 

# This code gave an error:
# x = b + d
# print(x)

#fixed it with this:

#prints "after fix" and blank lines above and below
print()
print("after fix: ")
print()
#this sets variable b + d to floats
b = 7.0
d = 18.5
#this stores the sum of variables b and d in a new variable 'x'
x = b + d
#this prints the new datatypes of the variables 'a, b, c & d' 
print("type a is: ",  type(a)) 
print("type b is: ",  type(b)) 
print("type c is: ",  type(c)) 
print("type d is: ",  type(d)) 
#this prints the new variable x as a float
print()
print("x is: ", x)
```
Output:

```
[Running] python -u "c:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers\10-16_PRG\tempCodeRunnerFile.py"
type a is:  <class 'str'>
type b is:  <class 'int'>
type c is:  <class 'bool'>
type d is:  <class 'str'>

after fix: 

type a is:  <class 'str'>
type b is:  <class 'float'>
type c is:  <class 'bool'>
type d is:  <class 'float'>

x is:  25.5

[Done] exited with code=0 in 0.157 seconds
```
**Exercise 2:**

* Create a new script.
* Use the input() function to get input from the user. Store that input in a variable.
* Find out what data type the output of input() is. See if it is different for different kinds of input (numbers, words, etc.).

```
name = input("what is your name")
age = input("how old are you")
drink = input("What's your favourite drink?")
qty = input("how many cups of " + drink + " do you drink daily?")

#this prints the datatypes of the variables
print()
print("datatype of <name> is: ",  type(name)) 
print("datatype of <age> is: ",  type(age)) 
print("datatype of <drink> is: ",  type(drink)) 
print("datatype of <qty> is: ",  type(qty)) 
print()

print("Hi " + name + " WOW! " + age + " is really really old! Drinking " + qty + " cups of " + drink + " a day is too much.")
```
*output*

```
what is your nameJon
how old are you47
What's your favourite drink?coffee
how many cups of coffee do you drink daily?3.5

datatype of <name> is:  <class 'str'>
datatype of <age> is:  <class 'str'>
datatype of <drink> is:  <class 'str'>
datatype of <qty> is:  <class 'str'>

Hi Jon WOW! 47 is really really old! Drinking 3.5 cups of coffee a day is too much.
```
Even though the user entered different datatypes (strings, integers, float) they're still all classified as strings 'str'.
