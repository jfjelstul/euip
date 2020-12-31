###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

# source files
source("replication-code/create_template.R")
source("replication-code/base_data.R")

##################################################
# cases_TS_MS
##################################################

# create a template
template_TS_MS <- create_template(
  member_states$member_state, 
  2002:2020, 
  names = c("member_state", "year")
)

# collapse
cases_TS_MS <- cases %>%
  dplyr::group_by(member_state, year) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>% dplyr::ungroup()

# merge in template
cases_TS_MS <- dplyr::left_join(template_TS_MS, cases_TS_MS, by = c("member_state", "year"))

# code zeros
cases_TS_MS$count_cases[is.na(cases_TS_MS$count_cases)] <- 0

# merge in member state data
cases_TS_MS <- dplyr::left_join(cases_TS_MS, member_states, by = "member_state")

# arrange
cases_TS_MS <- dplyr::arrange(cases_TS_MS, year, member_state_ID)

# key ID
cases_TS_MS$key_ID <- 1:nrow(cases_TS_MS)

# select variables
cases_TS_MS <- dplyr::select(
  cases_TS_MS,
  key_ID, year, 
  member_state_ID, member_state, member_state_code, 
  count_cases
)

# save
save(cases_TS_MS, file = "data/cases_TS_MS.RData")

##################################################
# cases_TS_MS_D
##################################################

# create a template
template_TS_MS_D <- create_template(
  member_states$member_state, 
  2002:2020, 
  case_types$case_type,
  names = c("member_state", "year", "case_type")
)

# collapse
cases_TS_MS_D <- cases %>%
  dplyr::group_by(member_state, year, case_type) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
cases_TS_MS_D <- dplyr::left_join(template_TS_MS_D, cases_TS_MS_D, by = c("member_state", "year", "case_type"))

# code zeros
cases_TS_MS_D$count_cases[is.na(cases_TS_MS_D$count_cases)] <- 0

# merge in member state data
cases_TS_MS_D <- dplyr::left_join(cases_TS_MS_D, member_states, by = "member_state")

# merge in case type data
cases_TS_MS_D <- dplyr::left_join(cases_TS_MS_D, case_types, by = "case_type")

# arrange
cases_TS_MS_D <- dplyr::arrange(cases_TS_MS_D, year, member_state_ID, case_type_ID)

# key ID
cases_TS_MS_D$key_ID <- 1:nrow(cases_TS_MS_D)

# select variables
cases_TS_MS_D <- dplyr::select(
  cases_TS_MS_D,
  key_ID, year, 
  member_state_ID, member_state, member_state_code, 
  case_type_ID, case_type, 
  count_cases
)

# save
save(cases_TS_MS_D, file = "data/cases_TS_MS_D.RData")

##################################################
# cases_TS_DG
##################################################

# create a template
template_TS_DG <- create_template(
  directorates_general$directorate_general, 
  2002:2020,
  names = c("directorate_general", "year")
)

# collapse
cases_TS_DG <- cases %>%
  dplyr::group_by(directorate_general, year) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>% dplyr::ungroup()

# merge
cases_TS_DG <- dplyr::left_join(template_TS_DG, cases_TS_DG, by = c("directorate_general", "year"))

# code zeros
cases_TS_DG$count_cases[is.na(cases_TS_DG$count_cases)] <- 0

# merge in DG
cases_TS_DG <- dplyr::left_join(cases_TS_DG, directorates_general, by = "directorate_general")

# arrange
cases_TS_DG <- dplyr::arrange(cases_TS_DG, year, directorate_general_ID)

# key ID
cases_TS_DG$key_ID <- 1:nrow(cases_TS_DG)

# select variables
cases_TS_DG <- dplyr::select(
  cases_TS_DG,
  key_ID, year, 
  directorate_general_ID, directorate_general, directorate_general_code, 
  count_cases
)

# save
save(cases_TS_DG, file = "data/cases_TS_DG.RData")

##################################################
# cases_TS_DG_D
##################################################

# template
template_TS_DG_D <- create_template(
  directorates_general$directorate_general, 
  2002:2020, 
  case_types$case_type,
  names = c("directorate_general", "year", "case_type")
)

# collapse
cases_TS_DG_D <- cases %>%
  dplyr::group_by(directorate_general, year, case_type) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>% dplyr::ungroup()

# merge
cases_TS_DG_D <- dplyr::left_join(template_TS_DG_D, cases_TS_DG_D, by = c("directorate_general", "year", "case_type"))

# code zeros
cases_TS_DG_D$count_cases[is.na(cases_TS_DG_D$count_cases)] <- 0

# merge in member state data
cases_TS_DG_D <- dplyr::left_join(cases_TS_DG_D, directorates_general, by = "directorate_general")

# merge in case type data
cases_TS_DG_D <- dplyr::left_join(cases_TS_DG_D, case_types, by = "case_type")

# arrange
cases_TS_DG_D <- dplyr::arrange(cases_TS_DG_D, year, directorate_general_ID, case_type_ID)

# key ID
cases_TS_DG_D$key_ID <- 1:nrow(cases_TS_DG_D)

# select variables
cases_TS_DG_D <- dplyr::select(
  cases_TS_DG_D,
  key_ID, year, 
  directorate_general_ID, directorate_general, directorate_general_code, 
  case_type_ID, case_type, 
  count_cases
)

# save
save(cases_TS_DG_D, file = "data/cases_TS_DG_D.RData")

###########################################################################
# end R script
###########################################################################
