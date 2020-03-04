#' Cluster multiple GBM series
#'
#' @description Get parameter files from efforts-abm folder
#'
#' @param series tibble with at least 2 series of GBM price data
#' @param clusterlist list with cluster objects, derived from prices.GBM.cluster()
#'
#' @return a tibble with series data and cluster ids
#'
#' @details
#'
#' The function extracts cluster ids from the cluster objects from the prices.GBM.cluster function and joins them to the original series data.
#'
#'
#'
#'
#' @aliases prices.GBM.cluster.series
#' @rdname prices.GBM.cluster.series
#'
#' @export

prices.GBM.cluster.series <- function(series, clusterlist)
{

  clusterids <- purrr::map_dfr(names(clusterlist), function(x){
    tibble::tibble(series=unique(series$series), crop=x, cluster=clusterlist[[x]]@cluster)
  }) %>%
    dplyr::right_join(series, by=c("series", "crop"))

  return(clusterids)
}
