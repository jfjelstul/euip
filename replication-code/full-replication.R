###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# clean workspace
rm(list = ls())

##################################################
# run replication scripts
##################################################

# decisions
source("replication-code/1-decisions.R")
rm(list = ls())
# input: "data-raw/infringements-raw.csv"
# input: "data-raw/member_states.csv"
# input: "data-raw/directorates_general.csv"
# output: "data/decisions.RData"

# cases
source("replication-code/2-cases.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/cases.RData"

# duration 
source("replication-code/3-duration.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/duration.RData"

# cases time series
source("replication-code/4-cases-time-series.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_TS_MS.RData"
# output: "data/cases_TS_MS_D.RData"
# output: "data/cases_TS_DG.RData"
# output: "data/cases_TS_DG_D.RData"

# cases directed-dyad
source("replication-code/5-cases-directed-dyad.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_DDY.RData"
# output: "data/cases_DDY_D.RData"

# decisions directed-dyad
source("replication-code/6-decisions-time-series.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_TS_MS.RData"
# output: "data/decisions_TS_MS_D.RData"
# output: "data/decisions_TS_DG.RData"
# output: "data/decisions_TS_DG_D.RData"

# decisions directed-dyad
source("replication-code/7-decisions-directed-dyad.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_DDY.RData"
# output: "data/decisions_DDY_D.RData"

# network data
source("replication-code/8-network-data.R")
rm(list = ls())
# input: "data/cases_DDY.RData"
# input: "data/cases_DDY_D.RData"
# input: "data/decisions_DDY.RData"
# input: "data/decisions_DDY_D.RData"
# output: "data/cases_NET.RData"
# output: "data/cases_NET_D.RData"
# output: "data/decisions_NET.RData"
# output: "data/decisions_NET_D.RData"

##################################################
# load data
##################################################

# cases
load("data/cases.RData")
load("data/cases_TS_MS.RData")
load("data/cases_TS_MS_D.RData")
load("data/cases_TS_DG.RData")
load("data/cases_TS_DG_D.RData")
load("data/cases_DDY.RData")
load("data/cases_DDY_D.RData")
load("data/cases_NET.RData")
load("data/cases_NET_D.RData")

# decisions
load("data/decisions.RData")
load("data/decisions_TS_MS.RData")
load("data/decisions_TS_MS_D.RData")
load("data/decisions_TS_DG.RData")
load("data/decisions_TS_DG_D.RData")
load("data/decisions_DDY.RData")
load("data/decisions_DDY_D.RData")
load("data/decisions_NET.RData")
load("data/decisions_NET_D.RData")

# wide
load("data/decisions_TS_MS_wide.RData")
load("data/decisions_TS_MS_D_wide.RData")
load("data/decisions_TS_DG_wide.RData")
load("data/decisions_TS_DG_D_wide.RData")
load("data/decisions_DDY_wide.RData")
load("data/decisions_DDY_D_wide.RData")

##################################################
# write data
##################################################

# cases
write.csv(cases, "build/cases.csv", row.names = FALSE)
write.csv(cases_TS_MS, "build/cases_TS_MS.csv", row.names = FALSE)
write.csv(cases_TS_MS_D, "build/cases_TS_MS_D.csv", row.names = FALSE)
write.csv(cases_TS_DG, "build/cases_TS_DG.csv", row.names = FALSE)
write.csv(cases_TS_DG_D, "build/cases_TS_DG_D.csv", row.names = FALSE)
write.csv(cases_DDY, "build/cases_DDY.csv", row.names = FALSE)
write.csv(cases_DDY_D, "build/cases_DDY_D.csv", row.names = FALSE)
write.csv(cases_NET, "build/cases_NET.csv", row.names = FALSE)
write.csv(cases_NET_D, "build/cases_NET_D.csv", row.names = FALSE)

# decisions
write.csv(decisions, "build/decisions.csv", row.names = FALSE)
write.csv(decisions_TS_MS, "build/decisions_TS_MS.csv", row.names = FALSE)
write.csv(decisions_TS_MS_D, "build/decisions_TS_MS_D.csv", row.names = FALSE)
write.csv(decisions_TS_DG, "build/decisions_TS_DG.csv", row.names = FALSE)
write.csv(decisions_TS_DG_D, "build/decisions_TS_DG_D.csv", row.names = FALSE)
write.csv(decisions_DDY, "build/decisions_DDY.csv", row.names = FALSE)
write.csv(decisions_DDY_D, "build/decisions_DDY_D.csv", row.names = FALSE)
write.csv(decisions_NET, "build/decisions_NET.csv", row.names = FALSE)
write.csv(decisions_NET_D, "build/decisions_NET_D.csv", row.names = FALSE)

# wide
write.csv(decisions_TS_MS_wide, "build/decisions_TS_MS_wide.csv", row.names = FALSE)
write.csv(decisions_TS_MS_D_wide, "build/decisions_TS_MS_D_wide.csv", row.names = FALSE)
write.csv(decisions_TS_DG_wide, "build/decisions_TS_DG_wide.csv", row.names = FALSE)
write.csv(decisions_TS_DG_D_wide, "build/decisions_TS_DG_D_wide.csv", row.names = FALSE)
write.csv(decisions_DDY_wide, "build/decisions_DDY_wide.csv", row.names = FALSE)
write.csv(decisions_DDY_D_wide, "build/decisions_DDY_D_wide.csv", row.names = FALSE)

###########################################################################
# end R script
###########################################################################
