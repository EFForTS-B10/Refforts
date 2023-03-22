
#' Report default parameterisation:
#'
#' @description Report default parameterisation:
#'
#' @return A list with EFForTS-ABM default parameters
#'
#' @details
#'
#' Report default parameterisation
#'
#' @examples
#' get.abm.defaults()
#'
#' @aliases get.abm.defaults
#' @rdname get.abm.defaults
#'
#' @export

get.abm.defaults <- function() {

 # abm.table <- NULL
#  utils::data("abm.table", envir=environment())
  dat <- abm.table %>%
    dplyr::filter(group == "parameter") %>%
    dplyr::select(name, default)

  dat.list <- lapply(as.list(dat$default), utils::type.convert, as.is=TRUE)
  names(dat.list) <- dat$name

  return(dat.list)

}

