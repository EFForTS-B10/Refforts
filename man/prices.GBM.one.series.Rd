% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prices.GBM.one.series.R
\name{prices.GBM.one.series}
\alias{prices.GBM.one.series}
\title{Generate one series of price data using GBM}
\usage{
prices.GBM.one.series(
  years = 50,
  start.date = as.Date("1960-01-01"),
  end.date = as.Date("2020-01-01"),
  id = 1
)
}
\arguments{
\item{years}{number of years for which stoachstic time series should be generated}

\item{start.date}{start date of time series in format as.Date("yyyy-mm-dd")}

\item{end.date}{end date of time series as.Date("yyyy-mm-dd")}

\item{id}{of current time series}
}
\value{
a zoo object with price time series
}
\description{
Get parameter files from efforts-abm folder
}
\details{
This function uses historic price data to estimate properties of these time series.
These properties are then used to generate stoachstic price data using geometric brownian motion.
}
