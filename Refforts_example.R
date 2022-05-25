#############################################
## Refforts Example (version "landmarket") ##
#############################################

## Load packages
library(nlrx)
library(Refforts)

### Set up nl object ###
netlogoversion <- "6.1.1"
netlogopath <- file.path("/opt/netlogo-6.1.1")
file.exists(netlogopath)
modelpath <- ".../01_EFForTS-ABM/EFForTS-ABM.nlogo"
file.exists(modelpath)
outpath <- ".../output"
file.exists(outpath)

nl <- nl(
  nlversion = netlogoversion,
  nlpath = netlogopath,
  modelpath = modelpath,
  jvmmem = 1024
)

### Define function parameters ###
metrics <- Refforts::get.abm.metrics()
# Alternative: Define metrics manually
# metrics <- c(
#   "lut0.carbon", "lut1.carbon",
#   "lut0.price", "lut1.price",
#   "lut0.fraction", "lut1.fraction",
#   "lut0.yield.sum", "lut1.yield.sum", "lut0.yield.mean", "lut1.yield.mean",
#   "hh.count",
#   "hh.count.immigrant", # only relevant for version "landmarket" #versionspecific
#   "hh.area.sum", "hh.area.mean",
#   "hh.consumption.sum", "hh.consumption.mean",
#   "hh.lut0.ineff.mean", "hh.lut1.ineff.mean",
#   "p.tinput.sum", "p.tinput.mean",
#   "p.capitalstock.sum", "p.capitalstock.mean"
# )

constants <- Refforts::get.abm.defaults()
# Alternative: Define constants manually
# constants <- list(
#   "reproducible?" = "TRUE",
#   "rnd-seed" = 123,
#   "which-map" = "\"hundred-farmers3\"",
#   "land-use-change-decision" = "\"only-one-field-per-year\"",
#   "price_scenario" = "\"historical_trends\"",
#   "price-fluctuation-percent" = 10,
#   "historical_smoothing" = 0,
#   "LUT-0-folder" = "\"oilpalm\"",
#   "LUT-0-price" = 90,
#   "LUT-0-price-mu" = 1.9,
#   "LUT-0-price-sd" = 1.9,
#   "LUT-1-folder" = "\"rubber\"",
#   "LUT-1-price" = 1100,
#   "LUT-1-price-mu" = 11,
#   "LUT-1-price-sd" = 11,
#   "consumption-on?" = "TRUE",
#   "consumption_base" = 1000,
#   "consumption_frac_cash" = 0.1,
#   "consumption_frac_wealth" = 0.05,
#   "heterogeneous-hhs?" = "TRUE",
#   "learning-spillover?" = "FALSE",
#   "setup-hh-network" = "\"hh-nw-n-nearest-neighbors\"",
#   "hh-nw-param1" = 10,
#   "hh-nw-param2" = 50,
#   "spillover-share" = 1,
#   "h_debt_years_max_bankrupt" = 5,
#   "landmarket?" = "TRUE", # only relevant for version "landmarket" #versionspecific
#   "buyer_pool_n" = 10, # only relevant for version "landmarket" #versionspecific
#   "immigrant_probability" = 0.5, # only relevant for version "landmarket" #versionspecific
#   "land_price_increase" = 0.05, # only relevant for version "landmarket" #versionspecific
#   "immigrant-xp-bonus" = "\"[0 0]\"", # only relevant for version "landmarket" #versionspecific
#   "immigrant-wealth-factor" = 1, # only relevant for version "landmarket" #versionspecific
#   "initial-wealth-distribution" = "\"log-normal\"",
#   "init-wealth-correction-factor" = 10,
#   "wealth-log-mean" = 7,
#   "wealth-log-sd" = 1,
#   "wealth-constant" = 10000,
#   "min-wealth" = 30,
#   "time-horizon" = 10,
#   "discount-rate" = 0.1,
#   "land_price" = 750,
#   "external_income" = 500,
#   "rent_rate_capital_lend" = 0.1,
#   "rent_rate_capital_borrow" = 0.15,
#   "rent_rate_land" = 0.1,
#   "hh_age_alpha" = 14.24, # only relevant for version "landmarket" #versionspecific
#   "hh_age_lambda" = 0.31, # only relevant for version "landmarket" #versionspecific
#   "hh_age_min" = 18, # only relevant for version "landmarket" #versionspecific
#   "hh_age_max" = 80, # only relevant for version "landmarket" #versionspecific
#   "age_generation" = 40, # only relevant for version "landmarket" #versionspecific
#   "takeover_prob" = 0.5, # only relevant for version "landmarket" #versionspecific
#   "write-maps?" = "FALSE",
#   "write-hh-data-to-file?" = "FALSE",
#   "export-view?" = "FALSE",
#   "show-homebases?" = "TRUE",
#   "show-roads?" = "TRUE"
# )

# The simulation length is defined by experiment(runtime = ...),
# therefore the parameter sim-time is not needed!

nl@experiment <- experiment(
  expname = "test",
  outpath = outpath,
  repetition = 1,
  tickmetrics = "true",
  idsetup = c("ca", "setup-with-external-maps"),
  idgo = c("go", "update-time"), # "do-plots" is not needed
  runtime = 50, # number of ticks
  metrics = metrics,
  constants = constants
)

## Add simple simdesign
nl@simdesign <- simdesign_simple(nl, nseeds = 1)
print(nl)

## Run simulations:
results <- run_nl_all(nl)

## Attach output:
setsim(nl, "simoutput") <- results

## Have a look at results:
names(results)
results$hh.count.immigrant
