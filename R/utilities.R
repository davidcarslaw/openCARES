bootMean <- function(x, conf.int = 0.95, B = 1000, ...) {
  x <- x[!is.na(x)] # remove missings
  n <- length(x)
  xbar <- mean(x)
  if (n < 2) {
    return(c(Mean = xbar, Lower = NA, Upper = NA))
  }
  z <- unlist(lapply(1:B, function(i, x, N)
    sum(x[(sample.int(N, N, TRUE, NULL))]), x = x, N = n)) / n
  quant <- quantile(z, c((1 - conf.int) / 2, (1 + conf.int) / 2))
  names(quant) <- NULL
  res <- c(Mean = xbar, Lower = quant[1], Upper = quant[2])
  
  res
}


#' Bootstrap confidence intervals in the mean
#'
#' A utility function to calculation the uncertainty intervals in the mean of a
#' vector. The function removes any missing data before the calculation.
#'
#' @param x A vector from which the mean and bootstrap confidence intervals in
#'   the mean are to be calculated
#' @param conf.int The confidence interval; default = 0.95.
#' @param B The number of bootstrap simulations
#'
#' @return Returns a data frame with the mean, lower uncertainty, upper
#'   uncertainty and number of values used in the calculation
#' @export
#'
#' @examples
#' test <- rnorm(20, mean = 10)
#' bootMeanDF(test)
bootMeanDF <- function(x, conf.int = 0.95, B = 1000) {
  if (!is.vector(x)) {
    stop("x should be a vector.")
  }
  
  res <- bootMean(x = x, conf.int = conf.int, B = B)
  res <- data.frame(mean = res[1], min = res[2], max = res[3], n = length(na.omit(x)))
  res <- return(res)
}
