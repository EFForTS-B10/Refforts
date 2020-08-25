
#' ggsave wrapper to save svg and png at the same time
#'
#' @description ggsave wrapper to save svg and png at the same time
#'
#' @param filename File name to create on disk (without file ending).
#' @param save.svg TRUE/FALSE save to svg
#' @param save.png TRUE/FALSE save to png
#' @param ... Other arguments passed on to ggsave
#'
#' @details
#'
#' ggsave wrapper to save svg and png at the same time
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' # create a simple plot:
#' ptest <- ggplot(mtcars, aes(x=hp, y=qsec)) +
#'            geom_point()
#'
#' # Save:
#' util.ggsave(plot=ptest, filename="test", path="C:/plots", width=12, height=12, dpi=300)
#' }
#'
#' @aliases util.ggsave
#' @rdname util.ggsave
#'
#' @export

util.ggsave <- function(filename, save.svg = TRUE, save.png = TRUE, ...)
{
  if(isTRUE(save.svg))
  {
    filename.svg <- paste0(filename, ".svg")
    ggplot2::ggsave(device="svg", filename=filename.svg, ...)
  }
  if(isTRUE(save.png))
  {
    filename.png <- paste0(filename, ".png")
    ggplot2::ggsave(device="png", filename=filename.png, ...)
  }
}
