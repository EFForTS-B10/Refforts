
## Load csv:
abm.table <- read.csv("data_raw/EFForTS-ABM_parameters_and_output.csv", header=TRUE, sep=";", stringsAsFactors = FALSE)

usethis::use_data(abm.table, overwrite = TRUE)
