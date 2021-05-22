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
decisions <- read.csv("data-raw/infringements_raw.csv", stringsAsFactors = FALSE)

##################################################
# clean data
##################################################

# rename variables
names(decisions) <- c("case_number", "decision_date", "decision_stage_raw", "press_release", "memo", "member_state", "department_raw", "case_description", "active", "noncommunication")

# case year
decisions$case_year <- as.numeric(stringr::str_extract(decisions$case_number, "^[0-9]{4}"))

# date
decisions$decision_date <- stringr::str_replace(decisions$decision_date, " .*", "")

# year
decisions$decision_year <- as.numeric(stringr::str_extract(decisions$decision_date, "[0-9]{4}"))

# month
decisions$decision_month <- stringr::str_extract(decisions$decision_date, "/[0-9]{2}/")
decisions$decision_month <- as.numeric(stringr::str_extract(decisions$decision_month, "[0-9]{2}"))

# day
decisions$decision_day <- as.numeric(stringr::str_extract(decisions$decision_date, "[0-9]{2}$"))

# non-communication
decisions$noncommunication <- as.numeric(decisions$noncommunication == "Yes")

# non-conformity
decisions$nonconformity <- 1 - decisions$noncommunication

# case type
decisions$case_type <- "noncommunication"
decisions$case_type[decisions$nonconformity == 1] <- "nonconformity"

# case type code
decisions$case_type_id <- 0
decisions$case_type_id[decisions$noncommunication == 1] <- 1
decisions$case_type_id[decisions$nonconformity == 1] <- 2

# additional decision
decisions$stage_additional <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Aa]dditional"))

# closing of the case
decisions$stage_closing <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "Closing"))

# withdrawal of the case
decisions$stage_withdrawal <- as.numeric(stringr::str_detect(decisions$decision_stage, "Withdrawal"))

# formal notice (article 258)
decisions$stage_lfn_258 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Ff]ormal notice") & stringr::str_detect(decisions$decision_stage_raw, "258"))

# formal notice (article 260)
decisions$stage_lfn_260 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Ff]ormal notice") & stringr::str_detect(decisions$decision_stage_raw, "260"))

# reasoned opinion (article 258)
decisions$stage_ro_258 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Rr]easoned opinion") & stringr::str_detect(decisions$decision_stage_raw, "258|226"))

# reasoned opinion (article 260)
decisions$stage_ro_260 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Rr]easoned opinion") & stringr::str_detect(decisions$decision_stage_raw, "260|228"))

# referral (article 258)
decisions$stage_rf_258 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Rr]eferral") & stringr::str_detect(decisions$decision_stage_raw, "258"))

# referral (article 260)
decisions$stage_rf_260 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Rr]eferral") & stringr::str_detect(decisions$decision_stage_raw, "260"))

# fix referral (article 258)
decisions$stage_rf_260_3 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "258") & stringr::str_detect(decisions$decision_stage_raw, "260"))

# press release link
decisions$press_release_link <- stringr::str_extract(decisions$press_release, "IP-[0-9]+-[0-9]+")
decisions$press_release_link <- stringr::str_c("https://ec.europa.eu/commission/presscorner/detail/EN/", decisions$press_release_link)

# press release
decisions$press_release <- as.numeric(!is.na(decisions$press_release_link))

# drop memo
decisions <- dplyr::select(decisions, -c(memo, active))

# drop Article 260(3) decisions
decisions <- dplyr::filter(decisions, stage_rf_260_3 == 0)

##################################################
# clean member state names
##################################################

decisions$member_state[decisions$member_state == "Luxemburg"] <- "Luxembourg"

##################################################
# clean departments names
##################################################

# department variable
decisions$department <- stringr::str_c("Directorate-General for ", decisions$department_raw)

# clean names
decisions$department[stringr::str_detect(decisions$department, "Secretariat General")] <- "Secretariat-General"
decisions$department[stringr::str_detect(decisions$department, "Eurostat")] <- "Eurostat"
decisions$department[stringr::str_detect(decisions$department, "Legal Service")] <- "Legal Service"

# recode to match current names
decisions$department[decisions$department == "Directorate-General for Justice, Fundamental Rights and Citizenship"] <- "Directorate-General for Justice and Consumers"
decisions$department[decisions$department == "Directorate-General for Communication Networks, Content and Technology"] <- "Directorate-General for Communications Networks, Content and Technology"
decisions$department[decisions$department == "Directorate-General for Defence Industry and Space"] <- "Directorate-General for Defense Industry and Space"
decisions$department[decisions$department == "Directorate-General for Internal Market and services"] <- "Directorate-General for Internal Market and Services"
decisions$department[decisions$department == "Directorate-General for External relations"] <- "Directorate-General for External Relations"

##################################################
# clean date
##################################################

decisions$decision_date <- stringr::str_replace_all(decisions$decision_date, "/", "-")
decisions$decision_date <- lubridate::ymd(decisions$decision_date)

##################################################
# clean description
##################################################

# clean description
decisions$case_description <- stringr::str_to_lower(decisions$case_description)

# ensure case descriptions are consistent
decisions <- decisions %>%
  dplyr::group_by(case_number) %>%
  dplyr::mutate(case_description = case_description[1]) %>%
  dplyr::ungroup()

##################################################
# decision stage
##################################################

# decision stage
decisions$decision_stage <- "other"
decisions$decision_stage[decisions$stage_lfn_258 == 1] <- "letter of formal notice (258)"
decisions$decision_stage[decisions$stage_ro_258 == 1] <- "reasoned opinion (258)"
decisions$decision_stage[decisions$stage_rf_258 == 1] <- "referral to the court (258)"
decisions$decision_stage[decisions$stage_lfn_260 == 1] <- "letter of formal notice (260)"
decisions$decision_stage[decisions$stage_ro_260 == 1] <- "reasoned opinion (260)"
decisions$decision_stage[decisions$stage_rf_260 == 1] <- "referral to the court (260)"
decisions$decision_stage[decisions$stage_closing == 1] <- "closing"
decisions$decision_stage[decisions$stage_withdrawal == 1] <- "withdrawal"

# decision stage ID
decisions$decision_stage_id <- NA
decisions$decision_stage_id[decisions$stage_lfn_258 == 1] <- 1
decisions$decision_stage_id[decisions$stage_ro_258 == 1] <- 2
decisions$decision_stage_id[decisions$stage_rf_258 == 1] <- 3
decisions$decision_stage_id[decisions$stage_lfn_260 == 1] <- 4
decisions$decision_stage_id[decisions$stage_ro_260 == 1] <- 5
decisions$decision_stage_id[decisions$stage_rf_260 == 1] <- 6
decisions$decision_stage_id[decisions$stage_closing == 1] <- 7
decisions$decision_stage_id[decisions$stage_withdrawal == 1] <- 8

##################################################
# ID variables
##################################################

# read in data
load("data-raw/member_states.RData")

# select variables
member_states <- dplyr::select(member_states, member_state, member_state_code, member_state_id)

# read in data
load("data-raw/departments.RData")

# select variables
departments <- dplyr::select(
  departments,
  department_id, department_name, department_code
)

# rename variable
departments <- dplyr::rename(departments, department = department_name)

# merge
decisions <- dplyr::left_join(decisions, member_states, by = "member_state")
decisions <- dplyr::left_join(decisions, departments, by = "department")

# clean workspace
rm(member_states, departments)

##################################################
# directive
##################################################

# directive number
decisions$directive_number <- stringr::str_extract(decisions$case_description, "(directive|dir\\.|dir) ([0-9]{2}|[0-9]{4})/[0-9]+")
decisions$directive_number <- stringr::str_extract(decisions$directive_number, "([0-9]{2}|[0-9]{4})/[0-9]+")
decisions$directive_number <- stringr::str_replace(decisions$directive_number, "^([6789][0-9])/", "19\\1/")
decisions$directive_number <- stringr::str_replace(decisions$directive_number, "^(0[0-9])/", "20\\1/")

# CELEX number
decisions$celex <- NA
for (i in 1:nrow(decisions)) {
  if (is.na(decisions$directive_number)[i]) {
    next
  }
  year <- stringr::str_extract(decisions$directive_number[i], "^[0-9]{4}")
  number <- stringr::str_extract(decisions$directive_number[i], "[0-9]+$")
  number <- stringr::str_pad(number, width = 4, side = "left", pad = "0")
  celex <- stringr::str_c("3", year, "L", number, sep = "")
  decisions$celex[i] <- celex
}

# clean workspace
rm(i, number, celex, year)

# fill in missing
decisions$celex[is.na(decisions$celex)] <- "none"
decisions$directive_number[is.na(decisions$directive_number)] <- "none"

# has directive
decisions$directive <- as.numeric(!is.na(decisions$directive_number))

##################################################
# filter obesrvations
##################################################

# drop minor procedures
decisions <- dplyr::filter(decisions, decision_stage != "other")

##################################################
# organize data
##################################################

# sort observations
decisions <- dplyr::arrange(decisions, decision_date, case_number, decision_stage)

# ID variable
decisions$decision_id <- 1:nrow(decisions)

# key ID
decisions$key_id <- 1:nrow(decisions)

# sort variables
decisions <- dplyr::select(
  decisions,
  key_id, decision_id, case_number, case_year,
  decision_date, decision_year, decision_month, decision_day,
  member_state_id, member_state, member_state_code,
  department_id, department, department_code,
  case_type_id, case_type, noncommunication, nonconformity,
  directive, directive_number, celex,
  decision_stage_id, decision_stage,
  stage_lfn_258, stage_ro_258, stage_rf_258, stage_lfn_260, stage_ro_260, stage_rf_260,
  stage_closing, stage_withdrawal, stage_additional,
  press_release
)

##################################################
# export data
##################################################

# write data
save(decisions, file = "data/decisions.RData")

################################################################################
# end R script
################################################################################
