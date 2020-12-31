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
load("data/cases.RData")

# make a new tibble
duration <- cases
rm(cases)

# keep only complete cases
duration <- dplyr::filter(duration, complete == 1)

# select variables
duration <- dplyr::select(
 duration,
 case_ID, case_number, case_year,
 member_state_ID, member_state, member_state_code,
 directorate_general_ID, directorate_general, directorate_general_code,
 case_type_ID, case_type, noncommunication, nonconformity,
 stage_LFN258, stage_RO258, stage_RF258, stage_LFN260, stage_RO260, stage_RF260, stage_closing, stage_withdrawal, case_history
)

##################################################
# date of first decision in each stage
##################################################

# Art. 258 letter of formal notice
duration$date_LFN258 <- stringr::str_extract(duration$case_history, "LFN258-[0-9]{4}-[0-9]{2}-[0-9]{2}")
duration$date_LFN258 <- lubridate::ymd(stringr::str_extract(duration$date_LFN258, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

# Art. 258 reasoned opinion
duration$date_RO258 <- stringr::str_extract(duration$case_history, "RO258-[0-9]{4}-[0-9]{2}-[0-9]{2}")
duration$date_RO258 <- lubridate::ymd(stringr::str_extract(duration$date_RO258, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

# Art. 258 referral
duration$date_RF258 <- stringr::str_extract(duration$case_history, "RF258-[0-9]{4}-[0-9]{2}-[0-9]{2}")
duration$date_RF258 <- lubridate::ymd(stringr::str_extract(duration$date_RF258, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

# Art. 260 letter of formal notice
duration$date_LFN260 <- stringr::str_extract(duration$case_history, "LFN260-[0-9]{4}-[0-9]{2}-[0-9]{2}")
duration$date_LFN260 <- lubridate::ymd(stringr::str_extract(duration$date_LFN260, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

# Art. 260 reasoned opinion
duration$date_RO260 <- stringr::str_extract(duration$case_history, "RO260-[0-9]{4}-[0-9]{2}-[0-9]{2}")
duration$date_RO260 <- lubridate::ymd(stringr::str_extract(duration$date_RO260, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

# Art. 260 referral
duration$date_RF260 <- stringr::str_extract(duration$case_history, "RF260-[0-9]{4}-[0-9]{2}-[0-9]{2}")
duration$date_RF260 <- lubridate::ymd(stringr::str_extract(duration$date_RF260, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

# closing
duration$date_closing <- stringr::str_extract(duration$case_history, "C-[0-9]{4}-[0-9]{2}-[0-9]{2}$")
duration$date_closing <- lubridate::ymd(stringr::str_extract(duration$date_closing, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

# withdrawal
duration$date_withdrawal <- stringr::str_extract(duration$case_history, "W-[0-9]{4}-[0-9]{2}-[0-9]{2}$")
duration$date_withdrawal <- lubridate::ymd(stringr::str_extract(duration$date_withdrawal, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

# end
duration$date_end <- stringr::str_extract(duration$case_history, "[CW]-[0-9]{4}-[0-9]{2}-[0-9]{2}$")
duration$date_end <- lubridate::ymd(stringr::str_extract(duration$date_end, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))

##################################################
# end date of each stage
##################################################

# end date of LFN258 stage
duration$date_end_LFN258 <- as.Date(NA)
duration$date_end_LFN258[duration$stage_LFN258 == 1 & duration$stage_RO258 == 1] <- duration$date_RO258[duration$stage_LFN258 == 1 & duration$stage_RO258 == 1]
duration$date_end_LFN258[duration$stage_LFN258 == 1 & duration$stage_RO258 == 0] <- duration$date_end[duration$stage_LFN258 == 1 & duration$stage_RO258 == 0]

# end date of RO258 stage
duration$date_end_RO258 <- as.Date(NA)
duration$date_end_RO258[duration$stage_RO258 == 1 & duration$stage_RF258 == 1] <- duration$date_RF258[duration$stage_RO258 == 1 & duration$stage_RF258 == 1]
duration$date_end_RO258[duration$stage_RO258 == 1 & duration$stage_RF258 == 0] <- duration$date_end[duration$stage_RO258 == 1 & duration$stage_RF258 == 0]

# end date of RF258 stage
duration$date_end_RF258 <- as.Date(NA)
duration$date_end_RF258[duration$stage_RF258 == 1 & duration$stage_LFN260 == 1] <- duration$date_LFN260[duration$stage_RF258 == 1 & duration$stage_LFN260 == 1]
duration$date_end_RF258[duration$stage_RF258 == 1 & duration$stage_LFN260 == 0] <- duration$date_end[duration$stage_RF258 == 1 & duration$stage_LFN260 == 0]

# end date of LFN260 stage
duration$date_end_LFN260 <- as.Date(NA)
duration$date_end_LFN260[duration$stage_LFN260 == 1 & duration$stage_RO260 == 1] <- duration$date_RO260[duration$stage_LFN260 == 1 & duration$stage_RO260 == 1]
duration$date_end_LFN260[duration$stage_LFN260 == 1 & duration$stage_RO260 == 0] <- duration$date_end[duration$stage_LFN260 == 1 & duration$stage_RO260 == 0]

# end date of RO260 stage
duration$date_end_RO260 <- as.Date(NA)
duration$date_end_RO260[duration$stage_RO260 == 1 & duration$stage_RF260 == 1] <- duration$date_RF260[duration$stage_RO260 == 1 & duration$stage_RF260 == 1]
duration$date_end_RO260[duration$stage_RO260 == 1 & duration$stage_RF260 == 0] <- duration$date_end[duration$stage_RO260 == 1 & duration$stage_RF260 == 0]

# end date of RF260 stage
duration$date_end_RF260 <- as.Date(NA)
duration$date_end_RF260[duration$stage_RF260 == 1] <- duration$date_end[duration$stage_RF260 == 1]

##################################################
# duration variables
##################################################

duration$duration_case <- as.numeric(duration$date_end - duration$date_LFN258)
duration$duration_LFN258 <- as.numeric(duration$date_end_LFN258 - duration$date_LFN258)
duration$duration_RO258 <- as.numeric(duration$date_end_RO258 - duration$date_RO258)
duration$duration_RF258 <- as.numeric(duration$date_end_RF258 - duration$date_RF258)
duration$duration_LFN260 <- as.numeric(duration$date_end_LFN260 - duration$date_LFN260)
duration$duration_RO260 <- as.numeric(duration$date_end_RO260 - duration$date_RO260)
duration$duration_RF260 <- as.numeric(duration$date_end_RF260 - duration$date_RF260)
duration$duration_prelitigation <- duration$duration_LFN258 + ifelse(is.na(duration$duration_RO258), 0, duration$duration_RO258)
duration$duration_litigation <- duration$duration_RF258

##################################################
# export
##################################################

# key ID
duration$key_ID <- 1:nrow(duration)

# select variables
duration <- dplyr::select(
 duration,
 key_ID, case_ID, case_number, case_year,
 member_state_ID, member_state, member_state_code,
 directorate_general_ID, directorate_general, directorate_general_code,
 case_type_ID, case_type, noncommunication, nonconformity,
 stage_LFN258, stage_RO258, stage_RF258, stage_LFN260, stage_RO260, stage_RF260, stage_closing, stage_withdrawal, case_history,
 date_LFN258, date_RO258, date_RF258, date_LFN260, date_RO260, date_RF260, date_closing, date_withdrawal, date_end,
 date_end_LFN258, date_end_RO258, date_end_RF258, date_end_LFN260, date_end_RO260, date_end_RF260,
 duration_case, duration_LFN258, duration_RO258, duration_RF258, duration_LFN260, duration_RO260, duration_RF260, duration_prelitigation, duration_litigation
)

##################################################
# export data
##################################################

# read in data
save(duration, file = "data/duration.RData")

###########################################################################
# end R script
###########################################################################
