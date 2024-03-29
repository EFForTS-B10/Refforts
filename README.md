
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Refforts

<!-- badges: start -->
<!-- badges: end -->

The Refforts package is intended to provide scripts for analyzing the
EFForTS model suite. In particular, EFForTS-ABM and EFForTS-LGraf.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("EFForTS-B10/Refforts@main")
```

If another Refforts version is already installed, you’ll need to restart
the R session:  
Tab “Session” -\> “Restart R”

## Using functions with nlrx

A list of default EFForTS-ABM parameters can be reported with:

``` r
get.abm.defaults()
```
A list of minimum EFForTS-ABM parameters can be reported with:
``` r
get.abm.mins()
```
A list of maximum EFForTS-ABM parameters can be reported with:
``` r
get.abm.maxs()
```
The underlying data can also be accessed as tibble:

``` r
View(abm.table)
```

A vector of global metrics, patches metrics and a list of turtles
metrics

``` r
get.abm.metrics()
get.abm.metrics.patches()
get.abm.metrics.turtles()
```

#### Example 1: Simple example

Here we just run a simple scenario with nlrx. So first we set up our nl
object

``` r
library(nlrx)

netlogopath <- file.path("C:/Program Files/NetLogo 6.1.0")
modelpath <- "01_EFForTS-ABM/EFForTS-ABM.nlogo"
outpath <- "03_Analyses/"

nl <- nl(
  nlversion = "6.1.0",
  nlpath = netlogopath,
  modelpath = modelpath,
  jvmmem = 1024
)
```

Then, we use the functions of the Refforts package to define the
parameters of the experiment:

``` r
nl@experiment <- experiment(
  expname = "invest",
  outpath = outpath,
  repetition = 1,
  tickmetrics = "true",
  idsetup = c("ca", "setup-with-external-maps"),
  idgo = c("go", "update-time"),
  runtime = 50, # number of ticks
  metrics = get.abm.metrics(),
  constants = get.abm.defaults()
)
```

Now we can use the other utility functions to change the default
settings and transfer parameters from the constants to the variables
slot:

``` r
nl <- set.nl.constant(nl, "price_scenario", "constant_prices")
nl <- set.nl.variable(nl, varname = "LUT-0-price", min = 100, max = 1000, qfun = "qunif")
nl <- set.nl.variable(nl, varname = "LUT-1-price", min = 500, max = 5000, qfun = "qunif")

## Add a latin hypercube simdesign:
nl@simdesign <- simdesign_lhs(nl, samples = 100, nseeds = 1)
```

#### Example 2: Landmarket labor analysis setup

We use the same setup as in Example 1:

``` r
library(nlrx)

netlogopath <- file.path("C:/Program Files/NetLogo 6.1.0")
modelpath <- "01_EFForTS-ABM/EFForTS-ABM.nlogo"
outpath <- "03_Analyses/"

nl <- nl(
  nlversion = "6.1.0",
  nlpath = netlogopath,
  modelpath = modelpath,
  jvmmem = 1024
)

nl@experiment <- experiment(
  expname = "invest",
  outpath = outpath,
  repetition = 1,
  tickmetrics = "true",
  idsetup = c("ca", "setup-with-external-maps"),
  idgo = c("go", "update-time"),
  runtime = 50,
  metrics = get.abm.metrics(),
  constants = get.abm.defaults()
)
```

Then we define variable vectors for a dstinct simulation design:

``` r
### now we might want to move a parameter from const to variable:
nl <- set.nl.variable(
  nl = nl,
  varname = "LUT-0-folder",
  values = rep(c("\"oilpalm_labor_min\"", "\"oilpalm_labor_med\"", "\"oilpalm_labor_high\""), 2)
)

nl <- set.nl.variable(
  nl = nl,
  varname = "LUT-1-folder",
  values = rep(c("\"rubber_labor_min\"", "\"rubber_labor_med\"", "\"rubber_labor_high\""), 2)
)

nl <- set.nl.variable(
  nl = nl,
  varname = "historical_smoothing",
  values = c(rep(0, 3), rep(3, 3))
)
```

We can then run and store everything:

``` r
nl@simdesign <- simdesign_distinct(nl = nl, nseeds = 1)

## Run simulations:
library(future)
plan(multisession)
results <- run_nl_all(nl, split = 6)

## Attach output:
setsim(nl, "simoutput") <- results
saveRDS(nl, file = file.path(outpath, "sims_wages_smoothing.rds"))
```

#### Example 3: Update parameter files

Finally, the package is useful to update the parameters of EFForTS-ABM
that are hidden in parameterfiles.

First, we might want to scan our parameter folder for existing
specifications:

``` r
parfiles <- get.abm.parfiles(dirname(nl@modelpath))
```

But we can also add new parameterfiles:

We first load a skeleton of a main parameter file with
`get.abm.main.default()`. We can also load a management skeleton with n
different managements with `get.abm.management.default()`. We can then
change the entries in the list to our needs. For example, here we
decrease the wages for management 1 and increase the maximum age of this
crop. Finally, we write the new parameter sets as a new subfolder into
our EFForTS-ABM directory.

``` r
abmfolder <- dirname(nl@modelpath)
main <- get.abm.main.default(crop = "oilpalm")
management <- get.abm.management.default(crop = "oilpalm", n = 2)

# increase max age of crop in main:
main[["max_age"]] <- 30
# increase wages of management 0:
management[[1]][["wages"]] <- 2

# Write to abmfolder:
param.set.name <- "new_params"
set.abm.parfiles(abmfolder, param.set.name, main, management, overwrite = TRUE)
```

#### Example 4: Write parameter files dynamically and run a full nlrx experiment

This is a small use case to illustrate how this package can be used to
run dynamic experiments with EFForTS-ABM.

We want to simulate two different crops: oilpalm, and rubber. So we need
to parameter folders to do that. However, we
don`t want to use the default parameterisations, but we want to simulate a gradient of labor costs. We can use the wages parameter of the management file to achieve that. Let`s
simulate a gradient from 1 to 2 with steps of 0.1.

First we generate the parameter folders:

``` r
# Define folder of abm:
abmfolder <- "D:/owncloud/git/EFForTS-ABM/01_EFForTS-ABM"

# Generate vectors for dynamic creation of parameter sets:
crops <- c("rubber", "oilpalm")
wages <- seq(1, 2, 0.1)

# Loop, create skeletons, modify and write to disk:
for (i in crops)
{
  main <- get.abm.main.default(crop = i)
  management <- get.abm.management.default(crop = i, n = 1)

  for (j in wages)
  {
    # increase wages of management:
    management[[1]][["wages"]] <- j

    # Write to abmfolder:
    param.set.name <- paste0(i, "_wages_", j)
    set.abm.parfiles(abmfolder, param.set.name, main, management, overwrite = TRUE)
  }
}
```

Now we can use these folders for our nlrx experiment. First, we generate
a vector with all folder names, and then use this vector to set our
model variables LUT-0-folder and LUT-1-folder.

``` r
param.sets.rubber <- paste0(crops[1], "_wages_", wages)
param.sets.oilpalm <- paste0(crops[2], "_wages_", wages)

library(nlrx)

netlogopath <- file.path("C:/Program Files/NetLogo 6.1.0")
modelpath <- "01_EFForTS-ABM/EFForTS-ABM.nlogo"
outpath <- "03_Analyses/"

nl <- nl(
  nlversion = "6.1.0",
  nlpath = netlogopath,
  modelpath = modelpath,
  jvmmem = 1024
)

nl@experiment <- experiment(
  expname = "invest",
  outpath = outpath,
  repetition = 1,
  tickmetrics = "true",
  idsetup = c("ca", "setup-with-external-maps"),
  idgo = c("go", "update-time"),
  runtime = 50,
  metrics = get.abm.metrics(),
  constants = get.abm.defaults()
)

nl <- set.nl.variable(
  nl = nl,
  varname = "LUT-0-folder",
  values = param.sets.oilpalm
)

nl <- set.nl.variable(
  nl = nl,
  varname = "LUT-1-folder",
  values = param.sets.rubber
)

# Then add a full factorial design:
nl@simdesign <- simdesign_ff(nl, nseeds = 1)

## Run simulations:
library(future)
plan(multisession)
results <- run_nl_all(nl, split = 6)

## Attach output:
setsim(nl, "simoutput") <- results
saveRDS(nl, file = file.path(outpath, "sims_wages_ff.rds"))
```

#### Example 5: Time series plots

The package can generate facets with time-series plots for all collected
metrics with the function `plot.abm.timeseries()`. The function
automatically uses all metrics from the nl object, but it is also
possible to only use some metrics. Finally, the returned ggplot object
can be plotted or visualized in an interactive way with plotly.

``` r
nl <- nl_spatial

timeplot <- doplot.abm.timeseries(nl, metrics = nl@experiment@metrics)

timeplot
plotly::ggplotly(timeplot)

## Or, specify only some metrics:
timeplot <- doplot.abm.timeseries(nl, metrics = c("count sheep"))

timeplot
plotly::ggplotly(timeplot)
```

#### Example 6: Simulate price data

Refforts bring some functions to generate price data for rubber and
oilpalm. It uses Geometric Brownian Motion to generate correlated price
curves. Historical monthly price data is used to calculate some
characteristics. These characteristics are then used to simulate
artificial price curves that are correlated with one another.

To generate one series with 10 years of price data:

``` r
prices.GBM.one.series(years = 10)
```

Within this function, one can also define a start and end date. These
are used to filter the historical data. So if the price curve should
only represent the development of the last ten years, this can be done
as follows:

``` r
prices.GBM.one.series(years = 10, start.date = as.Date("2010-01-01"), end.date = as.Date("2020-01-01"))
```

To generate multiple series at once:

``` r
n.series <- 100
path.series <- purrr::map_dfr(1:n.series, function(x) {
  prices.GBM.one.series(years = 50, id = x)
})
```

These series can then be clustered, using dynamic time warping (package
dtwclust):

``` r
# get list of cluster objects for each crop:
clusterlist <- prices.GBM.cluster(path.series)
# add cluster ids to series data:
series.cl <- prices.GBM.cluster.series(path.series, clusterlist)

# plot cluster:
library(ggplot2)
ggplot(series.cl, aes(x = time, y = price, color = factor(series))) +
  facet_grid(crop ~ cluster, scales = "free") +
  geom_line() +
  guides(color = "none") +
  scale_y_log10() +
  theme_minimal()
```

COMING NEXT: How to use this price data for setting parameter files in
EFForTS ABM and run experiments!

## Utility functions:

#### HPC communication functions

The package contains three functions that allow to upload, download and
delete data on the GWDG HPC. This makes it convenient to send the
current model version to the HPC right before exeuction of simulations
with nlrx.

The functions use directory definitions (from/to), the GWDG user name
and a fitting ssh key for communcaiton with the HPC:

``` r
## copy model files to server:
hpc.upload(
  from = file.path(getwd(), "01_EFForTS-ABM"),
  to = file.path(netlogopath, "app/models/"),
  user = "jsaleck", key = "/home/..."
)

## collect results from remote HPC:
hpc.download(
  from = file.path(nl@experiment@outpath),
  to = file.path(getwd(), "ssh_download"),
  user = "jsaleck", key = "/home/..."
)

## Delete files on HPC:
hpc.del(
  folder = nl@experiment@outpath,
  user = "jsaleck", key = "/home/..."
)
```

#### Vector rescaling:

The function re-scales a vector of values to a new min and max range
(defaults to 0-1 range).

``` r
tibble::tibble(a = c(3, 2523, 223, 342, 33, 26, 85, 75)) %>%
  dplyr::mutate(b = util.rescale.vector(a))
```

#### Save ggplots as svg and png simoultaneously:

ggsave wrapper to save svg and png at the same time:

``` r
library(ggplot2)

# create a simple plot:
ptest <- ggplot(mtcars, aes(x = hp, y = qsec)) +
  geom_point()

# Save:
util.ggsave(plot = ptest, filename = "test", path = "C:/plots", width = 12, height = 12, dpi = 300)
```
