#' Executes shell commands on the remote host (HPC) via ssh
#'
#' @description Executes shell commands on the remote host (HPC) via ssh
#'
#' @param command command string
#' @param user user name on the remote host
#' @param host host server address
#' @param key link to the ssh key file on the local system
#'
#' @details
#'
#' Executes shell commands on the remote host (HPC) via ssh
#'
#'
#' @aliases hpc.exec
#' @rdname hpc.exec
#'
#' @export

hpc.exec <- function(command=NA,
                     user=NA,
                     host="transfer.gwdg.de",
                     key=NA) {

  user.host <- paste0(user, "@", host)
  session <- ssh::ssh_connect(user.host, keyfile = key)
  ssh::ssh_exec_wait(session, command = command)
  ssh::ssh_disconnect(session)
}
