import numpy as np
from matrix.funcs import get_transpose
def cholesky_decomposition(A , b):

    A = A.copy()
    n = A.shape[0]
    L = np.zeros_like(A)
    b = b.copy()

    for i in range(n):

        for j in range(i + 1):

            sum_ = np.dot(L[i, :j], L[j, :j])

            if i == j:

                val = A[i, i] - sum_
        
                if val <= 0:

                    return "Matrix is not positive definite."
                
                L[i, j] = np.sqrt(val)

            else:

                L[i, j] = (A[i, j] - sum_) / L[j, j]


    y = np.zeros((n, 1))

    for i in range(n):

        y[i] = (b[i] - np.dot(L[i, :i], y[:i])) / L[i, i]

    x = np.zeros((n, 1))

    Lt = get_transpose(L)

    for i in reversed(range(n)):

        x[i] = (y[i] - np.dot(Lt[i, i+1:], x[i+1:])) / Lt[i, i]

    return [x , y , L , Lt]