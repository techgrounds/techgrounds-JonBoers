First_name = input("What is your first name?")
Last_name = input("What is your last name?")
Job_title = input("What is your job title?")
Company = input("What is your company?")

input_dictionary = {
    "First name": First_name,
    "Last name": Last_name,
    "Job title": Job_title,
    "Company": Company
}

for k, v in input_dictionary.items():
    print(k, ":", v)
    
import csv

with open('test.csv', 'w') as f:
    for key in input_dictionary.keys():
        f.write("%s,%s\n"%(key,input_dictionary[key]))