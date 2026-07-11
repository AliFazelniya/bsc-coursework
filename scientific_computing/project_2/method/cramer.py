from matrix.funcs import calculate_determinant


def cramer_method(A_Matrix, B_Matrix):
    
    shape = A_Matrix.shape
    det = calculate_determinant(A_Matrix)

    xis = []

    for i in range(shape[0]):

        a_copy = A_Matrix.copy()
        
        a_copy[:, i] = a_copy[:, i] = B_Matrix.ravel()

        a_det = calculate_determinant(a_copy)

        xi  = a_det / det

        xis.append(xi)

    return xis