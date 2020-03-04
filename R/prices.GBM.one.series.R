#' Generate one series of price data using GBM
#'
#' @description Get parameter files from efforts-abm folder
#'
#' @param years number of years for which stoachstic time series should be generated
#' @param start.date start date of time series in format as.Date("yyyy-mm-dd")
#' @param end.date end date of time series as.Date("yyyy-mm-dd")
#' @param id of current time series
#'
#' @return a zoo object with price time series
#'
#' @details
#'
#' This function uses historic price data to estimate properties of these time series.
#' These properties are then used to generate stoachstic price data using geometric brownian motion.
#'
#'
#'
#' @aliases prices.GBM.one.series
#' @rdname prices.GBM.one.series
#'
#' @export

prices.GBM.one.series <- function(years=50, start.date=as.Date("1960-01-01"), end.date=as.Date("2020-01-01"), id=1)
{
  N <- years * 12 # 50 years, each with 12 month
  t <- (1:N)/12 # 50 years with 12 month
  prices <- prices.zoo(start.date = start.date, end.date = end.date)

  # get the cc returns and vectors of average returns and volaitiliy
  returns <- as.matrix(stats::na.omit(diff(log(prices))))
  mu <- as.numeric(colMeans(returns))
  sigma <- as.numeric(sqrt(apply(returns, 2, stats::var)))
  S0 <- as.numeric(prices[1]) # we use start prices of the period
  #S0 <- as.numeric(prices[nrow(prices)]) # we use start prices of the period
  cor.mat <-as.matrix(stats::cor(returns))

  # make correlated asset paths
  paths <- tibble::as.tibble(prices.GBM.cor(N = N, S0 = S0, mu = mu, sigma = sigma, cor.mat = cor.mat)) %>%
    dplyr::mutate(time = 1:nrow(.)) %>%
    dplyr::rename(oilpalm = V1, rubber = V2) %>%
    tidyr::pivot_longer(cols=c(oilpalm, rubber), names_to = "crop", values_to = "price") %>%
    dplyr::mutate(series=id) %>%
    dplyr::select(series, time, crop, price)

  return(paths)
}
