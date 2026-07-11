import numpy as np

def calculate_determinant(matrix: np.ndarray) -> float:
        
        if matrix.shape == (3, 3):

            det = (matrix[0, 0] * (matrix[1, 1]*matrix[2, 2] - matrix[1, 2]*matrix[2, 1]) -
                   matrix[0, 1] * (matrix[1, 0]*matrix[2, 2] - matrix[1, 2]*matrix[2, 0]) +
                   matrix[0, 2] * (matrix[1, 0]*matrix[2, 1] - matrix[1, 1]*matrix[2, 0]))
            
            return det
        
        else:

            return np.linalg.det(matrix)
        
def Main_Diagonal_Matrix_Convertor(Matrix):
    
    n = len(Matrix)


    for i in range(n):

        pivot = Matrix[i, i]

        if pivot == 0:
            raise ValueError("The Pivot element is zero. Cannot proceed with Gauss-Jordan elimination.")
        
        Matrix[i] = Matrix[i] / pivot

        for j in range(n):

            if j != i:

                factor = Matrix[j, i]
                Matrix[j] = Matrix[j] - factor * Matrix[i]
    
    return Matrix

def Upper_Triangular_Matrix_Convertor(A):
    
    A = A.astype(float).copy()

    n = len(A)

    for i in range(n):

        if A[i][i] == 0:

            for k in range(i+1, n):

                if A[k][i] != 0:

                    A[[i, k]] = A[[k, i]]

                    break

        for j in range(i+1, n):

            if A[j][i] != 0:

                factor = A[j][i] / A[i][i]
                
                A[j, :] = A[j, :] - factor * A[i, :]

    return A

def Lower_Triangular_Matrix_Convertor(A):

    A = A.astype(float).copy()

    n = len(A)

    for i in range(n-1, -1, -1):

        if abs(A[i][i]) < 1e-12:

            for k in range(i-1, -1, -1):

                if abs(A[k][i]) > 1e-12:

                    A[[i, k]] = A[[k, i]]

                    break

        for j in range(i-1, -1, -1):

            if abs(A[j][i]) > 1e-12:

                factor = A[j][i] / A[i][i]
                
                A[j, :] = A[j, :] - factor * A[i, :]

    return A

def inverse_matrix(Matrix):

    n = len(Matrix)

    Identity = np.eye(n)

    Augmented_Matrix = np.hstack((Matrix, Identity))

    RREF_Matrix = Main_Diagonal_Matrix_Convertor(Augmented_Matrix)

    Inverse = RREF_Matrix[:, n:]
    
    return Inverse

def Spectral_radius(Matrix):

    eigenvalues = np.linalg.eigvals(Matrix)

    spectral_radius = max(abs(eigenvalues))

    return spectral_radius


def infinity_norm(vector1 , vector2):

    return np.max(vector1 - vector2)

def norm_tow(vector1, vector2):

    return np.sum(np.square(vector1 - vector2))

def norm_one(vector1, vector2):

    return np.sum(np.abs(vector1 - vector2))


def norm_handler(norm, xj , xk, e = 1e-6):

    if norm == "infinity":

        if infinity_norm(xj , xk) < e:

            return True
        
    elif norm == "one":

        if norm_one(xj , xk) < e:

            return True
        
    elif norm == "two":

        if norm_tow(xj , xk) < e:
            
            return True
        
def check_diagonal_dominance_row(A):

    n = A.shape[0]

    for i in range(n):

        diag_elem = abs(A[i, i])

        off_diag_sum = sum(abs(A[i, j]) for j in range(n) if j != i)

        if diag_elem < off_diag_sum:

            return False
        
    return True


def check_diagonal_dominance_col(A):

    n = A.shape[0]

    for i in range(n):

        diag_elem = abs(A[i, i])

        off_diag_sum = sum(abs(A[j, i]) for j in range(n) if j != i)

        if diag_elem < off_diag_sum:

            return False
        
    return True

def cal_B(A, method):
    A = A.copy()

    D = np.diag(np.diag(A))
    L = -np.tril(A, -1)
    U = -np.triu(A, 1)

    if method == "Jacobi":
        B = inverse_matrix(D) @ (L + U)

    elif method == "Gauss-Seidel":
        B = inverse_matrix(D - L) @ U

    else:

        raise ValueError("method must be 'Jacobi' or 'Gauss-Seidel'")

    return B

def get_transpose(Matrix):

    n , m = Matrix.shape

    Matrix_T = np.zeros((m, n))

    for i in range(n):

        for j in range(m):

            Matrix_T[j, i] = Matrix[i, j]

    return Matrix_T