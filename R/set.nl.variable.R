
#' Set a variable in the exepriment of the provided nl object
#'
#' @description Set a variable in the exepriment of the provided nl object
#'
#' @param nl nl object
#' @param varname name of the variable that should be added
#' @param values a values vector, not needed if min, max and step or qfun are defined instead
#' @param min minimum value of variable
#' @param max maximum value of variable
#' @param step step interval between values
#' @param qfun distribution function
#'
#' @return nl object
#'
#' @details
#'
#' Set a variable in the exepriment of the provided nl object
#'
#' @examples
#' \dontrun{
#' set.nl.variable(nl, varname="testvar", min=1, max=5, step=0.1, qfun="qunif")
#' }
#'
#' @aliases set.nl.variable
#' @rdname set.nl.variable
#'
#' @export



set.nl.variable <- function(nl, varname, values=NULL, min=NULL, max=NULL, step=NULL, qfun=NULL)
{
  ## check if varname is already present:
  var.current <- nl@experiment@variables

  if(varname %in% names(var.current))
  {
    warning(paste0("Variable ", varname, " is already present in variables list. Values will be overwritten automatically!"))
  }

  var.current[[varname]] <- list("values" = values,
                               "min" = min,
                               "max" = max,
                               "step" = step,
                               "qfun" = qfun)

  nl@experiment@variables <- var.current

  # now remove the variable from constants, if it is listed there:
  if(varname %in% names(nl@experiment@constants))
  {
    warning(paste0("Variable ", varname, " was also found in the constants list of the nl object and will be removed automatically!"))
    constants.current <- nl@experiment@constants
    constants.current[[varname]] <- NULL
    nl@experiment@constants <- constants.current
  }

  return(nl)
}
