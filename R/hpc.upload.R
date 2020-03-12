#' Sends a file or a complete folder to the remote host (HPC) via ssh
#'
#' @description Sends a file or a complete folder to the remote host (HPC) via ssh
#'
#' @param from File or folder to copy
#' @param to destination folder on the remote host
#' @param user user name on the remote host
#' @param host host server address
#' @param key link to the ssh key file on the local system
#'
#'
#' @details
#'
#' Sends a file or a complete folder to the remote host (HPC) via ssh
#'
#'
#' @aliases hpc.upload
#' @rdname hpc.upload
#'
#' @export

hpc.upload <- function(from=NA,
                           to=NA,
                           user=NA,
                           host="login.gwdg.de",
                           key=NA) {

  user.host <- paste0(user, "@", host)
  session <- ssh::ssh_connect(user.host, keyfile = key)
  ssh::scp_upload(session, files=from, to=to)
  ssh::ssh_disconnect(session)
}
