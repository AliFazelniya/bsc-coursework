grid <- matrix(c(
  "1", "0", "0", "1", "0", "0", "0", "D", "0", "0",
  "0", "0", "0", "0", "1", "0", "0", "0", "0", "0",
  "0", "0", "0", "0", "0", "0", "0", "0", "0", "1",
  "0", "1", "0", "0", "0", "0", "0", "0", "0", "0",
  "1", "0", "0", "1", "0", "0", "0", "1", "0", "0",
  "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
  "0", "1", "0", "0", "0", "1", "0", "0", "0", "0",
  "0", "0", "1", "0", "0", "0", "0", "1", "1", "0",
  "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
  "0", "0", "S", "0", "1", "0", "0", "0", "0", "0"
), nrow = 10, byrow = TRUE)

rows <- nrow(grid)
cols <- ncol(grid)

start_pos <- which(grid == "S", arr.ind = TRUE)
current_pos <- c(start_pos[1], start_pos[2])

A <- 0 
B <- 0

reached_destination <- FALSE
cat("Simulation Started (Biased Random Walk via Die Roll)...\n")

while (!reached_destination) {
  die <- sample(1:6, 1)
  
  if (die %in% c(1, 2, 3)) {
    move <- c(-1, 0)
  } else if (die == 4) {
    move <- c(1, 0)
  } else if (die == 5) {
    move <- c(0, 1)  
  } else if (die == 6) {
    move <- c(0, -1) 
  }
  
  new_r <- current_pos[1] + move[1]
  new_c <- current_pos[2] + move[2]
  
  if (new_r < 1 || new_r > rows || new_c < 1 || new_c > cols) {
    B <- B + 1
    next
  }
  
  cell_value <- grid[new_r, new_c]
  
  if (cell_value == "1") {
    B <- B + 1
  } else {
    A <- A + 1 
    current_pos <- c(new_r, new_c)
    
    if (cell_value == "D") {
      reached_destination <- TRUE
    }
  }
}

total_moves <- A + B
ratio <- ifelse(total_moves > 0, A / total_moves, 0)

cat("\n--- Results ---\n")
cat("Destination 'D' reached!\n")
cat("Variable A (Successful moves):", A, "\n")
cat("Variable B (Failed moves):", B, "\n")
cat("Total attempts (A + B):", total_moves, "\n")
cat(sprintf("Ratio A / (A + B): %.4f\n", ratio))