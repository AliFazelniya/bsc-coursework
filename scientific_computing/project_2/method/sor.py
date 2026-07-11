import numpy as np
from matrix.funcs import norm_handler

def sor_method(norm, w, x0, k, A, b):
    
    x = x0.copy()

    all_answers = [x.copy()]

    for i in range(k):

        x_new = x.copy()

        for j in range(A.shape[0]):

            s1 = np.dot(A[j, :j], x_new[:j])
            s2 = np.dot(A[j, j+1:], x[j+1:])
            
            x_new[j] = (1-w)*x[j] + (w*(b[j] - s1 - s2)/A[j, j])

        all_answers.append(x_new.copy())

        if norm_handler(norm, x_new, x):

            break
        
        x = x_new

    return all_answers