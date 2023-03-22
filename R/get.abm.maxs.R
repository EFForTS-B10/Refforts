
#' Report maximum parameterisation:
#'
#' @description Report maximum parameterisation:
#'
#' @return A list with EFForTS-ABM maximum parameters
#'
#' @details
#'
#' Report maximum parameterisation
#'
#' @examples
#' get.abm.maxs()
#'
#' @aliases get.abm.maxs
#' @rdname get.abm.maxs
#'
#' @export

get.abm.maxs <- function() {

 # abm.table <- NULL
#  utils::data("abm.table", envir=environment())
  dat <- abm.table %>%
    dplyr::filter(group == "parameter") %>%
    dplyr::select(name, max)

  dat.list <- lapply(as.list(dat$max), utils::type.convert, as.is=TRUE)
  names(dat.list) <- dat$name

  return(dat.list)

}

