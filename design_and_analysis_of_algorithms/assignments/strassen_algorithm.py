# Ali Fazleniya ID:4011833230
# Strassen algorithm in Python.(without using Numpy)
# The Strassen algorithm is a method for matrix multiplication that is faster than the standard matrix multiplication algorithm for large matrices. It achieves this by reducing the number of scalar multiplications from 8 in the traditional algorithm to 7.
# According to Strassen Algorithm we must calculate following parts:
# suppose we want to calculate A*B = C. then:
# M1 = (A11+A22) + (B11+B21), M2 = (A21+A22) * B11, M3 = A11 * (B12-B11),M4 = A22 * (B21-B11), M5 = (A11+A12) * B22, M6 = (A21-A11) * (B11+B12), M7 = (A12-A22) * (B21+B22)
# C11 = M1 + M4 - M5 + M7 , C12 = M3 + M5 , C21 = M2 + M4 , C22 = M1 - M2 + M3 + M6
# Note: Cause in this script we do not use Numpy, then we must write function of summation, subtraction function too:

def zero_matrix(A):
    ZeroMatrix = []
    length = len(A)
    for i in range(length):
        ZeroMatrix.append([0] * length)
    return ZeroMatrix


def matrix_summation(A, B):
    zero = zero_matrix(A)
    length = len(A)
    for i in range(length):
        for j in range(length):
            zero[i][j] = A[i][j] + B[i][j]
    return zero


def subtraction_matrix(A, B):
    zero = zero_matrix(A)
    length = len(A)
    for i in range(length):
        for j in range(length):
            zero[i][j] = A[i][j] - B[i][j]
    return zero

def split_Matrix(mat):
    mid = len(mat) // 2
    A = [row[:mid] for row in mat[:mid]]
    B = [row[mid:] for row in mat[:mid]]
    C = [row[:mid] for row in mat[mid:]]
    D = [row[mid:] for row in mat[mid:]]
    return A, B, C, D


def strassen(A, B):
    zero = zero_matrix(A)
    if len(A) == 1:
        return [[A[0][0] * B[0][0]]]

    A11, A12, A21, A22 = split_Matrix(A)
    B11, B12, B21, B22 = split_Matrix(B)

    M1 = strassen(matrix_summation(A11, A22), matrix_summation(B11, B21))
    M2 = strassen(matrix_summation(A21, A22), B11)
    M3 = strassen(A11, subtraction_matrix(B12, B22))
    M4 = strassen(A22, subtraction_matrix(B21, B11))
    M5 = strassen(matrix_summation(A11, A12), B22)
    M6 = strassen(subtraction_matrix(A21, A11), matrix_summation(B11, B12))
    M7 = strassen(subtraction_matrix(A12, A22), matrix_summation(B21, B22))
    C11 = matrix_summation(subtraction_matrix(matrix_summation(M1, M4), M5), M7)
    C12 = matrix_summation(M3, M5)
    C21 = matrix_summation(M2, M4)
    C22 = matrix_summation(subtraction_matrix(matrix_summation(M1, M3), M2), M6)
    for i in range(len(A) // 2):
        for j in range(len(A) // 2):
            zero[i][j] = C11[i][j]
            zero[i][j + len(A) // 2] = C12[i][j]
            zero[i + len(A) // 2][j] = C21[i][j]
            zero[i + len(A) // 2][j + len(A) // 2] = C22[i][j]
    return zero

A = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
B = [[17, 18, 19, 20], [21, 22, 23, 24], [25, 26, 27, 28], [29, 30, 31, 32]]
result = strassen(A, B)
print(result)

import numpy as np

arr = np.array(A)
arr2 = np.array(B)
print(np.dot(arr,arr2))
