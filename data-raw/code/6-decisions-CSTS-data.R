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
# decisions_csts_ms
##################################################

# create a template
template_csts_ms <- create_template(
  member_states$member_state, 
  2002:2020,
  decision_stages$decision_stage,
  names = c("member_state", "year", "decision_stage")
)

# collapse
decisions_csts_ms <- decisions %>%
  dplyr::group_by(member_state, year, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
decisions_csts_ms <- dplyr::left_join(template_csts_ms, decisions_csts_ms, by = c("member_state", "year", "decision_stage"))

# code zeros
decisions_csts_ms$count_decisions[is.na(decisions_csts_ms$count_decisions)] <- 0

# merge in member state data
decisions_csts_ms <- dplyr::left_join(decisions_csts_ms, member_states, by = "member_state")

# merge in decision stage data
decisions_csts_ms <- dplyr::left_join(decisions_csts_ms, decision_stages, by = "decision_stage")

# arrange
decisions_csts_ms <- dplyr::arrange(decisions_csts_ms, year, member_state_id, decision_stage_id)

# key ID
decisions_csts_ms$key_id <- 1:nrow(decisions_csts_ms)

# select decisions
decisions_csts_ms <- dplyr::select(
  decisions_csts_ms,
  key_id, year, 
  member_state_id, member_state, member_state_code, 
  decision_stage_id, decision_stage, count_decisions
)

# save
save(decisions_csts_ms, file = "data/decisions_csts_ms.RData")

##################################################
# decisions_csts_ms_d
##################################################

# create a template
template_csts_ms_d <- create_template(
  member_states$member_state, 
  2002:2020,
  case_types$case_type,
  decision_stages$decision_stage,
  names = c("member_state", "year", "case_type", "decision_stage")
)

# collapse
decisions_csts_ms_d <- decisions %>%
  dplyr::group_by(member_state, year, case_type, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
decisions_csts_ms_d <- dplyr::left_join(template_csts_ms_d, decisions_csts_ms_d, by = c("member_state", "year", "case_type", "decision_stage"))

# code zeros
decisions_csts_ms_d$count_decisions[is.na(decisions_csts_ms_d$count_decisions)] <- 0

# merge in member state data
decisions_csts_ms_d <- dplyr::left_join(decisions_csts_ms_d, member_states, by = "member_state")

# merge in case type data
decisions_csts_ms_d <- dplyr::left_join(decisions_csts_ms_d, case_types, by = "case_type")

# merge in decision stage data
decisions_csts_ms_d <- dplyr::left_join(decisions_csts_ms_d, decision_stages, by = "decision_stage")

# arrange
decisions_csts_ms_d <- dplyr::arrange(decisions_csts_ms_d, year, member_state_id, case_type_id, decision_stage_id)

# key ID
decisions_csts_ms_d$key_id <- 1:nrow(decisions_csts_ms_d)

# select variables
decisions_csts_ms_d <- dplyr::select(
  decisions_csts_ms_d,
  key_id, year, 
  member_state_id, member_state, member_state_code, 
  case_type_id, case_type,
  decision_stage_id, decision_stage, count_decisions
)

# save
save(decisions_csts_ms_d, file = "data/decisions_csts_ms_d.RData")

##################################################
# decisions_csts_dp
##################################################

# create a template
template_csts_dp <- create_template(
  departments$department, 
  2002:2020,
  decision_stages$decision_stage,
  names = c("department", "year", "decision_stage")
)

# collapse
decisions_csts_dp <- decisions %>%
  dplyr::group_by(department, year, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
decisions_csts_dp <- dplyr::left_join(template_csts_dp, decisions_csts_dp, by = c("department", "year", "decision_stage"))

# code zeros
decisions_csts_dp$count_decisions[is.na(decisions_csts_dp$count_decisions)] <- 0

# merge in department data
decisions_csts_dp <- dplyr::left_join(decisions_csts_dp, departments, by = "department")

# merge in decision stage data
decisions_csts_dp <- dplyr::left_join(decisions_csts_dp, decision_stages, by = "decision_stage")

# arrange
decisions_csts_dp <- dplyr::arrange(decisions_csts_dp, year, department_id, decision_stage_id)

# key ID
decisions_csts_dp$key_id <- 1:nrow(decisions_csts_dp)

# select variables
decisions_csts_dp <- dplyr::select(
  decisions_csts_dp,
  key_id, year, 
  department_id, department, department_code,
  decision_stage_id, decision_stage,
  count_decisions
)

# save
save(decisions_csts_dp, file = "data/decisions_csts_dp.RData")

##################################################
# decisions_csts_dp_d
##################################################

# create a template
template_csts_dp_d <- create_template(
  departments$department, 
  2002:2020,
  case_types$case_type,
  decision_stages$decision_stage,
  names = c("department", "year", "case_type", "decision_stage")
)

# collapse
decisions_csts_dp_d <- decisions %>%
  dplyr::group_by(department, year, case_type, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
decisions_csts_dp_d <- dplyr::left_join(template_csts_dp_d, decisions_csts_dp_d, by = c("department", "year", "case_type", "decision_stage"))

# code zeros
decisions_csts_dp_d$count_decisions[is.na(decisions_csts_dp_d$count_decisions)] <- 0

# merge in DG data
decisions_csts_dp_d <- dplyr::left_join(decisions_csts_dp_d, departments, by = "department")

# merge in case type data
decisions_csts_dp_d <- dplyr::left_join(decisions_csts_dp_d, case_types, by = "case_type")

# merge in decision stage data
decisions_csts_dp_d <- dplyr::left_join(decisions_csts_dp_d, decision_stages, by = "decision_stage")

# arrange
decisions_csts_dp_d <- dplyr::arrange(decisions_csts_dp_d, year, department_id, case_type_id, decision_stage_id)

# key ID
decisions_csts_dp_d$key_id <- 1:nrow(decisions_csts_dp_d)

# select variables
decisions_csts_dp_d <- dplyr::select(
  decisions_csts_dp_d,
  key_id, year, 
  department_id, department, department_code, 
  case_type_id, case_type,
  decision_stage_id, decision_stage, count_decisions
)

# save
save(decisions_csts_dp_d, file = "data/decisions_csts_dp_d.RData")

################################################################################
# end R script
################################################################################
