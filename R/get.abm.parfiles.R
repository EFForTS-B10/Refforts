
#' Get parameter files from efforts-abm folder
#'
#' @description Get parameter files from efforts-abm folder
#'
#' @param abmfolder folder destination of EFForTS-ABM model
#'
#' @return list with parameter definitions
#'
#' @details
#'
#' Get parameter files from efforts-abm folder
#'
#' @examples
#'
#' \dontrun{
#' get.abm.parfiles()
#'}
#'
#' @aliases get.abm.parfiles
#' @rdname get.abm.parfiles
#'
#' @export

get.abm.parfiles <- function(abmfolder)
{
  if(!dir.exists(file.path(abmfolder, "par_ABM")))
  {
    stop("Specified directory does not exist or does nor contain a par_ABM subfolder!")
  }

  param.sets <- list.files(file.path(abmfolder, "par_ABM"))

  if(length(param.sets) == 0)
  {
    stop("No parameter sets have been found!")
  }

  parfiles <- purrr::map(param.sets, function(i){

    ## Check if main exists and at least one management file is there:
    main.exists <- file.exists(file.path(abmfolder, "par_ABM", i, "main.txt"))
    management.files <- list.files(file.path(abmfolder, "par_ABM", i), full.names = TRUE, pattern = "management")

    ## Check if main file exists:
    if(isTRUE(main.exists) & length(management.files) > 0)
    {
      ## Read main:
      main <- utils::read.csv(file.path(abmfolder, "par_ABM", i, "main.txt"), sep=",", stringsAsFactors = FALSE, header = FALSE)
      main.list <- lapply(as.list(main$V2), utils::type.convert, as.is=TRUE)
      names(main.list) <- main$V1

      ## Read management:
      management.list <- purrr::map(management.files, function(j){
        mang <- utils::read.csv(j, sep=",", stringsAsFactors = FALSE, header = FALSE)
        mang.list <- lapply(as.list(mang$V2), utils::type.convert, as.is=TRUE)
        names(mang.list) <- mang$V1
        return(mang.list)
        })

      ## Combine both lists:
      param.set.list <- list(main=main.list,
                             management=management.list)

    } else
    {
      warning(paste0("Parameter set ", i, " does not contain at least one management subfile. NULL reported."))
      param.set.list <- NULL
    }
    return(param.set.list)
  })

  names(parfiles) <- param.sets

  return(parfiles)
}
