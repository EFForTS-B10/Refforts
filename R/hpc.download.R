#' Download files or a complete folder from the remote host (HPC) via ssh
#'
#' @description Sends a file or a complete folder to the remote host (HPC) via ssh
#'
#' @param from File or folder to copy from the remote host
#' @param to destination folder on the local system
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
#' @aliases hpc.download
#' @rdname hpc.download
#'
#' @export

hpc.download <- function(from=NA,
                       to=NA,
                       user=NA,
                       host="transfer.gwdg.de",
                       key=NA) {
  user.host <- paste0(user, "@", host)
  session <- ssh::ssh_connect(user.host, keyfile = key)
  ssh::scp_download(session, files=from, to=to)
  ssh::ssh_disconnect(session)
}
