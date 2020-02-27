#' Report turtles metrics as a list
#'
#' @description Report turtles metrics as a list
#'
#' @return turtles metrics as a list
#'
#' @details
#'
#' Report turtles metrics as a list
#'
#' @examples
#' get.abm.metrics.turtles()
#'
#' @aliases get.abm.metrics.turtles
#' @rdname get.abm.metrics.turtles
#'
#' @export

get.abm.metrics.turtles <- function() {

  dat <- abm.table %>%
    dplyr::filter(group == "variable") %>%
    dplyr::filter(type == "turtles") %>%
    dplyr::select(name)

  metrics <- list("hhs" = dat$name)

  return(metrics)

}

