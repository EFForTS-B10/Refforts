
# load package
library(readxl)

# load table
abm.table <- read.csv("data_raw/EFForTS-ABM_parameters_and_output.csv", header=TRUE, sep=",", stringsAsFactors = FALSE)

# add column called model2018
abm.table$model2018 <- NA

exc_abm <- readxl::read_excel("data_raw/EFForTS-ABM_parameters_and_output_with_Dislich2018.xlsx")

abm.table$model2018 <- exc_abm$model2018

# test which ones are the new rows in excel
names_dev2 <- abm.table$name
names2018  <- exc_abm$name

differences <- names2018 %in% names_dev2
names2018[!differences]

# test what else is different
exc_abm %in% abm.table
