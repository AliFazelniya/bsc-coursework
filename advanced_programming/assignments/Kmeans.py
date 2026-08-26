import numpy as np

def classify(data, k):
    """
    K-means clustering function.
    
    Parameters:
    data (numpy.ndarray): Matrix of shape (n, m) representing n samples and m features.
    k (int): Number of clusters.
    
    Returns:
    numpy.ndarray: Matrix of shape (n, k) showing cluster assignments (1 for assigned, 0 otherwise).
    """
    n, m = data.shape

    random_indices = np.random.choice(n, k, replace=False)
    centroids = data[random_indices]

    cluster_assignments = np.zeros(n, dtype=int)
    
    while True:
        diff = data[:, np.newaxis, :] - centroids[np.newaxis, :, :]
        distances = np.sum(np.abs(diff), axis=2)
        

        new_assignments = np.argmin(distances, axis=1)

        if np.array_equal(cluster_assignments, new_assignments):
            break
            
        cluster_assignments = new_assignments
        
        new_centroids = np.zeros((k, m))
        for i in range(k):
            points_in_cluster = data[cluster_assignments == i]
            
            if len(points_in_cluster) > 0:
                new_centroids[i] = np.mean(points_in_cluster, axis=0)
            else:
                
                new_centroids[i] = centroids[i]
                
        centroids = new_centroids

    output_matrix = np.zeros((n, k), dtype=int)
    output_matrix[np.arange(n), cluster_assignments] = 1
    
    return output_matrix
if __name__ == "__main__":

    X = np.array([
        [2, 10], # A1
        [2, 5],  # A2
        [8, 4],  # A3
        [5, 8],  # A4
        [7, 5],  # A5
        [6, 4],  # A6
        [1, 2],  # A7
        [4, 9]   # A8
    ])
    
    k_clusters = 3
    result = classify(X, k_clusters)
    
    print("ماتریس تعلق خوشه‌ها:")
    print(result)