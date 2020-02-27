#' Report patches metrics as a list
#'
#' @description Report patches metrics as a list
#'
#' @return patches metrics as a list
#'
#' @details
#'
#' Report patches metrics as a list
#'
#' @examples
#' get.abm.metrics.patches()
#'
#' @aliases get.abm.metrics.patches
#' @rdname get.abm.metrics.patches
#'
#' @export

get.abm.metrics.patches <- function() {

  dat <- abm.table %>%
    dplyr::filter(group == "variable") %>%
    dplyr::filter(type == "patches") %>%
    dplyr::select(name)

  metrics <- c(dat$name)

  return(metrics)

}

