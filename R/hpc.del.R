#' Deletes all files in the specified folder on the remote host (HPC) via ssh
#'
#' @description Deletes all files in the specified folder on the remote host (HPC) via ssh
#'
#' @param folder folder where files are deletd on the remote host
#' @param command decide which command is sued for deleting files. Options are "rm" or "find".
#' @param user user name on the remote host
#' @param host host server address
#' @param key link to the ssh key file on the local system
#'
#' @details
#'
#' Deletes all files in the specified folder on the remote host (HPC) via ssh.
#' The command options can be used to define which bash command is used for deleting files.
#' While "rm" may be faster, it throws error messages for very long file lists.
#' Thus, "find" should be used for large numbers of files.
#'
#'
#' @aliases hpc.del
#' @rdname hpc.del
#'
#' @export

hpc.del <- function(folder=NA,
                    user=NA,
                    command="find",
                    host="transfer.gwdg.de",
                    key=NA) {

  user.host <- paste0(user, "@", host)
  session <- ssh::ssh_connect(user.host, keyfile = key)

  if (command == "find")
  {
    ssh::ssh_exec_wait(session, command = paste0("find ", folder, "/ -maxdepth 1 -type f -delete"))
  }
  if (command == "rm")
  {
    ssh::ssh_exec_wait(session, command = paste0("rm -r ", folder, "/* "))
  }

  ssh::ssh_disconnect(session)
}
