###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

# source files
source("replication-code/utilities/base_data.R")

##################################################
# cases_TS
##################################################

# create a template
template_TS <- expand.grid(
  2002:2020,
  decision_stages$decision_stage,
  stringsAsFactors = FALSE
)
names(template_TS) <- c("year", "decision_stage")

# collapse
decisions_TS <- decisions %>%
  dplyr::group_by(year, decision_stage) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>% dplyr::ungroup()

# merge in template
decisions_TS <- dplyr::left_join(template_TS, decisions_TS, by = c("year", "decision_stage"))

# code zeros
decisions_TS$count_cases[is.na(decisions_TS$count_cases)] <- 0

# merge in decision stage data
decisions_TS <- dplyr::left_join(decisions_TS, decision_stages, by = "decision_stage")

# arrange
decisions_TS <- dplyr::arrange(decisions_TS, year, decision_stage_ID)

# key ID
decisions_TS$key_ID <- 1:nrow(decisions_TS)

# select variables
decisions_TS <- dplyr::select(
  decisions_TS,
  key_ID, year, 
  decision_stage_ID, decision_stage,
  count_cases
)

# save
save(decisions_TS, file = "data/decisions_TS.RData")

##################################################
# cases_TS_D
##################################################

# create a template
template_TS_D <- expand.grid(
  2002:2020,
  case_types$case_type,
  decision_stages$decision_stage,
  stringsAsFactors = FALSE
)
names(template_TS_D) <- c("year", "case_type", "decision_stage")

# collapse
decisions_TS_D <- decisions %>%
  dplyr::group_by(year, case_type, decision_stage) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>% dplyr::ungroup()

# merge in template
decisions_TS_D <- dplyr::left_join(template_TS_D, decisions_TS_D, by = c("year", "case_type", "decision_stage"))

# code zeros
decisions_TS_D$count_cases[is.na(decisions_TS_D$count_cases)] <- 0

# merge in case type data
decisions_TS_D <- dplyr::left_join(decisions_TS_D, case_types, by = "case_type")

# merge in decision stage data
decisions_TS_D <- dplyr::left_join(decisions_TS_D, decision_stages, by = "decision_stage")

# arrange
decisions_TS_D <- dplyr::arrange(decisions_TS_D, year, case_type_ID, decision_stage_ID)

# key ID
decisions_TS_D$key_ID <- 1:nrow(decisions_TS_D)

# select variables
decisions_TS_D <- dplyr::select(
  decisions_TS_D,
  key_ID, year, 
  case_type_ID, case_type,
  decision_stage_ID, decision_stage,
  count_cases
)

# save
save(decisions_TS_D, file = "data/decisions_TS_D.RData")

###########################################################################
# end R script
###########################################################################
