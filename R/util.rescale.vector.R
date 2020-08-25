
#' Scale a vector of values to a new min and max range (defaults to 0-1 range)
#'
#' @description Scale a vector of values to a new min and max range (defaults to 0-1 range)
#'
#' @param values vector of values to scale
#' @param new.min new minimum to scale values to
#' @param new.max new maximum to scale values to
#'
#' @return vector of re-scaled values
#'
#' @details
#'
#' Scale a vector of values to a new min and max range (defaults to 0-1 range)
#'
#' @examples
#' \dontrun{
#' tibble::tibble(a=c(3, 2523, 223, 342, 33, 26, 85, 75)) %>%
#' dplyr::mutate(b = util.rescale.vector(a))
#' }
#'
#' @aliases util.rescale.vector
#' @rdname util.rescale.vector
#'
#' @export


util.rescale.vector <- function(values, new.min = 0, new.max = 1)
{

  values.min <- min(values)
  values.max <- max(values)

  values.rescaled <- (((values - values.min) * (new.max - new.min)) / (values.max - values.min)) + new.min

  return(values.rescaled)


}
