################################################################################
# Joshua C. Fjelstul, Ph.D.
# euip R package
################################################################################

# read in data
load("data/cases.RData")
load("data/decisions.RData")

# rename variables
cases <- dplyr::rename(cases, year = case_year)
decisions <- dplyr::rename(decisions, year = decision_year)

# select variables
member_states <- dplyr::select(cases, member_state_id, member_state, member_state_code)
departments <- dplyr::select(cases, department_id, department, department_code)

# drop duplicates
member_states <- dplyr::filter(member_states, !duplicated(member_states))
departments <- dplyr::filter(departments, !duplicated(departments))

# case types
case_types <- dplyr::tibble(
  case_type_id = c(1, 2),
  case_type = c("noncommunication", "nonconformity")
)

# decision_stages
decision_stages <- dplyr::tibble(
  decision_stage_id = c(1, 2, 3, 4, 5, 6),
  decision_stage = c(
    "letter of formal notice (258)",
    "reasoned opinion (258)",
    "referral to the court (258)",
    "letter of formal notice (260)",
    "reasoned opinion (260)",
    "referral to the court (260)"
  )
)

################################################################################
# end R script
################################################################################
