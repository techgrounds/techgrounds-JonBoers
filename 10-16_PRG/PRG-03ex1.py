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
