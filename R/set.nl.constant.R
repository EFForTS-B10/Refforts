
#' Set a constant in the exepriment of the provided nl object
#'
#' @description Set a constant in the exepriment of the provided nl object
#'
#' @param nl nl object
#' @param constname name of constant which should be updated
#' @param value value for constant
#'
#' @return nl object
#'
#' @details
#'
#' Set a constant in the exepriment of the provided nl object
#'
#' @examples
#' \dontrun{
#' set.nl.constant(nl, varname="testconst", value=1)
#' }
#'
#' @aliases set.nl.constant
#' @rdname set.nl.constant
#'
#' @export



set.nl.constant <- function(nl, constname, value)
{
  ## check if varname is already present:
  const.current <- nl@experiment@constants

  if(constname %in% names(const.current))
  {
    warning(paste0("Constant ", constname, " is already present in constants list. Value will be overwritten automatically!"))
  }

  const.current[[constname]] <- value

  nl@experiment@constants <- const.current

  # now remove the variable from constants, if it is listed there:
  if(constname %in% names(nl@experiment@variables))
  {
    warning(paste0("Constant ", constname, " was also found in the variables list of the nl object and will be removed automatically!"))
    variables.current <- nl@experiment@variables
    variables.current[[constname]] <- NULL
    nl@experiment@variables <- variables.current
  }

  return(nl)
}
