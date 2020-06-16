###########################################################################
# Josh Fjelstul, Ph.D.
# euinfr R package
###########################################################################

#' Get Data on EU Infringement Decisions
#'
#' This function provides an easy way to get decision-level data from the European Union Infringement Procedures (EUIP)
#' dataset API without writing an API query and parsing the JSON data returned by the API.
#' This function returns one observation per decision taken by the European Commission in
#' an infringement case that matches all of the search criteria you specify.
#'
#' The EUIP dataset API returns data in a standard JSON format.
#' This function automatically converts the JSON data into a tibble (see the \code{tidyverse} package).
#' The output of this function will be in a tidy format
#' (each variable in its own column, each observation in its own row, and each value in its own cell)
#' for easy use with other functions in the \code{tidyverse}, such as \code{ggplot}.
#'
#' @param id A numeric vector where each number is a valid case number.
#' Case numbers always have 8 digits.
#' The first 4 digits are the year the case was opened and the second 4 digits uniquely identify the cases within the year.
#' If you include one or more invalid case numbers, you will get an error.
#'
#' @param year A four-digit numeric value indicating a year or a numeric vector of length 2 containing a start year and an end year.
#' If you list more than 2 years, or do not list the start year and end year in chronological order, you will get an error.
#' The EUIP dataset covers the period from 2002 to 2020.
#' If you include a year outside this range, you will also get an error.
#'
#' @param ms A string vector where each string is a valid member state name or code.
#' Use the function \code{ms_list()} to get a complete list of valid member state names and codes.
#' The API will return an error if one or more of the elements is not valid.
#'
#' @param dg A string vector where each string is a valid DG name or code.
#' Use the function \code{dg_list()} to get a complete list of valid DG names and codes.
#' The API will return an error if one or more of the elements is not valid.
#'
#' @param dir A vector of valid directive numbers.
#' Note that not all observations correspond to a specific directive.
#' If a observation does not, and this parameter is not \code{NULL}, the API will not return it,
#' even if it meets all of the other specified criteria.
#' All observations related to noncommunication cases should correspond to a specific directive,
#' but the Commission does not always report this information.
#' If an invalid directive number is included, the API will return an error.
#'
#' @param celex A vector of valid CELEX numbers for directives.
#' Note that not all observations correspond to a specific directive.
#' If a observation does not, and this parameter is not \code{NULL}, the API will not return it,
#' even if it meets all of the other specified criteria.
#' All observations related to noncommunication cases should correspond to a specific directive,
#' but the Commission does not always report this information.
#' If an invalid CELEX number is included, the API will return an error.
#'
#' @param type A string vector where each string is a type of infringment case.
#' Valid options include:
#' \itemize{
#' \item \code{"COMM"}, for noncommunication cases; and
#' \item \code{"CONF"}, for nonconformity cases.
#' }
#' If \code{NULL}, the function will return decisions in both types of cases.
#' Noncommunication cases are those in which the Commission alleges that a member state
#' has failed to notify the Commission of the transposition of a directive before the specified date.
#' Nonconformity cases are those in which the Commission alleges that a member state
#' has failed to correctly transpose a directive into national law.
#'
#' @param stage A string vector where each string is a stage in the infringement procedure.
#' Only decisions in cases that make it to all specified stages will be included in the results.
#' Valid options include:
#' \itemize{
#' \item \code{"LFN258"}, for letters of formal notice under Article 258 (TFEU);
#' \item \code{"RO258"}, for reasoned opinions under Article 258 (TFEU);
#' \item \code{"RF258"}, for referrals to the Court under Article 258 (TFEU);
#' \item \code{"LFN260"}, for letters of formal notice under Article 260 (TFEU);
#' \item \code{"RO260"}, for reasoned opinions under Article 260 (TFEU);
#' \item \code{"RF260"}, for referrals to the Court under Article 260 (TFEU);
#' \item \code{"C"}, for the closing of the case; and
#' \item \code{"W"}, for the withdrawal of the case.
#' }
#' Note that a case can be closed or withdrawn, but not both.
#'
#' @return Returns a tibble in tidy format with decision-level data, subject to the specified filters.
#' The unit of observation is a decision by the Commission in an infringement case.
#' The tibble will include the following variables:
#' \itemize{
#' \item \code{case_number}: a unique ID number assigned to the case by the Commission;
#' \item \code{decision_date}: the date the decision was made in \code{YYYY-MM-DD} format;
#' \item \code{decision_date}: the year the decision was madet;
#' \item \code{member_state}: the name of the member state under investigation;
#' \item \code{member_state_code}: the code of the member state under investigation;
#' \item \code{directorate_general}: the name of the DG that managed the case;
#' \item \code{directorate_general_code}: the code of the DG that managed the case;
#' \item \code{case_type}: either \code{"Noncommunication"} or \code{"Nonconformity"}; and
#' \item \code{decision_stage}: the type of the decision (letter of formal notice, reasoned opinion, etc.).
#' }
#'
#' @seealso Other functions in the \code{euinfr} package: [get_case_data()] for case-level data,
#' [get_ms_data()] for time-varying member state-level data, and
#' [get_dg_data()] for time-varying DG-level data.
#'
#' @export
#'

get_decision_data <- function(id = NULL, year = NULL, date = NULL, ms = NULL, dg = NULL, dir = NULL, celex = NULL, type = NULL, stage = NULL) {

  # create query
  query <- "http://165.227.25.160/infringement_data_API/decisions?"

  # ID filter
  query <- add_option_filter(query, id)

  # YEAR filter
  query <- add_range_filter(query, year)

  # MS filter
  query <- add_option_filter(query, ms)

  # DG filter
  query <- add_option_filter(query, dg)

  # DIR filter
  query <- add_option_filter(query, dir)

  # CELEX filter
  query <- add_option_filter(query, celex)

  # TYPE filter
  query <- add_option_filter(query, type)

  # STAGE filter
  query <- add_option_filter(query, stage)

  # call API
  out <- call_API(query)

  # return tibble
  return(out)
}

#' Get Data on EU Infringement Cases
#'
#' This function provides an easy way to get case-level data from the European Union Infringement Procedures (EUIP)
#' dataset API without writing an API query and parsing the JSON data returned by the API.
#' This function returns one observation per infringement case that matches all of the search criteria you specify.
#'
#' The EUIP dataset API returns data in a standard JSON format.
#' This function automatically converts the JSON data into a tibble (see the \code{tidyverse} package).
#' The output of this function will be in a tidy format
#' (each variable in its own column, each observation in its own row, and each value in its own cell)
#' for easy use with other functions in the \code{tidyverse}, such as \code{ggplot}.
#'
#' @param id A numeric vector where each number is a valid case number.
#' Case numbers always have 8 digits.
#' The first 4 digits are the year the case was opened and the second 4 digits uniquely identify the cases within the year.
#' If you include one or more invalid case numbers, you will get an error.
#'
#' @param year A four-digit numeric value indicating a year or a numeric vector of length 2 containing a start year and an end year.
#' If you list more than 2 years, or do not list the start year and end year in chronological order, you will get an error.
#' The EUIP dataset covers the period from 2002 to 2020.
#' If you include a year outside this range, you will also get an error.
#'
#' @param ms A string vector where each string is a valid member state name or code.
#' Use the function \code{ms_list()} to get a complete list of valid member state names and codes.
#' The API will return an error if one or more of the elements is not valid.
#'
#' @param dg A string vector where each string is a valid DG name or code.
#' Use the function \code{dg_list()} to get a complete list of valid DG names and codes.
#' The API will return an error if one or more of the elements is not valid.
#'
#' @param dir A vector of valid directive numbers.
#' Note that not all observations correspond to a specific directive.
#' If a observation does not, and this parameter is not \code{NULL}, the API will not return it,
#' even if it meets all of the other specified criteria.
#' All observations related to noncommunication cases should correspond to a specific directive,
#' but the Commission does not always report this information.
#' If an invalid directive number is included, the API will return an error.
#'
#' @param celex A vector of valid CELEX numbers for directives.
#' Note that not all observations correspond to a specific directive.
#' If a observation does not, and this parameter is not \code{NULL}, the API will not return it,
#' even if it meets all of the other specified criteria.
#' All observations related to noncommunication cases should correspond to a specific directive,
#' but the Commission does not always report this information.
#' If an invalid CELEX number is included, the API will return an error.
#'
#' @param type A string vector where each string is a type of infringment case.
#' Valid options include:
#' \itemize{
#' \item \code{"COMM"}, for noncommunication cases; and
#' \item \code{"CONF"}, for nonconformity cases.
#' }
#' If \code{NULL}, the function will return both types of cases.
#' Noncommunication cases are those in which the Commission alleges that a member state
#' has failed to notify the Commission of the transposition of a directive before the specified date.
#' Nonconformity cases are those in which the Commission alleges that a member state
#' has failed to correctly transpose a directive into national law.
#'
#' @param stage A string vector where each string is a stage in the infringement procedure.
#' Only cases that make it to all specified stages will be included in the results.
#' Valid options include:
#' \itemize{
#' \item \code{"LFN258"}, for letters of formal notice under Article 258 (TFEU);
#' \item \code{"RO258"}, for reasoned opinions under Article 258 (TFEU);
#' \item \code{"RF258"}, for referrals to the Court under Article 258 (TFEU);
#' \item \code{"LFN260"}, for letters of formal notice under Article 260 (TFEU);
#' \item \code{"RO260"}, for reasoned opinions under Article 260 (TFEU);
#' \item \code{"RF260"}, for referrals to the Court under Article 260 (TFEU);
#' \item \code{"C"}, for the closing of the case; and
#' \item \code{"W"}, for the withdrawal of the case.
#' }
#' Note that a case can be closed or withdrawn, but not both.

#' @param comp A logical value (\code{TRUE} or \code{FALSE}). If \code{TRUE}, only complete cases
#' (cases with no known missing stages) are included in the results.
#' For example, a case with a letter of formal notice and a referral to the Court, but no recorded reasoned opinion
#' would be omitted from the results. To not be omitted, a case must at least have a record of a letter of formal notice
#' and a record of a closing or a withdrawal.
#'
#' @return Returns a tibble in tidy format with case-level data, subject to the specified filters.
#' The unit of observation is an infringement case.
#' The tibble will include the following variables:
#' \itemize{
#' \item \code{case_number}: a unique ID number assigned to the case by the Commission;
#' \item \code{case_year}: the year the case was opened (i.e., the date of the letter of formal notice
#' under Article 258 TFEU);
#' \item \code{member_state}: the name of the member state under investigation;
#' \item \code{member_state_code}: the code of the member state under investigation;
#' \item \code{directorate_general}: the name of the DG that managed the case;
#' \item \code{directorate_general_code}: the code of the DG that managed the case;
#' \item \code{case_type}: either \code{"Noncommunication"} or \code{"Nonconformity"};
#' \item \code{stage_LFN258}: a dummy variable indicating whether there was an letter of formal notice under Article 258 (TFEU);
#' \item \code{stage_RO258}: a dummy variable indicating whether there was a reasoned opinion under Article 258 (TFEU);
#' \item \code{stage_RF258}: a dummy variable indicating whether there was a referal to the Court under Article 258 (TFEU);
#' \item \code{stage_LFN260}: a dummy variable indicating whether there was an letter of formal notice under Article 260 (TFEU);
#' \item \code{stage_RO260}: a dummy variable indicating whether there was a reasoned opinion under Article 260 (TFEU);
#' \item \code{stage_RF260}: a dummy variable indicating whether there was a referal to the Court under Article 260 (TFEU);
#' \item \code{stage_closing}: a dummy variable indicating whether there is a record of the case being closed; and
#' \item \code{stage_withdrawal}: a dummy variable indicating whether there is a record of the case being withdrawn.
#' }
#'
#' @seealso Other functions in the \code{euinfr} package: [get_decision_data()] for decision-level data,
#' [get_ms_data()] for time-varying member state-level data, and
#' [get_dg_data()] for time-varying DG-level data.
#'
#' @export
#'
get_case_data <- function(id = NULL, year = NULL, ms = NULL, dg = NULL, dir = NULL, celex = NULL, type = NULL, stage = NULL, comp = FALSE) {

  # query stem
  query <- "http://165.227.25.160/infringement_data_API/cases?"

  # ID filter
  query <- add_option_filter(query, id)

  # YEAR filter
  query <- add_range_filter(query, year)

  # MS filter
  query <- add_option_filter(query, ms)

  # DG filter
  query <- add_option_filter(query, dg)

  # DIR filter
  query <- add_option_filter(query, dir)

  # CELEX filter
  query <- add_option_filter(query, celex)

  # TYPE filter
  query <- add_option_filter(query, type)

  # STAGE filter
  query <- add_option_filter(query, stage)

  # COMP filter
  query <- add_logical_filter(query, comp)

  # call API
  out <- call_API(query)

  # return tibble
  return(out)
}

#' Get Member State Data
#'
#' @description This function provides an easy way to get time-varying member state-level data from the European Union Infringement Procedures (EUIP)
#' dataset API without writing an API query and parsing the JSON data returned by the API.
#' This function returns time-varying member state-level data on the number decisions made by the Commission
#' in infringement cases at each stage of the infringement procedure (letter of formal notice, reasoned opinion, etc.)
#' with an option to disaggregate by type of case (e.g., noncommunication vs nonconformity).
#' Use the arguments to apply filters that narrow down the results to data for
#' specific years, specific member states, specific types of cases, and/or specific stages of the infringement procedure.
#'
#' @details The EUIP dataset API returns data in a standard JSON format.
#' This function automatically converts the JSON data into a tibble (see the \code{tidyverse} package).
#' The output of this function is in a tidy format
#' (each variable in its own column, each observation in its own row, and each value in its own cell)
#' for easy use with other functions in the \code{tidyverse}, such as \code{ggplot}.
#'
#' @param year A four-digit numeric value indicating a year or a numeric vector of length 2 containing a start year and an end year.
#' If you list more than 2 years, or do not list the start year and end year in chronological order, you will get an error.
#' The EUIP dataset covers the period from 2002 to 2020.
#' If you include a year outside this range, you will also get an error.
#'
#' @param ms A string vector where each string is a valid member state name or code.
#' Use the function \code{ms_list()} to get a complete list of valid member state names and codes.
#' The API will return an error if one or more of the elements is not valid.
#'
#' @param type A string vector where each string is a type of infringment case.
#' Valid options include:
#' \itemize{
#' \item \code{"COMM"}, for noncommunication cases; and
#' \item \code{"CONF"}, for nonconformity cases.
#' }
#' If \code{NULL}, the function will not distinguish between noncommunication cases and nonconformity cases.
#' Noncommunication cases are those in which the Commission alleges that a member state
#' has failed to notify the Commission of the transposition of a directive before the specified date.
#' Nonconformity cases are those in which the Commission alleges that a member state
#' has failed to correctly transpose a directive into national law.
#'
#' @param stage A string vector where each string is a stage in the infringement procedure.
#' Valid options include:
#' \itemize{
#' \item \code{"LFN258"}, for letters of formal notice under Article 258 (TFEU);
#' \item \code{"RO258"}, for reasoned opinions under Article 258 (TFEU);
#' \item \code{"RF258"}, for referrals to the Court under Article 258 (TFEU);
#' \item \code{"LFN260"}, for letters of formal notice under Article 260 (TFEU);
#' \item \code{"RO260"}, for reasoned opinions under Article 260 (TFEU); and
#' \item \code{"RF260"}, for referrals to the Court under Article 260 (TFEU).
#' }
#'
#' @return Returns a tibble in tidy format with time-varying member state-level data on the number decisions made by the Commission
#' in infringement cases at each stage of the infringement procedure (letter of formal notice, reasoned opinion, etc.)
#' and by type of case (e.g., noncommunication vs nonconformity),
#' subject to the specified filters.
#' The unit of observation is the unique combination of a member state, a year, a type of case, and a stage of the infringement procedure.
#' The tibble will include the following variables:
#' \itemize{
#' \item \code{member_state}: the name of the member state;
#' \item \code{member_state_code}: a 2-character code for the member state;
#' \item \code{year}: the year of the decision (not the year the case was lodged);
#' \item \code{decision_stage}: the stage of the infringement procedure;
#' \item \code{case_type}: if \code{type} is not \code{NULL}, the type of case (\code{"Noncommunication"} or \code{"Nonconformity"}), otherwise excluded; and
#' \item \code{count}: the number of decisions in cases of the indicated type at the indicated stage
#' involving the indicated member state in the indicated year.
#' }
#'
#' @seealso Other functions in the \code{euinfr} package: [get_decision_data()] for decision-level data, [get_case_data()] for case-level data, and
#' [get_dg_data()] for time-varying DG-level data.
#'
#' @examples
#' # the number of letters of formal notice under Article 258
#' # that the Commission sent to the United Kingdom,
#' # France, and Germany in noncommunication cases
#' # for each year from 2010 through 2010
#'
#' get_ms_data(year = c(2010, 2020), ms = c("UK", "FR", "DE"), type = "COMM", stage = "LFN258")
#'
#' # the number of decisions that the Commission made in cases
#' # against France by type in nonconformity cases in 2010
#'
#' get_ms_data(year = 2010, ms = "FR", type = "CONF")
#'
#' @export
#'
get_ms_data <- function(year = NULL, ms = NULL, type = NULL, stage = NULL) {

  # create query
  query <- "http://165.227.25.160/infringement_data_API/member-states?"

  # YEAR filter
  query <- add_range_filter(query, year)

  # MS filter
  query <- add_option_filter(query, ms)

  # TYPE filter
  query <- add_option_filter(query, type)

  # STAGE filter
  query <- add_option_filter(query, stage)

  # call API
  out <- call_API(query)

  # return tibble
  return(out)
}

#' Get Directorate-General Data
#'
#' @description This function provides an easy way to get time-varying DG-level data from the European Union Infringement Procedures (EUIP)
#' dataset API without writing an API query and parsing the JSON data returned by the API.
#' This function returns time-varying DG-level data on the number decisions made by the Commission
#' in infringement cases at each stage of the infringement procedure (letter of formal notice, reasoned opinion, etc.)
#' with an option to disaggregate by type of case (e.g., noncommunication vs nonconformity).
#' Use the arguments to apply filters that narrow down the results to data for
#' specific years, specific DGs, specific types of cases, and/or specific stages of the infringement procedure.
#'
#' @details The EUIP dataset API returns data in a standard JSON format.
#' This function automatically converts the JSON data into a tibble (see the \code{tidyverse} package).
#' The output of this function is in a tidy format
#' (each variable in its own column, each observation in its own row, and each value in its own cell)
#' for easy use with other functions in the \code{tidyverse}, such as \code{ggplot}.
#'
#' @param year A four-digit numeric value indicating a year or a numeric vector of length 2 containing a start year and an end year.
#' If you list more than 2 years, or do not list the start year and end year in chronological order, you will get an error.
#' The EUIP dataset covers the period from 2002 to 2020.
#' If you include a year outside this range, you will also get an error.
#'
#' @param dg A string vector where each string is a valid DG name or code.
#' Use the function \code{dg_list()} to get a complete list of valid DG names and codes.
#' The API will return an error if one or more of the elements is not valid.
#'
#' @param type A string vector where each string is a type of infringment case.
#' Valid options include:
#' \itemize{
#' \item \code{"COMM"}, for noncommunication cases; and
#' \item \code{"CONF"}, for nonconformity cases.
#' }
#' If \code{NULL}, the function will not distinguish between noncommunication cases and nonconformity cases.
#' Noncommunication cases are those in which the Commission alleges that a member state
#' has failed to notify the Commission of the transposition of a directive before the specified date.
#' Nonconformity cases are those in which the Commission alleges that a member state
#' has failed to correctly transpose a directive into national law.
#'
#' @param stage A string vector where each string is a stage in the infringement procedure.
#' Valid options include:
#' \itemize{
#' \item \code{"LFN258"}, for letters of formal notice under Article 258 (TFEU);
#' \item \code{"RO258"}, for reasoned opinions under Article 258 (TFEU);
#' \item \code{"RF258"}, for referrals to the Court under Article 258 (TFEU);
#' \item \code{"LFN260"}, for letters of formal notice under Article 260 (TFEU);
#' \item \code{"RO260"}, for reasoned opinions under Article 260 (TFEU); and
#' \item \code{"RF260"}, for referrals to the Court under Article 260 (TFEU).
#' }
#'
#' @return Returns a tibble in tidy format with time-varying DG-level data on the number decisions made by the Commission
#' in infringement cases at each stage of the infringement procedure (letter of formal notice, reasoned opinion, etc.)
#' and by type of case (e.g., noncommunication vs nonconformity), subject to the specified filters.
#' The unit of observation is the unique combination of a year, a DG, a type of case, and a stage of the infringement procedure.
#' The tibble will include the following variables:
#' \itemize{
#' \item \code{directorate_general}: the name of the member state;
#' \item \code{directorate_general_code}: a 2-character code for the member state;
#' \item \code{year}: the year of the decision (not the year the case was lodged);
#' \item \code{decision_stage}: the stage of the infringement procedure;
#' \item \code{case_type}: if \code{type} is not \code{NULL}, the type of case (\code{"Noncommunication"} or \code{"Nonconformity"}), otherwise excluded; and
#' \item \code{count}: the number of decisions in cases of the indicated type at the indicated stage
#' involving the indicated DG in the indicated year.
#' }
#'
#' @seealso Other functions in the \code{euinfr} package: [get_decision_data()] for decision-level data, [get_case_data()] for case-level data, and
#' [get_ms_data()] for time-varying member state-level data.
#'
#' @examples
#' # the number of letters of formal notice under Article 258
#' # sent by DG ENV and DG ENER in noncommunication cases
#' # for each year from 2010 through 2010
#'
#' get_dg_data(year = c(2010, 2020), dg = c("ENV", "ENER"), type = "COMM", stage = "LFN258")
#'
#' # the number of decisions that the Commission made in cases
#' # managed by DG GROW by type in nonconformity cases in 2010
#'
#' get_dg_data(year = 2019, dg = "GROW", type = "CONF")
#'
#' @export
#'
get_dg_data <- function(year = NULL, dg = NULL, type = NULL, stage = NULL) {

  # create query
  query <- "http://165.227.25.160/infringement_data_API/directorates-general?"

  # YEAR filter
  query <- add_range_filter(query, year)

  # DG filter
  query <- add_option_filter(query, dg)

  # TYPE filter
  query <- add_option_filter(query, type)

  # STAGE filter
  query <- add_option_filter(query, stage)

  # call API
  out <- call_API(query)

  # return tibble
  return(out)
}

###########################################################################
# end R script
###########################################################################
