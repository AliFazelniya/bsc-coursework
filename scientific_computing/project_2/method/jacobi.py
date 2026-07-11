import numpy as np
from matrix.funcs import norm_handler

def jacobi_method(norm, x0, k, A, b):
    
    all_answers = []
    all_answers.append(x0.copy())

    for i in range(k):

        xi = np.zeros_like(x0)

        for j in range(A.shape[0]):

            s = np.dot(A[j, :], all_answers[i]) - A[j, j] * all_answers[i][j]

            xi[j] = (b[j] - s) / A[j, j]

        all_answers.append(xi)

        if norm_handler(norm, all_answers[i+1], all_answers[i]):
                break

    return all_answers