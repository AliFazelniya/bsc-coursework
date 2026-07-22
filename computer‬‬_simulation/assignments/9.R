decode <- function(chrom, min_val = -10, max_val = 10) {
  len <- length(chrom)
  decimal <- sum(chrom * 2^(0:(len - 1)))
  min_val + (max_val - min_val) * decimal / (2^len - 1)
}

run_ga_part_a <- function(pop_size = 20, chrom_len = 16, max_iter = 1000) {
  pop <- matrix(sample(c(0, 1), pop_size * chrom_len, replace = TRUE), nrow = pop_size, ncol = chrom_len)
  for (iter in 1:max_iter) {
    vals <- apply(pop, 1, decode)
    if (any(abs(vals) <= 0.25)) return(iter)
    fitness <- 1 / (1 + abs(vals))
    prob <- fitness / sum(fitness)
    selected_indices <- sample(1:pop_size, pop_size, replace = TRUE, prob = prob)
    pop <- pop[selected_indices, ]
    new_pop <- pop
    for (i in seq(1, pop_size - 1, by = 2)) {
      if (runif(1) < 0.8) {
        pt <- sample(1:(chrom_len - 1), 1)
        new_pop[i, (pt + 1):chrom_len] <- pop[i + 1, (pt + 1):chrom_len]
        new_pop[i + 1, (pt + 1):chrom_len] <- pop[i, (pt + 1):chrom_len]
      }
    }
    for (i in 1:pop_size) {
      if (runif(1) < 0.1) {
        m_pt <- sample(1:chrom_len, 1)
        new_pop[i, m_pt] <- 1 - new_pop[i, m_pt]
      }
    }
    pop <- new_pop
  }
  return(max_iter)
}

run_ga_part_b <- function(pop_size = 20, chrom_len = 16, max_iter = 1000) {
  pop <- matrix(sample(c(0, 1), pop_size * chrom_len, replace = TRUE), nrow = pop_size, ncol = chrom_len)
  for (iter in 1:max_iter) {
    vals <- apply(pop, 1, decode)
    if (any(abs(vals) <= 0.25)) return(iter)
    fitness <- 1 / (1 + abs(vals))
    prob <- fitness / sum(fitness)
    selected_indices <- sample(1:pop_size, pop_size, replace = TRUE, prob = prob)
    pop <- pop[selected_indices, ]
    new_pop <- pop
    for (i in seq(1, pop_size - 1, by = 2)) {
      if (runif(1) < 0.8) {
        z <- rnorm(1)
        pt <- round(chrom_len / 2 + z * (chrom_len / 6))
        pt <- max(1, min(chrom_len - 1, pt))
        new_pop[i, (pt + 1):chrom_len] <- pop[i + 1, (pt + 1):chrom_len]
        new_pop[i + 1, (pt + 1):chrom_len] <- pop[i, (pt + 1):chrom_len]
      }
    }
    for (i in 1:pop_size) {
      if (runif(1) < 0.1) {
        z <- rnorm(1)
        m_pt <- round(chrom_len / 2 + z * (chrom_len / 6))
        m_pt <- max(1, min(chrom_len, m_pt))
        new_pop[i, m_pt] <- 1 - new_pop[i, m_pt]
      }
    }
    pop <- new_pop
  }
  return(max_iter)
}

set.seed(42)

results_a <- numeric(10)
results_b <- numeric(10)

for (k in 1:10) {
  results_a[k] <- run_ga_part_a()
  results_b[k] <- run_ga_part_b()
}

cat("Results Part A (Uniform Distribution):\n")
print(results_a)
cat("Average Iterations (Part A):", mean(results_a), "\n\n")

cat("Results Part B (Normal Distribution):\n")
print(results_b)
cat("Average Iterations (Part B):", mean(results_b), "\n")