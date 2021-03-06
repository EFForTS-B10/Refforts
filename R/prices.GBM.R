#' Creates a single asset path of daily prices using Geometric Brownian Motion.
#'
#' @description Get parameter files from efforts-abm folder
#'
#' @param N Number of days in the path.
#' @param sigma Volatility or standard deviation of daily continuously compounded returns.
#' @param mu Drift or average daily continuously compounded returns.
#' @param S0 The initial price of the asset.
#' @param Wt The cumulative Brownian motion of the model. This can be supplied or left as NULL. In the case that it is NULL, a vector will be provided. If you include this argument, it must be a vector of length N of the cumulative sum of a random variable to work properly.
#'
#' @return A vector of length N containing the asset prices generated by the specified GBM
#'
#' @details
#'
#' Creates a single asset path of daily prices using Geometric Brownian Motion.
#'
#' @examples
#' \dontrun{
#' prices.GBM()
#' }
#'
#'
#' @aliases prices.GBM
#' @rdname prices.GBM
#'
#' @export

prices.GBM <- function(N, sigma, mu, S0, Wt = NULL) {
  if (is.null(Wt)) {
    Wt <- cumsum(stats::rnorm(N, 0, 1))
  }
  t <- (1:N)/252
  p1 <- (mu - 0.5*(sigma*sigma)) * t
  p2 <- sigma * Wt
  St = S0 * exp(p1 + p2)
  return(St)
}
