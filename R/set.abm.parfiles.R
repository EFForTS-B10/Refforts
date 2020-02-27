
#' Create a new parameter sub folder in the parameter subfolder of EFForTS-ABM
#'
#' @description Create a new parameter sub folder in the parameter subfolder of EFForTS-ABM
#'
#' @param abmfolder folder destination of EFForTS-ABM model
#' @param name name of the new parameter sub folder
#' @param main list with main parameter specifications
#' @param management nested list with management parameter specifications
#' @param overwrite TRUE/FALSE, if TRUE existing parameter files will be overwritten
#'
#' @return NULL
#'
#' @details
#'
#' Create a new parameter sub folder in the parameter subfolder of EFForTS-ABM
#'
#' @examples
#' \dontrun{
#' set.abm.parfiles()
#' }
#'
#' @aliases set.abm.parfiles
#' @rdname set.abm.parfiles
#'
#' @export

set.abm.parfiles <- function(abmfolder, name, main, management, overwrite)
{
  ## First check if folder exists and contains par subfolder:
  if(!dir.exists(file.path(abmfolder, "par_ABM")))
  {
    stop("Specified directory does not exist or does nor contain a par_ABM subfolder!")
  }

  ## Then check if the subfolder already exists
  if(dir.exists(file.path(abmfolder, "par_ABM", name)))
  {
    if(!isTRUE(overwrite))
    {
      stop("Parameter set with this name already exists in folder. Overwrite is set to false, operation aborted! If you want to overwrite the current parameter folder, use overwrite = TRUE!")
    } else
    {
      warning("Parameter set with this name already exists in folder. Overwrite is set to true. Files may be overwritten!")
    }
  } else
  {
   ## Folder does not exist yet, so we create it:
   dir.create(file.path(abmfolder, "par_ABM", name))
  }


  ## Now write the parameter files:
  util.abm.write.main.txt(path = file.path(abmfolder, "par_ABM", name, "main.txt"),
                          main = main)


  ## Now write the management files:
  for(i in 1:length(management))
  {
    management.i <- management[[i]]
    util.abm.write.management.txt(path = file.path(abmfolder, "par_ABM", name, paste0("management", (i - 1), ".txt")),
                                  management = management.i)


  }
}


#' Write main parameter file for efforts-abm
#'
#' @description Write main parameter file for efforts-abm
#'
#' @aliases util.abm.write.main.txt
#' @rdname util.abm.write.main.txt
#' @keywords internal
util.abm.write.main.txt <- function(path, main)
{
  fileConn<-file(path)
  writeLines(c(paste("landuse", main$landuse, sep=","),
               paste("inefficiency_alpha", main$inefficiency_alpha, sep=","),
               paste("inefficiency_lambda", main$inefficiency_lambda, sep=","),
               paste("depriciation_rate_young", main$depriciation_rate_young, sep=","),
               paste("depriciation_rate_old", main$depriciation_rate_old, sep=","),
               paste("depriciation_rate_switch", main$depriciation_rate_switch, sep=","),
               paste("max_age", main$max_age, sep=","),
               paste("yield_function", main$yield_function, sep=","),
               paste("carbon_function", main$carbon_function, sep=","),
               paste("prices", main$prices, sep=",")),
             fileConn)
  close(fileConn)
}


#' Write management parameter file for efforts-abm
#'
#' @description Write management parameter file for efforts-abm
#'
#' @aliases util.abm.write.management.txt
#' @rdname util.abm.write.management.txt
#' @keywords internal
util.abm.write.management.txt <- function(path, management)
{
  fileConn<-file(path)
  writeLines(c(paste("landuse", management$landuse, sep=","),
               paste("management", management$management, sep=","),
               paste("labor_function", management$labor_function, sep=","),
               paste("tinput_function", management$tinput_function, sep=","),
               paste("invest_function", management$invest_function, sep=","),
               paste("price_tinput", management$price_tinput, sep=","),
               paste("wages", management$wages, sep=","),
               paste("yield_factor", management$yield_factor, sep=","),
               paste("external_income_factor", management$external_income_factor, sep=",")),
             fileConn)
  close(fileConn)
}

