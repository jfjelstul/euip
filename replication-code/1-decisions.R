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
decisions <- read.csv("data-raw/infringements-raw.csv", stringsAsFactors = FALSE)

##################################################
# clean data
##################################################

# rename variables
names(decisions) <- c("case_number", "decision_date", "decision_stage_raw", "press_release", "memo", "member_state", "directorate_general_raw", "case_description", "active", "noncommunication")

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
decisions$case_type_ID <- 0
decisions$case_type_ID[decisions$noncommunication == 1] <- 1
decisions$case_type_ID[decisions$nonconformity == 1] <- 2

# additional decision
decisions$stage_additional <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Aa]dditional"))

# closing of the case
decisions$stage_closing <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "Closing"))

# withdrawal of the case
decisions$stage_withdrawal <- as.numeric(stringr::str_detect(decisions$decision_stage, "Withdrawal"))

# formal notice (article 258)
decisions$stage_LFN258 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Ff]ormal notice") & stringr::str_detect(decisions$decision_stage_raw, "258"))

# formal notice (article 260)
decisions$stage_LFN260 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Ff]ormal notice") & stringr::str_detect(decisions$decision_stage_raw, "260"))

# reasoned opinion (article 258)
decisions$stage_RO258 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Rr]easoned opinion") & stringr::str_detect(decisions$decision_stage_raw, "258|226"))

# reasoned opinion (article 260)
decisions$stage_RO260 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Rr]easoned opinion") & stringr::str_detect(decisions$decision_stage_raw, "260|228"))

# referral (article 258)
decisions$stage_RF258 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Rr]eferral") & stringr::str_detect(decisions$decision_stage_raw, "258"))

# referral (article 260)
decisions$stage_RF260 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "[Rr]eferral") & stringr::str_detect(decisions$decision_stage_raw, "260"))

# fix referral (article 258)
decisions$stage_RF260_3 <- as.numeric(stringr::str_detect(decisions$decision_stage_raw, "258") & stringr::str_detect(decisions$decision_stage_raw, "260"))

# press release link
decisions$press_release_link <- stringr::str_extract(decisions$press_release, "IP-[0-9]+-[0-9]+")
decisions$press_release_link <- stringr::str_c("https://ec.europa.eu/commission/presscorner/detail/EN/", decisions$press_release_link)

# press release
decisions$press_release <- as.numeric(!is.na(decisions$press_release_link))

# drop memo
decisions <- dplyr::select(decisions, -c(memo, active))

# drop Article 260(3) decisions
decisions <- dplyr::filter(decisions, stage_RF260_3 == 0)

##################################################
# clean member state names
##################################################

decisions$member_state[decisions$member_state == "Luxemburg"] <- "Luxembourg"

##################################################
# clean DG names
##################################################

decisions$directorate_general_raw[decisions$directorate_general_raw == "External relations"] <- "External Relations"
decisions$directorate_general_raw[decisions$directorate_general_raw == "Internal Market and services"] <- "Internal Market and Services"
decisions$directorate_general_raw[decisions$directorate_general_raw == "Secretariat General"] <- "Secretariat-General"

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
decisions$decision_stage <- "Other"
decisions$decision_stage[decisions$stage_LFN258 == 1] <- "Letter of formal notice (Art. 258)"
decisions$decision_stage[decisions$stage_RO258 == 1] <- "Reasoned opinion (Art. 258)"
decisions$decision_stage[decisions$stage_RF258 == 1] <- "Referral to the Court (Art. 258)"
decisions$decision_stage[decisions$stage_LFN260 == 1] <- "Letter of formal notice (Art. 260)"
decisions$decision_stage[decisions$stage_RO260 == 1] <- "Reasoned opinion (Art. 260)"
decisions$decision_stage[decisions$stage_RF260 == 1] <- "Referral to the Court (Art. 260)"
decisions$decision_stage[decisions$stage_closing == 1] <- "Closing"
decisions$decision_stage[decisions$stage_withdrawal == 1] <- "Withdrawal"

# decision stage ID
decisions$decision_stage_ID <- NA
decisions$decision_stage_ID[decisions$stage_LFN258 == 1] <- 1
decisions$decision_stage_ID[decisions$stage_RO258 == 1] <- 2
decisions$decision_stage_ID[decisions$stage_RF258 == 1] <- 3
decisions$decision_stage_ID[decisions$stage_LFN260 == 1] <- 4
decisions$decision_stage_ID[decisions$stage_RO260 == 1] <- 5
decisions$decision_stage_ID[decisions$stage_RF260 == 1] <- 6
decisions$decision_stage_ID[decisions$stage_closing == 1] <- 7
decisions$decision_stage_ID[decisions$stage_withdrawal == 1] <- 8

##################################################
# ID variables
##################################################

# read in data
member_states <- read.csv("data-raw/member-states.csv", stringsAsFactors = FALSE)

# select variables
member_states <- dplyr::select(member_states, member_state, member_state_code, member_state_ID)

# read in data
directorates_general <- read.csv("data-raw/directorates-general.csv", stringsAsFactors = FALSE)

# merge
decisions <- dplyr::left_join(decisions, member_states, by = c("member_state"))
decisions <- dplyr::left_join(decisions, directorates_general, by = c("directorate_general_raw" = "merge_ID"))

# clean workspace
rm(member_states, directorates_general)

##################################################
# directive
##################################################

# directive number
decisions$directive_number <- stringr::str_extract(decisions$case_description, "(directive|dir\\.|dir) ([0-9]{2}|[0-9]{4})/[0-9]+")
decisions$directive_number <- stringr::str_extract(decisions$directive_number, "([0-9]{2}|[0-9]{4})/[0-9]+")
decisions$directive_number <- stringr::str_replace(decisions$directive_number, "^([6789][0-9])/", "19\\1/")
decisions$directive_number <- stringr::str_replace(decisions$directive_number, "^(0[0-9])/", "20\\1/")

# CELEX number
decisions$CELEX_number <- NA
for(i in 1:nrow(decisions)) {
 if(is.na(decisions$directive_number)[i]) {
  next
 }
 year <- stringr::str_extract(decisions$directive_number[i], "^[0-9]{4}")
 number <- stringr::str_extract(decisions$directive_number[i], "[0-9]+$")
 number <- stringr::str_pad(number, width = 4, side = "left", pad = "0")
 celex <- stringr::str_c("3", year, "L", number,  sep = "")
 decisions$CELEX_number[i] <- celex
}

# clean workspace
rm(i, number, celex, year)

# has directive
decisions$directive <- as.numeric(!is.na(decisions$directive_number))

##################################################
# filter obesrvations
##################################################

# drop minor procedures
decisions <- dplyr::filter(decisions, decision_stage != "Other")

##################################################
# organize data
##################################################

# sort observations
decisions <- dplyr::arrange(decisions, decision_date, case_number, decision_stage)

# ID variable
decisions$decision_ID <- 1:nrow(decisions)

# key ID
decisions$key_ID <- 1:nrow(decisions)

# sort variables
decisions <- dplyr::select(
 decisions,
 key_ID, decision_ID, case_number, case_year,
 decision_date, decision_year, decision_month, decision_day,
 member_state_ID, member_state, member_state_code,
 directorate_general_ID, directorate_general, directorate_general_code,
 case_type_ID, case_type, noncommunication, nonconformity,
 directive, directive_number, CELEX_number,
 decision_stage_ID, decision_stage,
 stage_LFN258, stage_RO258, stage_RF258, stage_LFN260, stage_RO260, stage_RF260, 
 stage_closing, stage_withdrawal, stage_additional,
 press_release
)

##################################################
# export data
##################################################

# write data
save(decisions, file = "data/decisions.RData")

###########################################################################
# end R script
###########################################################################
