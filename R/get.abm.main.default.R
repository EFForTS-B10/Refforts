
#' Get a skeleton for the main parameter file of EFForTS-ABM
#'
#' @description Get a skeleton for the main parameter file of EFForTS-ABM
#'
#' @param crop optionally, select a crop type for defaults
#'
#' @return a list with the parameter format of the main parameter file
#'
#' @details
#'
#' Get a skeleton for the main parameter file of EFForTS-ABM
#'
#' @examples
#' get.abm.main.default(crop="rubber")
#'
#' @aliases get.abm.main.default
#' @rdname get.abm.main.default
#'
#' @export

get.abm.main.default <- function(crop=NULL)
{

  if (is.null(crop))
  {
    main <- list("landuse" = "landuse xy",
                 "inefficiency_alpha" = 0,
                 "inefficiency_lambda" = 0,
                 "depriciation_rate_young" = 0,
                 "depriciation_rate_old" = 0,
                 "depriciation_rate_switch" = 0,
                 "max_age" = 0,
                 "yield_function" = "[a -> lut_function_yield_oilpalm a]",
                 "carbon_function" = "[a -> lut_function_carbon_oilpalm a]",
                 "prices" = "[0 0]")
  }
  if(crop=="oilpalm")
  {
    main <- list("landuse" = "oilpalm",
                 "inefficiency_alpha" = 3.168,
                 "inefficiency_lambda" = 0.069,
                 "depriciation_rate_young" = -0.1,
                 "depriciation_rate_old" = 0.1,
                 "depriciation_rate_switch" = 10,
                 "max_age" = 25,
                 "yield_function" = "[a -> lut_function_yield_oilpalm a]",
                 "carbon_function" = "[a -> lut_function_carbon_oilpalm a]",
                 "prices" = "[110.4265186 117.2560383 132.1780035 110.2258817 103.6134211 78.97439936 80.41511905 108.5456568 103.5659118 79.04707803 118.4444829 172.2406675 100.6414827 93.09292488 112.279975 109.4334153 106.8430507 86.71566971 84.68391343 68.07561194 78.78228157 117.0887798 81.26734749 36.27539499 44.12632553 52.87703564 42.63976658 33.96151143 40.10286268 45.69597558 42.40370398 61.15327854 66.22869382 57.05514457 61.55720572 79.13746494 52.4229838 37.78704493 36.14812655 49.96542135 53.94628324 53.71553556 46.63382959 51.54510381 79.22715037 89.38074506 68.59332381 87.29077124 100.102921 90 78.2906484 75.17813221]")
  }


  if(crop=="rubber")
  {
    main <- list("landuse" = "rubber",
                 "inefficiency_alpha" = 3.445,
                 "inefficiency_lambda" = 0.093,
                 "depriciation_rate_young" = -0.05,
                 "depriciation_rate_old" = 0.05,
                 "depriciation_rate_switch" = 15,
                 "max_age" = 30,
                 "yield_function" = "[a -> lut_function_yield_rubber a]",
                 "carbon_function" = "[a -> lut_function_carbon_rubber a]",
                 "prices" = "[936.2777856 868.6767338 885.5715161 797.7484154 654.2350013 646.4374475 806.4138059 614.6540206 477.3383328 436.5650795 769.280586 699.7738209 470.2251997 640.7769637 624.1525409 649.7782415 745.8799753 765.3942667 602.6007523 474.4264919 604.6883223 556.4034636 445.4618454 411.7198385 458.67955 518.3415747 426.8280796 366.5359797 353.2880792 361.8482403 337.4771345 471.1947481 602.3906065 541.6913328 415.0078713 307.7394107 273.2871506 293.8815267 263.1991193 354.1826328 476.5637424 527.7216356 594.5683233 810.0952362 831.0592075 881.364227 697.7814902 1280.478609 1551.532108 1100 923.3988399 647.6232218]")
  }

  if(crop=="junglerubber")
  {
    main <- list("landuse" = "junglerubber",
                 "inefficiency_alpha" = 3.445,
                 "inefficiency_lambda" = 0.093,
                 "depriciation_rate_young" = -0.05,
                 "depriciation_rate_old" = 0.05,
                 "depriciation_rate_switch" = 15,
                 "max_age" = 30,
                 "yield_function" = "[a -> lut_function_yield_junglerubber a]",
                 "carbon_function" = "[a -> lut_function_carbon_junglerubber a]",
                 "prices" = "[936.2777856 868.6767338 885.5715161 797.7484154 654.2350013 646.4374475 806.4138059 614.6540206 477.3383328 436.5650795 769.280586 699.7738209 470.2251997 640.7769637 624.1525409 649.7782415 745.8799753 765.3942667 602.6007523 474.4264919 604.6883223 556.4034636 445.4618454 411.7198385 458.67955 518.3415747 426.8280796 366.5359797 353.2880792 361.8482403 337.4771345 471.1947481 602.3906065 541.6913328 415.0078713 307.7394107 273.2871506 293.8815267 263.1991193 354.1826328 476.5637424 527.7216356 594.5683233 810.0952362 831.0592075 881.364227 697.7814902 1280.478609 1551.532108 1100 923.3988399 647.6232218]")
  }

  return(main)
}
