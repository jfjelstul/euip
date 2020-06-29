###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

#' Data on Member States
#'
#' A function that loads a tibble with a list of EU member states into the global environment.
#'
#' @return Loads a tibble called \code{member_states} with the following variables into the global environment:
#' \itemize{
#' \item \code{member_state}: the name of the member state; and
#' \item \code{member_state_code}: a 2-character code for the member state.
#' }
#'
#' @export
#'
# function to get a list of member states
ms_list <- function() {
  data(member_states)
}

#' Data on Directorates-General
#'
#' A function that laods a tibble with a list of Directorates-General (DGs).
#'
#' @return Loads a tibble called \code{DGs} with the following variables into the global environment:
#' \itemize{
#' \item \code{directorate_general}: the name of the DG.
#' \item \code{directorate_general_code}: a short character code for the DG.
#' \item \code{type}: either \code{"Directorate-General"} or \code{"Service Department"}.
#' \item \code{status}: either \code{"current"} or \code{"former"}.
#' }
#'
#' @export
#'
dg_list <- function() {
  data(DGs)
}

###########################################################################
# end R script
###########################################################################
