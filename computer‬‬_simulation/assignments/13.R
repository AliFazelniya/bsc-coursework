f <- function(x) x^2 - 3*x + 11

a <- -4
b <- 5

n_trap <- 10000
x_trap <- seq(a, b, length.out = n_trap)
y_trap <- f(x_trap)
dx <- (b - a) / (n_trap - 1)
area_trapezoidal <- sum((y_trap[-1] + y_trap[-n_trap]) / 2) * dx

set.seed(42)
N_mc <- 1000000
max_y <- max(f(a), f(b)) 
box_area <- (b - a) * max_y
rx <- runif(N_mc, a, b)
ry <- runif(N_mc, 0, max_y)
points_under_curve <- sum(ry <= f(rx))
area_mc <- (points_under_curve / N_mc) * box_area

cat("--- Exercise 1 Results ---\n")
cat("Trapezoidal Area:", area_trapezoidal, "\n")
cat("Monte Carlo Area:", area_mc, "\n\n")


calc_intersection_area <- function(x1, y1, r1, x2, y2, r2, N_mc = 1000000) {
  x_min <- min(x1 - r1, x2 - r2)
  x_max <- max(x1 + r1, x2 + r2)
  y_min <- min(y1 - r1, y2 - r2)
  y_max <- max(y1 + r1, y2 + r2)
  
  box_area <- (x_max - x_min) * (y_max - y_min)
  
  rx <- runif(N_mc, x_min, x_max)
  ry <- runif(N_mc, y_min, y_max)
  
  in_circle1 <- (rx - x1)^2 + (ry - y1)^2 <= r1^2
  in_circle2 <- (rx - x2)^2 + (ry - y2)^2 <= r2^2
  
  in_intersection <- in_circle1 & in_circle2
  
  area <- (sum(in_intersection) / N_mc) * box_area
  return(area)
}

set.seed(42)
area_intersection <- calc_intersection_area(x1=0, y1=0, r1=5, x2=6, y2=0, r2=3)

cat("--- Exercise 2 Result ---\n")
cat("Estimated Intersection Area (Sample Data):", area_intersection, "\n")