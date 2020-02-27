
#' Get a skeleton for the management parameter file of EFForTS-ABM
#'
#' @description Get a skeleton for the management parameter file of EFForTS-ABM
#'
#' @param crop optionally, select a crop type for defaults
#' @param n number of management skeletons
#'
#' @return a list with the parameter format of the main parameter file
#'
#' @details
#'
#' Get a skeleton for the management parameter file of EFForTS-ABM
#'
#' @examples
#' get.abm.management.default(crop="rubber")
#'
#' @aliases get.abm.management.default
#' @rdname get.abm.management.default
#'
#' @export

get.abm.management.default <- function(crop=NULL, n=1)
{

  if (is.null(crop))
  {
    management <- list("landuse" = "landuse xy",
                       "management" = "management xy",
                       "labor_function" = "[a -> lut_function_labor_oilpalm a]",
                       "tinput_function" = "[a -> lut_function_tinput_oilpalm a]",
                       "invest_function" = "[a -> lut_function_invest_oilpalm a]",
                       "price_tinput" = 0,
                       "wages" = 0,
                       "yield_factor" = 0,
                       "external_income_factor" = 0)

  }

  if(crop=="oilpalm")
  {
    management <- list("landuse" = "oilpalm",
                       "management" = "conventional",
                       "labor_function" = "[a -> lut_function_labor_oilpalm a]",
                       "tinput_function" = "[a -> lut_function_tinput_oilpalm a]",
                       "invest_function" = "[a -> lut_function_invest_oilpalm a]",
                       "price_tinput" = 0.5,
                       "wages" = 1.6,
                       "yield_factor" = 1,
                       "external_income_factor" = 1)
  }

  if(crop=="rubber")
  {
    management <- list("landuse" = "rubber",
                       "management" = "conventional",
                       "labor_function" = "[a -> lut_function_labor_rubber a]",
                       "tinput_function" = "[a -> lut_function_tinput_rubber a]",
                       "invest_function" = "[a -> lut_function_invest_rubber a]",
                       "price_tinput" = 0.5,
                       "wages" = 1.6,
                       "yield_factor" = 1,
                       "external_income_factor" = 1)
  }

  if(crop=="junglerubber")
  {
    management <- list("landuse" = "junglerubber",
                       "management" = "conventional",
                       "labor_function" = "[a -> lut_function_labor_junglerubber a]",
                       "tinput_function" = "[a -> lut_function_tinput_junglerubber a]",
                       "invest_function" = "[a -> lut_function_invest_junglerubber a]",
                       "price_tinput" = 0.5,
                       "wages" = 1.6,
                       "yield_factor" = 1,
                       "external_income_factor" = 1)

  }

  management <- rep(list(management), n)

  return(management)
}
