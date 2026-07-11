import numpy as np
from matrix.funcs import Main_Diagonal_Matrix_Convertor

def Gaussian_Elimination_method(A_Matrix, B_Matrix):

    matrix = np.hstack((A_Matrix, B_Matrix))

    Matrix = Main_Diagonal_Matrix_Convertor(matrix)

    b = Matrix[:, -1]

    return b