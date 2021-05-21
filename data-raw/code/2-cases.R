################################################################################
# Joshua C. Fjelstul, Ph.D.
# euip R package
################################################################################

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

# decision stage code
cases$decision_stage_code <- NA
cases$decision_stage_code[cases$stage_lfn_258 == 1] <- "LFN258"
cases$decision_stage_code[cases$stage_ro_258 == 1] <- "RO258"
cases$decision_stage_code[cases$stage_rf_258 == 1] <- "RF258"
cases$decision_stage_code[cases$stage_lfn_260 == 1] <- "LFN260"
cases$decision_stage_code[cases$stage_ro_260 == 1] <- "RO260"
cases$decision_stage_code[cases$stage_rf_260 == 1] <- "RF260"
cases$decision_stage_code[cases$stage_closing == 1] <- "C"
cases$decision_stage_code[cases$stage_withdrawal == 1] <- "W"

# collapse data by case number and decision stage
cases <- cases %>%
  dplyr::group_by(case_number, decision_stage) %>%
  dplyr::summarize(
    case_year = unique(case_year),
    member_state_id = unique(member_state_id),
    member_state = unique(member_state),
    member_state_code = unique(member_state_code),
    department_id = unique(department_id),
    department = unique(department),
    department_code = unique(department_code),
    directive = unique(directive),
    directive_number = unique(directive_number),
    celex = unique(celex),
    case_type_id = unique(case_type_id),
    case_type = unique(case_type),
    noncommunication = unique(noncommunication),
    nonconformity = unique(nonconformity),
    count_lfn_258 = sum(stage_lfn_258),
    count_ro_258 = sum(stage_ro_258),
    count_rf_258 = sum(stage_rf_258),
    count_lfn_260 = sum(stage_lfn_260),
    count_ro_260 = sum(stage_ro_260),
    count_rf_260 = sum(stage_rf_260),
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
    member_state_id = unique(member_state_id),
    member_state = unique(member_state),
    member_state_code = unique(member_state_code),
    department_id = unique(department_id),
    department = unique(department),
    department_code = unique(department_code),
    directive = unique(directive),
    directive_number = unique(directive_number),
    celex = unique(celex),
    case_type_id = unique(case_type_id),
    case_type = unique(case_type),
    noncommunication = unique(noncommunication),
    nonconformity = unique(nonconformity),
    count_lfn_258 = sum(count_lfn_258),
    count_ro_258 = sum(count_ro_258),
    count_rf_258 = sum(count_rf_258),
    count_lfn_260 = sum(count_lfn_260),
    count_ro_260 = sum(count_ro_260),
    count_rf_260 = sum(count_rf_260),
    count_closing = sum(count_closing),
    count_withdrawal = sum(count_withdrawal),
    count_press_releases = sum(count_press_releases),
    case_history = stringr::str_c(case_history, collapse = ", ")
  ) %>%
  dplyr::ungroup()

# count of decisions
cases$count_decisions <- stringr::str_count(cases$case_history, ",") + 1

# order decisions
for (i in 1:nrow(cases)) {
  if (stringr::str_detect(cases$case_history[i], ",")) {
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
cases$missing_lfn_258 <- as.numeric(cases$count_lfn_258 == 0)

# missing RO 258
cases$missing_ro_258 <- as.numeric(cases$count_ro_258 == 0 & (cases$count_rf_258 > 0 | cases$count_lfn_260 > 0 | cases$count_ro_260 > 0 | cases$count_rf_260 > 0))

# missing RF 258
cases$missing_rf_258 <- as.numeric(cases$count_rf_258 == 0 & (cases$count_lfn_260 > 0 | cases$count_ro_260 > 0 | cases$count_rf_260 > 0))

# missing LFN 260
cases$missing_lfn_260 <- as.numeric(cases$count_lfn_260 == 0 & (cases$count_ro_260 > 0 | cases$count_rf_260 > 0))

# missing RO 260
cases$missing_ro_260 <- as.numeric(cases$count_ro_260 == 0 & cases$count_rf_260 > 0)

# missing anything
cases$count_missing <- cases$missing_lfn_258 + cases$missing_ro_258 + cases$missing_rf_258 + cases$missing_lfn_260 + cases$missing_ro_260

##################################################
# dummy variables
##################################################

cases$stage_lfn_258 <- as.numeric(cases$count_lfn_258 > 0)
cases$stage_ro_258 <- as.numeric(cases$count_ro_258 > 0)
cases$stage_rf_258 <- as.numeric(cases$count_rf_258 > 0)
cases$stage_lfn_260 <- as.numeric(cases$count_lfn_260 > 0)
cases$stage_ro_260 <- as.numeric(cases$count_ro_260 > 0)
cases$stage_rf_260 <- as.numeric(cases$count_rf_260 > 0)
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
cases$corrected_lfn_258 <- cases$stage_lfn_258
cases$corrected_ro_258 <- cases$stage_ro_258
cases$corrected_rf_258 <- cases$stage_rf_258
cases$corrected_lfn_260 <- cases$stage_lfn_260
cases$corrected_ro_260 <- cases$stage_ro_260
cases$corrected_rf_260 <- cases$stage_rf_260

# if an Art. 258 reasoned opinion
cases$corrected_lfn_258[cases$stage_ro_258 == 1] <- 1

# if an Art. 258 referral
cases$corrected_lfn_258[cases$stage_rf_258 == 1] <- 1
cases$corrected_ro_258[cases$stage_rf_258 == 1] <- 1

# if an Art. 260 letter of formal notice
cases$corrected_lfn_258[cases$stage_lfn_260 == 1] <- 1
cases$corrected_ro_258[cases$stage_lfn_260 == 1] <- 1
cases$corrected_rf_258[cases$stage_lfn_260 == 1] <- 1

# if an Art. 260 reasoned opinion
cases$corrected_lfn_258[cases$stage_ro_260 == 1] <- 1
cases$corrected_ro_258[cases$stage_ro_260 == 1] <- 1
cases$corrected_rf_258[cases$stage_ro_260 == 1] <- 1
cases$corrected_lfn_260[cases$stage_ro_260 == 1] <- 1

# if an Art. 260 referral
cases$corrected_lfn_258[cases$stage_rf_260 == 1] <- 1
cases$corrected_ro_258[cases$stage_rf_260 == 1] <- 1
cases$corrected_rf_258[cases$stage_rf_260 == 1] <- 1
cases$corrected_lfn_260[cases$stage_rf_260 == 1] <- 1
cases$corrected_ro_260[cases$stage_rf_260 == 1] <- 1

##################################################
# organize data
##################################################

# sort observations
cases <- dplyr::arrange(cases, case_number)

# ID variable
cases$case_id <- 1:nrow(cases)

# key ID
cases$key_id <- 1:nrow(cases)

# select variables
cases <- dplyr::select(
  cases,
  key_id, case_id, case_number, case_year,
  member_state_id, member_state, member_state_code,
  department_id, department, department_code,
  directive, directive_number, celex,
  case_type_id, case_type, noncommunication, nonconformity,
  complete, count_press_releases,
  stage_lfn_258, stage_ro_258, stage_rf_258, stage_lfn_260, stage_ro_260, stage_rf_260, stage_closing, stage_withdrawal, case_history,
  corrected_lfn_258, corrected_ro_258, corrected_rf_258, corrected_lfn_260, corrected_ro_260, corrected_rf_260,
  count_decisions, count_lfn_258, count_ro_258, count_rf_258, count_lfn_260, count_ro_260, count_rf_260,
  count_missing, missing_lfn_258, missing_ro_258, missing_rf_258, missing_lfn_260, missing_ro_260
)

##################################################
# export data
##################################################

# read in data
save(cases, file = "data/cases.RData")

################################################################################
# end R script
################################################################################
