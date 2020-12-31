###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# read in data
member_states <- read.csv("data-raw/member-states.csv", stringsAsFactors = FALSE)
directorates_general <- read.csv("data-raw/directorates-general.csv", stringsAsFactors = FALSE)

# select variables
member_states <- dplyr::select(member_states, member_state_ID, member_state, member_state_code)
directorates_general <- dplyr::select(directorates_general, directorate_general_ID, directorate_general, directorate_general_code)

# case types
case_types <- dplyr::tibble(
 case_type_ID = c(1, 2),
 case_type = c("noncommunication", "nonconformity")
)

# decision_stages
decision_stages <- dplyr::tibble(
 decision_stage_ID = c(1, 2, 3, 4, 5, 6),
 decision_stage = c(
  "Letter of formal notice (Art. 258)",
  "Reasoned opinion (Art. 258)",
  "Referral to the Court (Art. 258)",
  "Letter of formal notice (Art. 260)",
  "Reasoned opinion (Art. 260)",
  "Referral to the Court (Art. 260)"
 )
)

# read in data
load("data/cases.RData")
load("data/decisions.RData")

# rename variables
cases <- dplyr::rename(cases, year = case_year)
decisions <- dplyr::rename(decisions, year = decision_year)

###########################################################################
# end R script
###########################################################################
