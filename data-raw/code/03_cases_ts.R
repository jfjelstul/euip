################################################################################
# Joshua C. Fjelstul, Ph.D.
# euip R package
################################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

# source files
source("data-raw/code/utilities/base_data.R")

##################################################
# cases_TS
##################################################

# create a template
template_ts <- dplyr::tibble(year = 2002:2020)

# collapse
cases_ts <- cases %>%
  dplyr::group_by(year) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge into template
cases_ts <- dplyr::left_join(template_ts, cases_ts, by = "year")

# code zeros
cases_ts$count_cases[is.na(cases_ts$count_cases)] <- 0

# key ID
cases_ts$key_id <- 1:nrow(cases_ts)

# select variables
cases_ts <- dplyr::select(
  cases_ts,
  key_id, year, count_cases
)

# save
save(cases_ts, file = "data/cases_ts.RData")

##################################################
# cases_TS_D
##################################################

# create a template
template_ts_ct <- expand.grid(year = 2002:2020, case_type = case_types$case_type)
names(template_ts_ct) <- c("year", "case_type")
template_ts_ct <- dplyr::as_tibble(template_ts_ct)

# collapse
cases_ts_ct <- cases %>%
  dplyr::group_by(year, case_type) %>%
  dplyr::summarize(
    count_cases = dplyr::n()
  ) %>%
  dplyr::ungroup()

# merge into template
cases_ts_ct <- dplyr::left_join(template_ts_ct, cases_ts_ct, by = c("year", "case_type"))

# code zeros
cases_ts_ct$count_cases[is.na(cases_ts_ct$count_cases)] <- 0

# merge in case type data
cases_ts_ct <- dplyr::left_join(cases_ts_ct, case_types, by = "case_type")

# arrange
cases_ts_ct <- dplyr::arrange(cases_ts_ct, year, case_type_id)

# key ID
cases_ts_ct$key_id <- 1:nrow(cases_ts_ct)

# select variables
cases_ts_ct <- dplyr::select(
  cases_ts_ct,
  key_id, year, case_type_id, case_type, count_cases
)

# save
save(cases_ts_ct, file = "data/cases_ts_ct.RData")

################################################################################
# end R script
################################################################################
