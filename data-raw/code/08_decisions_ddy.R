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
# decisions_ddy
##################################################

# create a template
template_ddy <- create_template(
  departments$department,
  member_states$member_state,
  2002:2020,
  decision_stages$decision_stage,
  names = c("department", "member_state", "year", "decision_stage")
)

# collapse
decisions_ddy <- decisions %>%
  dplyr::group_by(department, member_state, year, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge into template
decisions_ddy <- dplyr::left_join(template_ddy, decisions_ddy, by = c("department", "member_state", "year", "decision_stage"))

# code zeros
decisions_ddy$count_decisions[is.na(decisions_ddy$count_decisions)] <- 0

# merge in member state data
decisions_ddy <- dplyr::left_join(decisions_ddy, member_states, by = "member_state")

# merge in department data
decisions_ddy <- dplyr::left_join(decisions_ddy, departments, by = "department")

# merge in decision stage data
decisions_ddy <- dplyr::left_join(decisions_ddy, decision_stages, by = "decision_stage")

# arrange
decisions_ddy <- dplyr::arrange(decisions_ddy, year, department_id, member_state_id, decision_stage_id)

# key ID
decisions_ddy$key_id <- 1:nrow(decisions_ddy)

# select variables
decisions_ddy <- dplyr::select(
  decisions_ddy,
  key_id, year,
  department_id, department, department_code,
  member_state_id, member_state, member_state_code,
  decision_stage_id, decision_stage,
  count_decisions
)

# save
save(decisions_ddy, file = "data/decisions_ddy.RData")

##################################################
# cases_ddy_ct
##################################################

# create a template
template_ddy_ct <- create_template(
  departments$department,
  member_states$member_state,
  2002:2020,
  case_types$case_type,
  decision_stages$decision_stage,
  names = c("department", "member_state", "year", "case_type", "decision_stage")
)

# collapse
decisions_ddy_ct <- decisions %>%
  dplyr::group_by(department, member_state, year, case_type, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge
decisions_ddy_ct <- dplyr::left_join(template_ddy_ct, decisions_ddy_ct, by = c("department", "member_state", "year", "case_type", "decision_stage"))

# code zeros
decisions_ddy_ct$count_decisions[is.na(decisions_ddy_ct$count_decisions)] <- 0

# merge in member state data
decisions_ddy_ct <- dplyr::left_join(decisions_ddy_ct, member_states, by = "member_state")

# merge in department data
decisions_ddy_ct <- dplyr::left_join(decisions_ddy_ct, departments, by = "department")

# merge in case types data
decisions_ddy_ct <- dplyr::left_join(decisions_ddy_ct, case_types, by = "case_type")

# merge in decision stages data
decisions_ddy_ct <- dplyr::left_join(decisions_ddy_ct, decision_stages, by = "decision_stage")

# arrange
decisions_ddy_ct <- dplyr::arrange(decisions_ddy_ct, year, department_id, member_state_id, case_type_id, decision_stage_id)

# key ID
decisions_ddy_ct$key_id <- 1:nrow(decisions_ddy_ct)

# select variables
decisions_ddy_ct <- dplyr::select(
  decisions_ddy_ct,
  key_id, year,
  department_id, department, department_code,
  member_state_id, member_state, member_state_code,
  case_type_id, case_type,
  decision_stage_id, decision_stage,
  count_decisions
)

# save
save(decisions_ddy_ct, file = "data/decisions_ddy_ct.RData")

################################################################################
# end R script
################################################################################
