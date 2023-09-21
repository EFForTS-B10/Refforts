# author: Luka
# date: 21/09/23

# background: added new sliders to efforts-ABM because some variables
#             that should be included in sensitivity analysis were still hard
#             coded.
# what?       script adds the new variables to the refforts csv


# load table
abm.table <- read.csv("data_raw/EFForTS-ABM_parameters_and_output.csv", header=TRUE, sep=",", stringsAsFactors = FALSE)

# add new rows with var names:
var_names <- c("b1", "b2", "b3", "m1", "m2", "m3", "n1", "n2", "n3",
               "plateau_labor", "b_labor", "m_lut-0", "m_lut-1",
               "quadratic_term", "linear_term", "constant", "intercept",
               "slope", "plateau_yield", "expo", "scal")
var_defaults <- c(5,7, 25, 100, -80, -0.8, -230, 690, 115,
                  1400, 700, 740, 150,
                  -0.007, 0.3, 2.5, 46, -0.6, 40, 0.7, 0.3)
n_rows <- nrow(abm.table)
for (x in 1:length(var_names)) {
  abm.table[n_rows + x, 1] <- var_names[x]
  abm.table$group[n_rows + x]   <- "parameter"
  abm.table$type[n_rows + x]    <- "global"
  abm.table$category[n_rows + x]<- "new_slider"
  abm.table$valuetype[n_rows + x] <- "numeric"
  abm.table$default[n_rows + x] <- var_defaults[x]
  abm.table$min[n_rows + x]     <- var_defaults[x]*0.9
  abm.table$max[n_rows + x]     <- var_defaults[x]*1.1

}

# and write a new csv (or replace the old one if desired)
write.csv(abm.table,
          "data_raw/EFForTS-ABM_parameters_and_output_incl_new_slider.csv")
