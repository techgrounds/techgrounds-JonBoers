# Python bonus

## Introduction:  

You might have seen a folder in the drive named ‘Pls fix’. This folder contains 16 very small Python scripts that are somehow broken. Your job is to fix the mistake by changing only 1 or 2 small things within the script. The expected result for each script is written in the multi-line comment at the top of the script.

This exercise is meant as a little fun puzzle, but also to help you learn to troubleshoot existing code, so even though they are optional, they are recommended to do.
Of course, you can get to the expected results by simply deleting all the code and using a print function, but that would defeat the purpose of this exercise.

The exercises are approximately ordered based on difficulty level, but you might want to skip one if you get stuck and go back to that one later

## Requirements:
* VS Code
* The scripts in Pls fix

## Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

## Opdracht

Exercise:
Fix the 16 broken Python scripts

### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat

**1.py**

```
The output should be:
hello Casper
hello Floris
hello Esther

foo = 'hello'
ls = ['Casper', 'Floris', 'Esther']
for name in ls:
	print(loo,name)
```

Solution:
```
# loo ipv foo

loo = 'hello'
ls = ['Casper', 'Floris', 'Esther']
for name in ls:
	print(loo,name)
```

**2.py**

```
The output should be:
100

foo = 20
bar = '80'
print(foo + bar)
```

Solution:
```
foo = 20

# deleted '' so both variables are integers
bar = 80
print(foo + bar)
```

**3.py**

```
The output should be:
30

foo = 20
for i in range(10):
	foo -= 1

print(foo)
```

Solution:
```
foo = 20
for i in range(10):
	# changed - into +
    foo += 1

print(foo)
```

**4.py**

```The output should be:
there are 0 kids on the street
there are 1 kids on the street
there are 2 kids on the street
there are 3 kids on the street
there are 4 kids on the street

foo = 0
while foo <= 5:
	print('there are', foo, 'kids on the street')
	foo += 1
```

Solution:

```
foo = 0

# changed <= into <
while foo < 5:
	print('there are', foo, 'kids on the street')
	foo += 1
```

**5.py**

```
The output should be:
Star Wars

ls = ['Lord of the rings', 'Star Trek', 'Iron Man', 'Star Wars']
print(ls[4])
```

Solution:

```
ls = ['Lord of the rings', 'Star Trek', 'Iron Man', 'Star Wars']

# changed 4 into 3 because the index starts with 0
print(ls[3])
```

**6.py**

```
The output should be:
80

foo = 80
if foo < 30:
	print(foo)
else:
	print('big number wow')
elif foo < 100:
	print(foo)
```

Solution:

```
foo = 80
if foo < 30:
	# adjusted the print message (instead of print so it relates to the number.)
    print('tiny number meh')
# switched elif with else so the order is logic
elif foo > 100:
    print('big number wow')
else:
	# added print command here
    print(foo)
```



