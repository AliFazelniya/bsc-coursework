import numpy as np
from matrix.funcs import inverse_matrix

def doolittle(A, b):
    
    A = np.array(A, dtype=float)
    n = A.shape[0]
    L = np.zeros((n, n))
    U = np.zeros((n, n))

    for i in range(n):

        for k in range(i, n):

            sum_ = sum(L[i][j] * U[j][k] for j in range(i))

            U[i][k] = A[i][k] - sum_

        L[i][i] = 1

        for k in range(i+1, n):
            
            sum_ = sum(L[k][j] * U[j][i] for j in range(i))
            L[k][i] = (A[k][i] - sum_) / U[i][i]

    L_inv = inverse_matrix(L)
    U_inv = inverse_matrix(U)


    y = np.dot(L_inv, b)
    x = np.dot(U_inv, y)

    return x , y , L , U