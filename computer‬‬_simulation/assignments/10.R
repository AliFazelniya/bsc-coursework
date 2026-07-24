generate_mid_product <- function(s1, s2, s3, n) {
  x <- numeric(n)
  x[1:3] <- c(s1, s2, s3)
  for (i in 4:n) {
    p <- x[i-1] * x[i-2] * x[i-3]
    p_str <- sprintf("%012.0f", p)
    x[i] <- as.numeric(substr(p_str, 5, 8))
  }
  return(x / 10000)
}

set.seed(Sys.time())
seeds <- sample(1000:9999, 3)
vals <- generate_mid_product(seeds[1], seeds[2], seeds[3], 1000)

cat("Seeds:", seeds, "\n")
cat("Unique values generated:", length(unique(vals)), "out of 1000\n")
cat("Mean:", mean(vals), "\n")


args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)

if (length(file_arg) > 0) {

  script_path <- sub("^--file=", "", file_arg[1])
  script_dir <- dirname(script_path)
} else {

  script_dir <- getwd()
}

file_path <- file.path(script_dir, "10_scatter_plot.pdf")

pdf(file_path, width = 8, height = 6)

plot(vals, 
     main = "values scatter plot", 
     xlab = "index", 
     ylab = "value", 
     col = "blue",    
     pch = 16,       
     cex = 0.7)       


invisible(dev.off())