evaluate_generator <- function(seed, a, c, m, n) {
  x <- numeric(n)
  x[1] <- seed
  
  for (i in 2:n) {
    x[i] <- (a * x[i-1] + c) %% m
  }
  
  u <- x / m
  
  unique_count <- length(unique(x))
  
  return(list(
    Total_Generated = n,
    Unique_Numbers = unique_count,
    Period_Reached = unique_count < n
  ))
}

set.seed(42)

result_1 <- evaluate_generator(seed = 7, a = 5, c = 3, m = 16, n = 100)
print("Test 1 (Small m):")
print(result_1)

result_2 <- evaluate_generator(seed = 123, a = 1664525, c = 1013904223, m = 2^15, n = 40000)
print("Test 2 (Larger m):")
print(result_2)