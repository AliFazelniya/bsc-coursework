import numpy as np
from matrix.funcs import norm_handler

def gauss_seidel_method(norm, x0, k, A, b):
    
    all_answers = []
    all_answers.append(x0.copy())

    for i in range(k):

        xi = all_answers[-1].copy()

        for j in range(A.shape[0]):

            s1 = np.dot(A[j, :j], xi[:j])

            s2 = np.dot(A[j, j+1:], xi[j+1:])

            xi[j] = (b[j] - s1 - s2) / A[j, j]

        all_answers.append(xi.copy())

        if norm_handler(norm, all_answers[i+1], all_answers[i]):
            break
    
    return all_answers