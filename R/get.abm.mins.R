
#' Report minimum parameterisation:
#'
#' @description Report minimum parameterisation:
#'
#' @return A list with EFForTS-ABM minimum parameters
#'
#' @details
#'
#' Report minimum parameterisation
#'
#' @examples
#' get.abm.mins()
#'
#' @aliases get.abm.mins
#' @rdname get.abm.mins
#'
#' @export

get.abm.mins <- function() {

 # abm.table <- NULL
#  utils::data("abm.table", envir=environment())
  dat <- abm.table %>%
    dplyr::filter(group == "parameter") %>%
    dplyr::select(name, min)

  dat.list <- lapply(as.list(dat$min), utils::type.convert, as.is=TRUE)
  names(dat.list) <- dat$name

  return(dat.list)

}

