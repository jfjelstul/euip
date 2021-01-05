###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

# source files
source("replication-code/utilities/create_template.R")
source("replication-code/utilities/base_data.R")

##################################################
# decisions_CSTS_MS
##################################################

# create a template
template_CSTS_MS <- create_template(
  member_states$member_state, 
  2002:2020,
  decision_stages$decision_stage,
  names = c("member_state", "year", "decision_stage")
)

# collapse
decisions_CSTS_MS <- decisions %>%
  dplyr::group_by(member_state, year, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
decisions_CSTS_MS <- dplyr::left_join(template_CSTS_MS, decisions_CSTS_MS, by = c("member_state", "year", "decision_stage"))

# code zeros
decisions_CSTS_MS$count_decisions[is.na(decisions_CSTS_MS$count_decisions)] <- 0

# merge in member state data
decisions_CSTS_MS <- dplyr::left_join(decisions_CSTS_MS, member_states, by = "member_state")

# merge in decision stage data
decisions_CSTS_MS <- dplyr::left_join(decisions_CSTS_MS, decision_stages, by = "decision_stage")

# arrange
decisions_CSTS_MS <- dplyr::arrange(decisions_CSTS_MS, year, member_state_ID, decision_stage_ID)

# key ID
decisions_CSTS_MS$key_ID <- 1:nrow(decisions_CSTS_MS)

# select decisions_CSTS_MS_tidy
decisions_CSTS_MS <- dplyr::select(
  decisions_CSTS_MS,
  key_ID, year, 
  member_state_ID, member_state, member_state_code, 
  decision_stage_ID, decision_stage, 
  count_decisions
)

# save
save(decisions_CSTS_MS, file = "data/decisions_CSTS_MS.RData")

##################################################
# decisions_CSTS_MS_D
##################################################

# create a template
template_CSTS_MS_D <- create_template(
  member_states$member_state, 
  2002:2020,
  case_types$case_type,
  decision_stages$decision_stage,
  names = c("member_state", "year", "case_type", "decision_stage")
)

# collapse
decisions_CSTS_MS_D <- decisions %>%
  dplyr::group_by(member_state, year, case_type, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
decisions_CSTS_MS_D <- dplyr::left_join(template_CSTS_MS_D, decisions_CSTS_MS_D, by = c("member_state", "year", "case_type", "decision_stage"))

# code zeros
decisions_CSTS_MS_D$count_decisions[is.na(decisions_CSTS_MS_D$count_decisions)] <- 0

# merge in member state data
decisions_CSTS_MS_D <- dplyr::left_join(decisions_CSTS_MS_D, member_states, by = "member_state")

# merge in case type data
decisions_CSTS_MS_D <- dplyr::left_join(decisions_CSTS_MS_D, case_types, by = "case_type")

# merge in decision stage data
decisions_CSTS_MS_D <- dplyr::left_join(decisions_CSTS_MS_D, decision_stages, by = "decision_stage")

# arrange
decisions_CSTS_MS_D <- dplyr::arrange(decisions_CSTS_MS_D, year, member_state_ID, case_type_ID, decision_stage_ID)

# key ID
decisions_CSTS_MS_D$key_ID <- 1:nrow(decisions_CSTS_MS_D)

# select variables
decisions_CSTS_MS_D <- dplyr::select(
  decisions_CSTS_MS_D,
  key_ID, year, 
  member_state_ID, member_state, member_state_code, 
  case_type_ID, case_type,
  decision_stage_ID, decision_stage,
  count_decisions
)

# save
save(decisions_CSTS_MS_D, file = "data/decisions_CSTS_MS_D.RData")

##################################################
# decisions_CSTS_DG
##################################################

# create a template
template_CSTS_DG <- create_template(
  directorates_general$directorate_general, 
  2002:2020,
  decision_stages$decision_stage,
  names = c("directorate_general", "year", "decision_stage")
)

# collapse
decisions_CSTS_DG <- decisions %>%
  dplyr::group_by(directorate_general, year, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
decisions_CSTS_DG <- dplyr::left_join(template_CSTS_DG, decisions_CSTS_DG, by = c("directorate_general", "year", "decision_stage"))

# code zeros
decisions_CSTS_DG$count_decisions[is.na(decisions_CSTS_DG$count_decisions)] <- 0

# merge in DG data
decisions_CSTS_DG <- dplyr::left_join(decisions_CSTS_DG, directorates_general, by = "directorate_general")

# merge in decision stage data
decisions_CSTS_DG <- dplyr::left_join(decisions_CSTS_DG, decision_stages, by = "decision_stage")

# arrange
decisions_CSTS_DG <- dplyr::arrange(decisions_CSTS_DG, year, directorate_general_ID, decision_stage_ID)

# key ID
decisions_CSTS_DG$key_ID <- 1:nrow(decisions_CSTS_DG)

# select variables
decisions_CSTS_DG <- dplyr::select(
  decisions_CSTS_DG,
  key_ID, year, 
  directorate_general_ID, directorate_general, directorate_general_code,
  decision_stage_ID, decision_stage,
  count_decisions
)

# save
save(decisions_CSTS_DG, file = "data/decisions_CSTS_DG.RData")

##################################################
# decisions_CSTS_DG_D
##################################################

# create a template
template_CSTS_DG_D <- create_template(
  directorates_general$directorate_general, 
  2002:2020,
  case_types$case_type,
  decision_stages$decision_stage,
  names = c("directorate_general", "year", "case_type", "decision_stage")
)

# collapse
decisions_CSTS_DG_D <- decisions %>%
  dplyr::group_by(directorate_general, year, case_type, decision_stage) %>%
  dplyr::summarize(
    count_decisions = dplyr::n()
  ) %>% dplyr::ungroup()

# merge into template
decisions_CSTS_DG_D <- dplyr::left_join(template_CSTS_DG_D, decisions_CSTS_DG_D, by = c("directorate_general", "year", "case_type", "decision_stage"))

# code zeros
decisions_CSTS_DG_D$count_decisions[is.na(decisions_CSTS_DG_D$count_decisions)] <- 0

# merge in DG data
decisions_CSTS_DG_D <- dplyr::left_join(decisions_CSTS_DG_D, directorates_general, by = "directorate_general")

# merge in case type data
decisions_CSTS_DG_D <- dplyr::left_join(decisions_CSTS_DG_D, case_types, by = "case_type")

# merge in decision stage data
decisions_CSTS_DG_D <- dplyr::left_join(decisions_CSTS_DG_D, decision_stages, by = "decision_stage")

# arrange
decisions_CSTS_DG_D <- dplyr::arrange(decisions_CSTS_DG_D, year, directorate_general_ID, case_type_ID, decision_stage_ID)

# key ID
decisions_CSTS_DG_D$key_ID <- 1:nrow(decisions_CSTS_DG_D)

# select variables
decisions_CSTS_DG_D <- dplyr::select(
  decisions_CSTS_DG_D,
  key_ID, year, 
  directorate_general_ID, directorate_general, directorate_general_code, 
  case_type_ID, case_type,
  decision_stage_ID, decision_stage,
  count_decisions
)

# save
save(decisions_CSTS_DG_D, file = "data/decisions_CSTS_DG_D.RData")

##################################################
# wide decisions_CSTS_MS_wide
##################################################

# # convert to wide
# decisions_CSTS_MS_wide <- tidyr::pivot_wider(
#   decisions_CSTS_MS,
#   id_cols = c(year, member_state_ID, member_state, member_state_code),
#   names_from = decision_stage_ID,
#   values_from = count_decisions
# )
# 
# # rename variables
# names(decisions_CSTS_MS_wide) <- c(
#   "year", 
#   "member_state_ID", "member_state", "member_state_code",
#   "count_LFN258", "count_RO258", "count_RF258",
#   "count_LFN260", "count_RO260", "count_RF260"
# )
# 
# # arrange
# decisions_CSTS_MS_wide <- dplyr::arrange(decisions_CSTS_MS_wide, year, member_state_ID)
# 
# # key ID
# decisions_CSTS_MS_wide$key_ID <- 1:nrow(decisions_CSTS_MS_wide)
# 
# # select variables
# decisions_CSTS_MS_wide <- dplyr::select(
#   decisions_CSTS_MS_wide, 
#   key_ID, year,
#   member_state_ID, member_state, member_state_code,
#   count_LFN258, count_RO258, count_RF258,
#   count_LFN260, count_RO260, count_RF260
# )
# 
# # save
# save(decisions_CSTS_MS_wide, file = "data/decisions_CSTS_MS_wide.RData")

##################################################
# wide decisions_CSTS_MS_D_wide
##################################################

# # convert to wide
# decisions_CSTS_MS_D_wide <- tidyr::pivot_wider(
#   decisions_CSTS_MS_D,
#   id_cols = c(year, member_state_ID, member_state, member_state_code, case_type_ID, case_type),
#   names_from = decision_stage_ID,
#   values_from = count_decisions
# )
# 
# # rename variables
# names(decisions_CSTS_MS_D_wide) <- c(
#   "year", 
#   "member_state_ID", "member_state", "member_state_code",
#   "case_type_ID", "case_type",
#   "count_LFN258", "count_RO258", "count_RF258",
#   "count_LFN260", "count_RO260", "count_RF260"
# )
# 
# # arrange
# decisions_CSTS_MS_D_wide <- dplyr::arrange(decisions_CSTS_MS_D_wide, year, member_state_ID, case_type_ID)
# 
# # key ID
# decisions_CSTS_MS_D_wide$key_ID <- 1:nrow(decisions_CSTS_MS_D_wide)
# 
# # select variables
# decisions_CSTS_MS_D_wide <- dplyr::select(
#   decisions_CSTS_MS_D_wide, 
#   key_ID, year,
#   member_state_ID, member_state, member_state_code,
#   case_type_ID, case_type,
#   count_LFN258, count_RO258, count_RF258,
#   count_LFN260, count_RO260, count_RF260
# )
# 
# # save
# save(decisions_CSTS_MS_D_wide, file = "data/decisions_CSTS_MS_D_wide.RData")

##################################################
# decisions_CSTS_DG_wide
##################################################

# # convert to wide
# decisions_CSTS_DG_wide <- tidyr::pivot_wider(
#   decisions_CSTS_DG,
#   id_cols = c(year, directorate_general_ID, directorate_general, directorate_general_code),
#   names_from = decision_stage_ID,
#   values_from = count_decisions
# )
# 
# # rename variables
# names(decisions_CSTS_DG_wide) <- c(
#   "year", 
#   "directorate_general_ID", "directorate_general", "directorate_general_code",
#   "count_LFN258", "count_RO258", "count_RF258",
#   "count_LFN260", "count_RO260", "count_RF260"
# )
# 
# # arrange
# decisions_CSTS_DG_wide <- dplyr::arrange(decisions_CSTS_DG_wide, year, directorate_general_ID)
# 
# # key ID
# decisions_CSTS_DG_wide$key_ID <- 1:nrow(decisions_CSTS_DG_wide)
# 
# # select variables
# decisions_CSTS_DG_wide <- dplyr::select(
#   decisions_CSTS_DG_wide, 
#   key_ID, year,
#   directorate_general_ID, directorate_general, directorate_general_code,
#   count_LFN258, count_RO258, count_RF258,
#   count_LFN260, count_RO260, count_RF260
# )
# 
# # save
# save(decisions_CSTS_DG_wide, file = "data/decisions_CSTS_DG_wide.RData")

##################################################
# decisions_CSTS_DG_D_wide
##################################################

# # convert to wide
# decisions_CSTS_DG_D_wide <- tidyr::pivot_wider(
#   decisions_CSTS_DG_D,
#   id_cols = c(year, directorate_general_ID, directorate_general, directorate_general_code, case_type_ID, case_type),
#   names_from = decision_stage_ID,
#   values_from = count_decisions
# )
# 
# # rename variables
# names(decisions_CSTS_DG_D_wide) <- c(
#   "year", 
#   "directorate_general_ID", "directorate_general", "directorate_general_code",
#   "case_type_ID", "case_type",
#   "count_LFN258", "count_RO258", "count_RF258",
#   "count_LFN260", "count_RO260", "count_RF260"
# )
# 
# # arrange
# decisions_CSTS_DG_D_wide <- dplyr::arrange(decisions_CSTS_DG_D_wide, year, directorate_general_ID, case_type_ID)
# 
# # key ID
# decisions_CSTS_DG_D_wide$key_ID <- 1:nrow(decisions_CSTS_DG_D_wide)
# 
# # select variables
# decisions_CSTS_DG_D_wide <- dplyr::select(
#   decisions_CSTS_DG_D_wide, 
#   key_ID, year,
#   directorate_general_ID, directorate_general, directorate_general_code,
#   case_type_ID, case_type,
#   count_LFN258, count_RO258, count_RF258,
#   count_LFN260, count_RO260, count_RF260
# )
# 
# # save
# save(decisions_CSTS_DG_D_wide, file = "data/decisions_CSTS_DG_D_wide.RData")

###########################################################################
# end R script
###########################################################################
