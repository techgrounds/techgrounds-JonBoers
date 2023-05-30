# Loops
Introduction:
You can use loops when you want to run a block of code multiple times. For example, you might want to do an operation on every item in a (large) list, or you want to write an algorithm that follows the same set of instructions for multiple iterations.
There are two types of loops in Python: the while loop and the for loop.
The while loop runs while a condition is true. They can run indefinitely if that condition never changes. If your code is stuck in an infinite loop, just press ctrl-c (or command-c on MacOS) to force quit the running code.
The for loop runs for a predetermined number of iterations. This number can be hard coded using the range() function, or dynamically assigned (using a variable, the size of a list, or the number of lines in a document). It is also possible to accidentally create an infinite for loop. You can use the same command (ctrl/cmd+c) to exit your program.
Requirements:
Python
VS Code

## Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

## Opdracht
### Gebruikte bronnen
https://www.w3schools.com/python/gloss_python_array_loop.asp

### Ervaren problemen
* Ik schreef 'while' als ' While' en hoofdletters pikt 'ie niet.  
* Ook vergat ik de ':'
* Was even uitvogelen hoe je de for loop over een array loopt, maar w3schools bood uitleg hierover. 


### Resultaat  

**Exercise 1:**  

* Create a new script.
* Create a variable x and give it the value 0.
* Use a while loop to print the value of x in every iteration of the loop. After printing, the value of x should increase by 1. The loop should run as long as x is smaller than or equal to 10.

```
x = 0
while x <= 10:
    print(x)
    x = x + 1 
```

*output:*

```
0
1
2
3
4
5
6
7
8
9
10
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers>
```

**Exercise 2:**  
* Create a new script.
* Copy the code below into your script.
```
for i in range(10):
    # do something here
```
* Print the value of i in the for loop. You did not manually assign a value to i. Figure out how its value is determined.

```
for i in range(10):
    # do something here
    print(i)
```
*output*

```
python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-04ex2.py
0
1
2
3
4
5
6
7
8
9
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers> 
```
The value is determined in the statement
```
for i in range(10)
```
This generates a range which starts from 0 and stops at 10 with a step size of 1. (default)

Forms of the range iteration:

1. range(stop): Generates a sequence of numbers from 0 to stop - 1.
2. range(start, stop): Generates a sequence of numbers from start to stop - 1.
3. range(start, stop, step): Generates a sequence of numbers from start to stop - 1 with a step size of step.

* Add a variable x with value 5 at the top of your script.
* Using the for loop, print the value of x multiplied by the value of i, for up to 50 iterations.  

```
x = 5
for i in range(49):
    # do something here
    print(x * i)
```
*output*
```
python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-04ex2.py
0
5
10
15
20
25
30
35
40
45
50
55
60
65
70
75
80
85
90
95
100
105
110
115
120
125
130
135
140
145
150
155
160
165
170
175
180
185
190
195
200
205
210
215
220
225
230
235
240
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers> 
```

**Exercise 3:**  

* Create a new script.
* Copy the array below into your script.
```
arr = ["Coen", "Casper", "Joshua", "Abdessamad", "Saskia"]
```

* Use a for loop to loop over the array. Print every name individually.  

```
arr = ["Coen", "Casper", "Joshua", "Abdessamad", "Saskia"]
for i in arr:
    print(i)
```

*output*

```
python3.11.exe c:/Users/TechGrounds/Documents/GitHub/techgrounds-JonBoers/10-16_PRG/PRG-04ex3.py
Coen
Casper
Joshua
Abdessamad
Saskia
PS C:\Users\TechGrounds\Documents\GitHub\techgrounds-JonBoers>
```






