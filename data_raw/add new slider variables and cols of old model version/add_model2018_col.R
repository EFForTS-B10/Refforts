
# load packages
library(readxl)
library(dplyr)

rm(list = ls())

# load data ---------------------------------------------------------------

# load dev2.0 table
abm.table <- read.csv("data_raw/EFForTS-ABM_parameters_and_output.csv", header=TRUE, sep=",", stringsAsFactors = FALSE)
# delete the Dislich et al col because many params are still missing
abm.table <- abm.table[, -which(names(abm.table) == "Dislich2018")]

# and the excel table where values from dislich et al and the 2018-model were added
# exc_abm <- readxl::read_excel("data_raw/EFForTS-ABM_parameters_and_output_with_Dislich2018.xlsx", na = "NA" )
# better as csv (saved excel sheet as csv)
exc_abm <- read.csv("data_raw/EFForTS-ABM_parameters_and_output_with_Dislich2018.csv",
                    na = c("", "NA"), sep = ";")
exc_abm <- exc_abm %>%
  mutate(across(everything(), ~ifelse(. == "WAHR", "TRUE", .))) %>%
  mutate(across(everything(), ~ifelse(. == "FALSCH", "FALSE", .)))


class(exc_abm$min) <- class(abm.table$min)
class(exc_abm$max) <- class(abm.table$max)



# Differences of the 2 dfs? -----------------------------------------------

# compare the defaults of abm and excel
# merge dfs
test <- right_join(abm.table, exc_abm[, colnames(abm.table)])

# and check the new df:
# 1. show the new variable names:
test[!test$name %in% abm.table$name,]

# 2. show where defaults are different
abm_check <- data.frame(name= abm.table$name, abm = abm.table$default)
test_check <- data.frame(name = test$name, test = test$default)
joint <- full_join(abm_check, test_check) %>%
  mutate(comparison = (abm == test)) %>%
  filter(comparison == FALSE)
### ----> no more differences (now that I read in the excel data as csv, it is fine)



# So I simply rowbind to include the 2 new rows from excel and add in the order I wish
new_rows <- exc_abm[!exc_abm$name %in% abm.table$name, colnames(abm.table)]
index    <- which(exc_abm$name == "optimal-invest-costs_lut-0")
new_abm.table <- abm.table[1:index-1,] %>%
  rbind(new_rows) %>%
  rbind(abm.table[index:nrow(abm.table),])



# add Dislich et al and model 2018 columns --------------------------------
new_abm.table <- full_join(new_abm.table, exc_abm[, c("name", "Dislich2018", "model2018")])



# write csv ---------------------------------------------------------------
write.csv(new_abm.table,
          "data_raw/EFForTS-ABM_parameters_and_output_Dislich_and_model_2018.csv",
          row.names = FALSE)

