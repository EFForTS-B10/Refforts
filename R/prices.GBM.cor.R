#' Creates a matrix of correlated daily price paths using Geometric Brownian Motion.
#'
#' @description Get parameter files from efforts-abm folder
#'
#' @param N Number of days in the path.
#' @param sigma Volatility or standard deviation of daily continuously compounded returns.
#' @param mu Drift or average daily continuously compounded returns.
#' @param S0 The initial price of the asset.
#' @param cor.mat The correlation matrix of the daility contiuously compounded returns.
#'
#' @return A matrix of simulated daily price paths of length N having the same number of assets as in the mu and sigma vectors. Note that mu and sigma must have the same dimensions.
#'
#' @details
#'
#' Creates a matrix of correlated daily price paths using Geometric Brownian Motion.
#'
#'
#' @aliases prices.GBM.cor
#' @rdname prices.GBM.cor
#'
#' @export

prices.GBM.cor <- function(N, S0, mu, sigma, cor.mat) {
  mu <- as.matrix(mu)
  sigma <- as.matrix(sigma)
  GBMs <- matrix(nrow = N, ncol = nrow(mu))
  Wt <- matrix(stats::rnorm(N * nrow(mu), 0, 1), ncol = nrow(mu))
  Wt <- apply(Wt, 2, cumsum)
  chol.mat <- chol(cor.mat) # upper triangular cholesky decomposition
  Wt <- Wt %*% chol.mat   # key trick for creating correlated paths
  for (i in 1:nrow(mu)) {
    GBMs[,i] <- prices.GBM(N, sigma[i], mu[i] , S0[i], Wt[, i])
  }
  return(GBMs)
}
