#' Report all metrics as a vector
#'
#' @description Report all metrics as a vector
#'
#' @return all metrics as a vector
#'
#' @details
#'
#' Report all metrics as a vector
#'
#' @examples
#' get.abm.metrics()
#'
#' @aliases get.abm.metrics
#' @rdname get.abm.metrics
#'
#' @export

get.abm.metrics <- function() {

#  abm.table <- NULL
#  utils::data("abm.table", envir=environment())
  dat <- abm.table %>%
    dplyr::filter(group == "variable") %>%
    dplyr::filter(type == "global") %>%
    dplyr::select(name)

  metrics <- c(dat$name)

  return(metrics)

}

