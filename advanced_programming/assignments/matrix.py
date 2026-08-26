import numpy as np
a = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
            ]
b = [
    [10,11,12],
    [13,14,15],
    [16,17,18]
            ]
# The first way:
result = [
    [0,0,0],
    [0,0,0],
    [0,0,0]
]
for i in range(3):
    for j in range(3):
        for k in range(3):
            result[i][j] += a[i][k]*b[k][j]            
# The second way(with numpy):
#print(np.dot(a,b))
print(result)
print("------------------practice1-------------------")
Rainfall = [
    ("mapaloa", [87,88,89]),
    ("matale", [13,139,61])
                    ]
# The first way:
result = [["mapaloa"],
           ["matale"]
           ]
summation = 0
for number in range(2):
    for i in Rainfall:
        if Rainfall.index(i) == number:
            for j in i:
                if i.index(j) == 1:
                    summation = sum(j)
                    result[number].append(summation)
    result[number] = tuple(result[number])
print(result)
# The second way:
# result1 = ([
#     ("mapaloa", sum([87,88,89])),
#     ("matale", sum([13,139,61]))
#                     ])
# print(result1)
print("------------------practice2-------------------")
my_tuple = (9,6,7,4,3,18,9,10)
my_tuple = list(my_tuple)
# The first way:
my_tuple.remove(4)
# The second way:
# for i in my_tuple:
#     if i == 4:
#         my_tuple.remove(i)
# The third way:
#my_tuple.pop(3)
print(tuple(my_tuple))
print("------------------practice3-------------------")
