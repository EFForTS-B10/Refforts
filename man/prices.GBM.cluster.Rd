% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prices.GBM.cluster.R
\name{prices.GBM.cluster}
\alias{prices.GBM.cluster}
\title{Cluster multiple GBM series}
\usage{
prices.GBM.cluster(
  series,
  type = "partitional",
  k = 20L,
  distance = "dtw_basic",
  centroid = "pam",
  seed = 3247L,
  trace = TRUE,
  window.size = 20L
)
}
\arguments{
\item{series}{tibble with at least 2 series of GBM price data}

\item{type}{dtwclust parameter type}

\item{k}{dtwclust parameter k}

\item{distance}{dtwclust parameter distance}

\item{centroid}{dtwclust parameter centroid}

\item{seed}{dtwclust parameter seed}

\item{trace}{dtwclust parameter trace}

\item{window.size}{dtwclust parameter window.size}
}
\value{
a cluster object
}
\description{
Get parameter files from efforts-abm folder
}
\details{
This function uses the dtwclust package to cluster multiple time series.
The input object can be generated by nesting several calls to prices.GBM.one.series() - see example.
}
\examples{

\dontrun{

n.series <- 100
path.series <- purrr::map_dfr(1:n.series, function(x){
  prices.GBM.one.series(years=50, id=x)
  })
}


}
