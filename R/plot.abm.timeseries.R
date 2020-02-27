
#' Plot EFForTS-ABM time series metrics
#'
#' @description Plot EFForTS-ABM time series metrics
#'
#' @param nl an nl object with attached simulation results containing time series data
#' @param metrics a vector of metrics which are plotted as a facet plot
#'
#' @return A ggplot object
#'
#' @details
#'
#' Plot EFForTS-ABM time series metrics
#'
#' @examples
#' \dontrun{
#' doplot.abm.timeseries
#' }
#'
#' @aliases doplot.abm.timeseries
#' @rdname doplot.abm.timeseries
#'
#' @export


doplot.abm.timeseries <- function(nl, metrics=nl@experiment@metrics)
{
  # Select variables, metrics and global stuff:
  # Then convert metrics to long format:
  res <- nl@simdesign@simoutput %>%
    dplyr::select(names(nl@experiment@variables), metrics, `[step]`, `random-seed`, siminputrow) %>%
    tidyr::pivot_longer(cols=metrics, names_to = "metric", values_to = "value") %>%
    tidyr::unite("scenario", siminputrow, names(nl@experiment@variables))


  p1 <- ggplot2::ggplot(res, ggplot2::aes(x=`[step]`, y=value, color=scenario, lty=factor(`random-seed`))) +
    ggplot2::facet_wrap(~metric, scales="free") +
    ggplot2::geom_line(size=1) +
    ggplot2::guides(color = ggplot2::guide_legend(title="siminputrow"), lty = ggplot2::guide_legend(title="random seed")) +
    ggthemes::scale_color_few(palette="Dark") +
    ggthemes::theme_few(base_size = 12)

  return(p1)
}
