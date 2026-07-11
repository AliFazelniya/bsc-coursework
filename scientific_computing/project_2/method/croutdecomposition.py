import numpy as np

def crout_decomposition(A, b):

    A = A.copy()
    b = b.copy().flatten()
    n = A.shape[0]
    L = np.zeros((n, n))
    U = np.eye(n)

    for j in range(n):

        for i in range(j, n):
            L[i, j] = A[i, j] - sum(L[i, k] * U[k, j] for k in range(j))

        for k in range(j+1, n):

            if L[j, j] == 0:

                return "Zero pivot encountered in Crout decomposition."
            
            U[j, k] = (A[j, k] - sum(L[j, s] * U[s, k] for s in range(j))) / L[j, j]

    y = np.zeros(n)

    for i in range(n):
        y[i] = (b[i] - np.dot(L[i, :i], y[:i])) / L[i, i]


    x = np.zeros(n)

    for i in reversed(range(n)):

        x[i] = (y[i] - np.dot(U[i, i+1:], x[i+1:])) / U[i, i]

    return [x , y , L , U]
