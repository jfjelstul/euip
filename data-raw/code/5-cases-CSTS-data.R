################################################################################
# Joshua C. Fjelstul, Ph.D.
# euip R package
################################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

# source files
source("data-raw/code/utilities/create_template.R")
source("data-raw/code/utilities/base_data.R")

##################################################
# cases_csts_ms
##################################################

# create a template
template_csts_ms <- create_template(
  member_states$member_state,
  2002:2020,
  names = c("member_state", "year")
)

# collapse
cases_csts_ms <- cases %>%
  dplyr::group_by(member_state, year) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge in template
cases_csts_ms <- dplyr::left_join(template_csts_ms, cases_csts_ms, by = c("member_state", "year"))

# code zeros
cases_csts_ms$count_cases[is.na(cases_csts_ms$count_cases)] <- 0

# merge in member state data
cases_csts_ms <- dplyr::left_join(cases_csts_ms, member_states, by = "member_state")

# arrange
cases_csts_ms <- dplyr::arrange(cases_csts_ms, year, member_state_id)

# key ID
cases_csts_ms$key_id <- 1:nrow(cases_csts_ms)

# select variables
cases_csts_ms <- dplyr::select(
  cases_csts_ms,
  key_id, year,
  member_state_id, member_state, member_state_code, count_cases
)

# save
save(cases_csts_ms, file = "data/cases_csts_ms.RData")

##################################################
# cases_csts_ms_d
##################################################

# create a template
template_csts_ms_d <- create_template(
  member_states$member_state,
  2002:2020,
  case_types$case_type,
  names = c("member_state", "year", "case_type")
)

# collapse
cases_csts_ms_d <- cases %>%
  dplyr::group_by(member_state, year, case_type) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge into template
cases_csts_ms_d <- dplyr::left_join(template_csts_ms_d, cases_csts_ms_d, by = c("member_state", "year", "case_type"))

# code zeros
cases_csts_ms_d$count_cases[is.na(cases_csts_ms_d$count_cases)] <- 0

# merge in member state data
cases_csts_ms_d <- dplyr::left_join(cases_csts_ms_d, member_states, by = "member_state")

# merge in case type data
cases_csts_ms_d <- dplyr::left_join(cases_csts_ms_d, case_types, by = "case_type")

# arrange
cases_csts_ms_d <- dplyr::arrange(cases_csts_ms_d, year, member_state_id, case_type_id)

# key ID
cases_csts_ms_d$key_id <- 1:nrow(cases_csts_ms_d)

# select variables
cases_csts_ms_d <- dplyr::select(
  cases_csts_ms_d,
  key_id, year, member_state_id, member_state, member_state_code, case_type_id, case_type, count_cases
)

# save
save(cases_csts_ms_d, file = "data/cases_csts_ms_d.RData")

##################################################
# cases_csts_dp
##################################################

# create a template
template_csts_dp <- create_template(
  departments$department,
  2002:2020,
  names = c("department", "year")
)

# collapse
cases_csts_dp <- cases %>%
  dplyr::group_by(department, year) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge
cases_csts_dp <- dplyr::left_join(template_csts_dp, cases_csts_dp, by = c("department", "year"))

# code zeros
cases_csts_dp$count_cases[is.na(cases_csts_dp$count_cases)] <- 0

# merge in departments
cases_csts_dp <- dplyr::left_join(cases_csts_dp, departments, by = "department")

# arrange
cases_csts_dp <- dplyr::arrange(cases_csts_dp, year, department_id)

# key ID
cases_csts_dp$key_id <- 1:nrow(cases_csts_dp)

# select variables
cases_csts_dp <- dplyr::select(
  cases_csts_dp,
  key_id, year,
  department_id, department, department_code, count_cases
)

# save
save(cases_csts_dp, file = "data/cases_csts_dp.RData")

##################################################
# cases_csts_dp_d
##################################################

# template
template_csts_dp_d <- create_template(
  departments$department,
  2002:2020,
  case_types$case_type,
  names = c("department", "year", "case_type")
)

# collapse
cases_csts_dp_d <- cases %>%
  dplyr::group_by(department, year, case_type) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge
cases_csts_dp_d <- dplyr::left_join(template_csts_dp_d, cases_csts_dp_d, by = c("department", "year", "case_type"))

# code zeros
cases_csts_dp_d$count_cases[is.na(cases_csts_dp_d$count_cases)] <- 0

# merge in member state data
cases_csts_dp_d <- dplyr::left_join(cases_csts_dp_d, departments, by = "department")

# merge in case type data
cases_csts_dp_d <- dplyr::left_join(cases_csts_dp_d, case_types, by = "case_type")

# arrange
cases_csts_dp_d <- dplyr::arrange(cases_csts_dp_d, year, department_id, case_type_id)

# key ID
cases_csts_dp_d$key_id <- 1:nrow(cases_csts_dp_d)

# select variables
cases_csts_dp_d <- dplyr::select(
  cases_csts_dp_d,
  key_id, year, department_id, department, department_code, case_type_id, case_type, count_cases
)

# save
save(cases_csts_dp_d, file = "data/cases_csts_dp_d.RData")

################################################################################
# end R script
################################################################################
