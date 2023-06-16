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

