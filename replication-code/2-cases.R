###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

##################################################
# read in data
##################################################

# read in data
load("data/decisions.RData")

# create a new tibble
cases <- decisions
rm(decisions)

##################################################
# case level data
##################################################

# collapse data by case number and decision stage
cases <- cases %>%
 dplyr::group_by(case_number, decision_stage) %>%
 dplyr::summarize(
  case_year = unique(case_year),
  member_state_ID = unique(member_state_ID),
  member_state = unique(member_state),
  member_state_code = unique(member_state_code),
  directorate_general_ID = unique(directorate_general_ID),
  directorate_general = unique(directorate_general),
  directorate_general_code = unique(directorate_general_code),
  directive = unique(directive),
  directive_number = unique(directive_number),
  CELEX_number = unique(CELEX_number),
  case_type_ID = unique(case_type_ID),
  case_type = unique(case_type),
  noncommunication = unique(noncommunication),
  nonconformity = unique(nonconformity),
  count_LFN258 = sum(stage_LFN258),
  count_RO258 = sum(stage_RO258),
  count_RF258 = sum(stage_RF258),
  count_LFN260 = sum(stage_LFN260),
  count_RO260 = sum(stage_RO260),
  count_RF260 = sum(stage_RF260),
  count_RO259 = sum(stage_RO259),
  count_closing = sum(stage_closing),
  count_withdrawal = sum(stage_withdrawal),
  count_press_releases = sum(press_release),
  case_history = stringr::str_c(stringr::str_c(unique(decision_stage_code), decision_date, sep = "-"), collapse = ", ")
 ) %>%
 dplyr::ungroup()

# then collapse data by case number
cases <- cases %>%
 dplyr::group_by(case_number) %>%
 dplyr::summarize(
  case_year = unique(case_year),
  member_state_ID = unique(member_state_ID),
  member_state = unique(member_state),
  member_state_code = unique(member_state_code),
  directorate_general_ID = unique(directorate_general_ID),
  directorate_general = unique(directorate_general),
  directorate_general_code = unique(directorate_general_code),
  directive = unique(directive),
  directive_number = unique(directive_number),
  CELEX_number = unique(CELEX_number),
  case_type_ID = unique(case_type_ID),
  case_type = unique(case_type),
  noncommunication = unique(noncommunication),
  nonconformity = unique(nonconformity),
  count_LFN258 = sum(count_LFN258),
  count_RO258 = sum(count_RO258),
  count_RF258 = sum(count_RF258),
  count_LFN260 = sum(count_LFN260),
  count_RO260 = sum(count_RO260),
  count_RF260 = sum(count_RF260),
  count_RO259 = sum(count_RO259),
  count_closing = sum(count_closing),
  count_withdrawal = sum(count_withdrawal),
  count_press_releases = sum(count_press_releases),
  case_history = stringr::str_c(case_history, collapse = ", ")
 ) %>%
 dplyr::ungroup()

# count of decisions
cases$count_decisions <- stringr::str_count(cases$case_history, ",") + 1

# order decisions
for(i in 1:nrow(cases)) {
 if(stringr::str_detect(cases$case_history[i], ",")) {
  item <- stringr::str_split(cases$case_history[i], ", ")[[1]]
  date <- lubridate::ymd(stringr::str_extract(item, "[0-9]{4}-[0-9]{2}-[0-9]{2}$"))
  cases$case_history[i] <- stringr::str_c(item[order(date)], collapse = ", ")
 }
 else {
  next
 }
}

# clean workspace
rm(i, item, date)

##################################################
# identify missing data
##################################################

# missing LFN 258
cases$missing_LFN258 <- as.numeric(cases$count_LFN258 == 0)

# missing RO 258
cases$missing_RO258 <- as.numeric(cases$count_RO258 == 0 & (cases$count_RF258 > 0 | cases$count_LFN260 > 0 | cases$count_RO260 > 0 | cases$count_RF260 > 0))

# missing RF 258
cases$missing_RF258 <- as.numeric(cases$count_RF258 == 0 & (cases$count_LFN260 > 0 | cases$count_RO260 > 0 | cases$count_RF260 > 0))

# missing LFN 260
cases$missing_LFN260 <- as.numeric(cases$count_LFN260 == 0 & (cases$count_RO260 > 0 | cases$count_RF260 > 0))

# missing RO 260
cases$missing_RO260 <- as.numeric(cases$count_RO260 == 0 & cases$count_RF260 > 0)

# missing anything
cases$count_missing <- cases$missing_LFN258 + cases$missing_RO258 + cases$missing_RF258 + cases$missing_LFN260 + cases$missing_RO260

##################################################
# dummy variables
##################################################

cases$stage_LFN258 <- as.numeric(cases$count_LFN258 > 0)
cases$stage_RO258 <- as.numeric(cases$count_RO258 > 0)
cases$stage_RF258 <- as.numeric(cases$count_RF258 > 0)
cases$stage_LFN260 <- as.numeric(cases$count_LFN260 > 0)
cases$stage_RO260 <- as.numeric(cases$count_RO260 > 0)
cases$stage_RF260 <- as.numeric(cases$count_RF260 > 0)
cases$stage_RO259 <- as.numeric(cases$count_RO259 > 0)
cases$stage_closing <- as.numeric(cases$count_closing > 0)
cases$stage_withdrawal <- as.numeric(cases$count_withdrawal > 0)

##################################################
# completeness
##################################################

cases$complete <- as.numeric((cases$stage_closing == 1 | cases$stage_withdrawal == 1) & cases$count_missing == 0)

##################################################
# fill in missing data
##################################################

# make new variables
cases$corrected_LFN258 <- cases$stage_LFN258
cases$corrected_RO258 <- cases$stage_RO258
cases$corrected_RF258 <- cases$stage_RF258
cases$corrected_LFN260 <- cases$stage_LFN260
cases$corrected_RO260 <- cases$stage_RO260
cases$corrected_RF260 <- cases$stage_RF260

# if an Art. 258 reasoned opinion
cases$corrected_LFN258[cases$stage_RO258 == 1] <- 1

# if an Art. 258 referral
cases$corrected_LFN258[cases$stage_RF258 == 1] <- 1
cases$corrected_RO258[cases$stage_RF258 == 1] <- 1

# if an Art. 260 letter of formal notice
cases$corrected_LFN258[cases$stage_LFN260 == 1] <- 1
cases$corrected_RO258[cases$stage_LFN260 == 1] <- 1
cases$corrected_RF258[cases$stage_LFN260 == 1] <- 1

# if an Art. 260 reasoned opinion
cases$corrected_LFN258[cases$stage_RO260 == 1] <- 1
cases$corrected_RO258[cases$stage_RO260 == 1] <- 1
cases$corrected_RF258[cases$stage_RO260 == 1] <- 1
cases$corrected_LFN260[cases$stage_RO260 == 1] <- 1

# if an Art. 260 referral
cases$corrected_LFN258[cases$stage_RF260 == 1] <- 1
cases$corrected_RO258[cases$stage_RF260 == 1] <- 1
cases$corrected_RF258[cases$stage_RF260 == 1] <- 1
cases$corrected_LFN260[cases$stage_RF260 == 1] <- 1
cases$corrected_RO260[cases$stage_RF260 == 1] <- 1

##################################################
# organize data
##################################################

# sort observations
cases <- dplyr::arrange(cases, case_number)

# ID variable
cases$case_ID <- 1:nrow(cases)

# key ID
cases$key_ID <- 1:nrow(cases)

# select variables
cases <- dplyr::select(
 cases,
 key_ID, case_ID, case_number, case_year,
 member_state_ID, member_state, member_state_code,
 directorate_general_ID, directorate_general, directorate_general_code,
 directive, directive_number, CELEX_number,
 case_type_ID, case_type, noncommunication, nonconformity,
 complete, count_press_releases,
 stage_LFN258, stage_RO258, stage_RF258, stage_LFN260, stage_RO260, stage_RF260, stage_RO259, stage_closing, stage_withdrawal, case_history,
 corrected_LFN258, corrected_RO258, corrected_RF258, corrected_LFN260, corrected_RO260, corrected_RF260,
 count_decisions, count_LFN258, count_RO258, count_RF258, count_LFN260, count_RO260, count_RF260, count_RO259, count_closing, count_withdrawal,
 count_missing, missing_LFN258, missing_RO258, missing_RF258, missing_LFN260, missing_RO260
)

##################################################
# export data
##################################################

# read in data
save(cases, file = "data/cases.RData")

###########################################################################
# end R script
###########################################################################
