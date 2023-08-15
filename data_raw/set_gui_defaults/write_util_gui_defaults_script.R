################################################################################
#    script to take Refforts params from csv and format it to be used with the
#    function set-gui-parameters-to-default in EFForTS-ABM.

#    The output is the .nls script which can be directly copied to the folder
#    \EFForTS-ABM\01_EFForTS-ABM\scr_ABM
#
#    author: Luka Nierhoff, 08/08/23
################################################################################




############################################
# clear environment
rm(list = ls())

## Load csv with parameters:
abm.table <- read.csv(file.path("data_raw", "EFForTS-ABM_parameters_and_output.csv"),
                      header = TRUE, sep = ",", stringsAsFactors = FALSE)
# define script names
script_name   <- "util_gui_defaults.nls"
template_name <- "template.nls"        # template contains first lines of the script

# add path and name together
script        <- file.path("data_raw", "set_gui_defaults", script_name)
template      <- file.path("data_raw", "set_gui_defaults", template_name)

# copy template
file.copy(from = template,
          to = script,
          overwrite = T)

# add function name of first function
cat("to set-efforts-abm-defaults",
    "\n",
    fill = T,
    append = T,
    file = script)


# for-loop over all efforts-abm entries:
for (x in 1:nrow(abm.table)) {
    # 1. differentiate between "set-efforts-abm and set-efforts-lgraf
  if(grepl("gr-", abm.table$name[x]) == FALSE & abm.table$group[x] == "parameter" ) {  #!is.na(abm.table$default[x])) {
        # (if name does NOT indicate lgraf parameter  AND  if it is not NA)
    # 2. append each parameter to the nls script
    cat(" ",
        "set",
        abm.table$name[x],
        abm.table$default[x],
        fill = T,
        append = T,
        file = script)
  }
}

# add an "end"
cat("\n",
    "end",
    "\n \n \n",
    fill = T,
    append = T,
    sep = "",
    file = script)



######################################
# now comes the lgraf function

# add function name of first function
cat("to set-efforts-lgraf-defaults",
    "\n",
    fill = T,
    append = T,
    sep = "",
    file = script)



# for-loop over all efforts-lgraf entries:
for (x in 1:nrow(abm.table)) {
  # 1. differentiate between "set-efforts-abm and set-efforts-lgraf
  if(grepl("gr-", abm.table$name[x]) == TRUE & abm.table$group[x] == "parameter" ) {     # if name does NOT indicate lgraf parameter
    cat(" ",
        "set",
        abm.table$name[x],
        abm.table$default[x],
        fill = T,
        append = T,
        file = script)
  }
}

# and add a last "end"
cat("\n",
    "end",
    "\n",
    fill = T,
    append = T,
    sep = "",
    file = script)


