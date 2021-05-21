################################################################################
# Joshua C. Fjelstul, Ph.D.
# euip R package
################################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

# source files
source("data-raw/code/utilities/base_data.R")

##################################################
# cases_ts
##################################################

# create a template
template_ts <- expand.grid(
  2002:2020,
  decision_stages$decision_stage,
  stringsAsFactors = FALSE
)
names(template_ts) <- c("year", "decision_stage")

# collapse
decisions_ts <- decisions %>%
  dplyr::group_by(year, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge in template
decisions_ts <- dplyr::left_join(template_ts, decisions_ts, by = c("year", "decision_stage"))

# code zeros
decisions_ts$count_decisions[is.na(decisions_ts$count_decisions)] <- 0

# merge in decision stage data
decisions_ts <- dplyr::left_join(decisions_ts, decision_stages, by = "decision_stage")

# arrange
decisions_ts <- dplyr::arrange(decisions_ts, year, decision_stage_id)

# key ID
decisions_ts$key_id <- 1:nrow(decisions_ts)

# select variables
decisions_ts <- dplyr::select(
  decisions_ts,
  key_id, year, decision_stage_id, decision_stage, count_decisions
)

# save
save(decisions_ts, file = "data/decisions_ts.RData")

##################################################
# cases_ts_d
##################################################

# create a template
template_ts_d <- expand.grid(
  2002:2020,
  case_types$case_type,
  decision_stages$decision_stage,
  stringsAsFactors = FALSE
)
names(template_ts_d) <- c("year", "case_type", "decision_stage")

# collapse
decisions_ts_d <- decisions %>%
  dplyr::group_by(year, case_type, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge in template
decisions_ts_d <- dplyr::left_join(template_ts_d, decisions_ts_d, by = c("year", "case_type", "decision_stage"))

# code zeros
decisions_ts_d$count_decisions[is.na(decisions_ts_d$count_decisions)] <- 0

# merge in case type data
decisions_ts_d <- dplyr::left_join(decisions_ts_d, case_types, by = "case_type")

# merge in decision stage data
decisions_ts_d <- dplyr::left_join(decisions_ts_d, decision_stages, by = "decision_stage")

# arrange
decisions_ts_d <- dplyr::arrange(decisions_ts_d, year, case_type_id, decision_stage_id)

# key ID
decisions_ts_d$key_id <- 1:nrow(decisions_ts_d)

# select variables
decisions_ts_d <- dplyr::select(
  decisions_ts_d,
  key_id, year,
  case_type_id, case_type,
  decision_stage_id, decision_stage,
  count_decisions
)

# save
save(decisions_ts_d, file = "data/decisions_ts_d.RData")

################################################################################
# end R script
################################################################################
