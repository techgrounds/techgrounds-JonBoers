integers = [34, 78, 3, 20, 12]

def add_items_in_list(lst):
    result = []
    for i in range(len(lst)):
        result.append(lst[i] + lst[(i + 1) % len(lst)])
    return result


print("integers = ", integers)

result_list = add_items_in_list(integers)
for i in result_list:
    print(i)

