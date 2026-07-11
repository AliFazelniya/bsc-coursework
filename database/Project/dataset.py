import kagglehub

# Download latest version
path = kagglehub.dataset_download("birdy654/football-players-and-staff-faces")

print("Path to dataset files:", path)