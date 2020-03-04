#' Get monthly price data as zoo object from included package data prices.wb
#'
#' @description Get parameter files from efforts-abm folder
#'
#' @param start.date start date of time series in format as.Date("yyyy-mm-dd")
#' @param end.date end date of time series as.Date("yyyy-mm-dd")
#'
#' @return a zoo object with price time series
#'
#' @details
#'
#' Loads monthly price data for the selected crop from the included data file prices.wb.
#' The prices are then converted into an zoo object.
#' Price data has been stored within the package and was downloaded from World Bank Data on March 3rd, 2020.
#' Prices for Oilpalm and Rubber were extracted and converted to prices in Dollar per ton from the Pink Sheet data (World Bank).
#'
#' @examples
#' \dontrun{
#' prices.zoo()
#' }
#'
#' @aliases prices.zoo
#' @rdname prices.zoo
#'
#' @export

prices.zoo <- function(start.date=as.Date("1960-01-01"), end.date=as.Date("2020-01-01")) {

  if(start.date < as.Date("1960-01-01") | end.date > as.Date("2020-01-01"))
  {
    stop(paste0("No data available for selected period. Data is available from ", dplyr::first(prices.wb$time), " to ", dplyr::last(prices.wb$time), "!"))
  }

  prices.op <- prices.wb %>%
    dplyr::filter(time >= start.date & time <= end.date) %>%
    dplyr::select(time, oilpalm)

  prices.rm <- prices.wb %>%
    dplyr::filter(time >= start.date & time <= end.date) %>%
    dplyr::select(time, rubber)

  prices.op.zoo <- zoo::read.zoo(prices.op, format = "%Y-%m-%d")
  prices.rm.zoo <- zoo::read.zoo(prices.rm, format = "%Y-%m-%d")

  prices <- merge(prices.op.zoo, prices.rm.zoo)

  return(prices)
}
