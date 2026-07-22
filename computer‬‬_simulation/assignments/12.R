estimate_pi <- function(N = 1000000, r = 1) {
  x <- runif(N, min = 0, max = r)
  y <- runif(N, min = 0, max = r)
  
  inside <- (x^2 + y^2) <= (r^2)
  n <- sum(inside)
  
  pi_est <- 4 * n / N
  
  return(list(
    Total_Points_N = N,
    Points_Inside_Circle_n = n,
    Estimated_Pi = pi_est,
    Absolute_Error = abs(pi_est - pi)
  ))
}

set.seed(42)
result <- estimate_pi(N = 1000000)
print(result)