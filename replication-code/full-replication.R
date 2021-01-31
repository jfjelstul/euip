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

# cases TS data
source("replication-code/3-cases-TS-data.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_TS.RData"
# output: "data/cases_TS_D.RData"

# decisions TS data
source("replication-code/4-decisions-TS-data.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_TS.RData"
# output: "data/decisions_TS_D.RData"

# cases CSTS data
source("replication-code/5-cases-CSTS-data.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_CSTS_MS.RData"
# output: "data/cases_CSTS_MS_D.RData"
# output: "data/cases_CSTS_DG.RData"
# output: "data/cases_CSTS_DG_D.RData"

# decisions CSTS data
source("replication-code/6-decisions-CSTS-data.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_CSTS_MS.RData"
# output: "data/decisions_CSTS_MS_D.RData"
# output: "data/decisions_CSTS_DG.RData"
# output: "data/decisions_CSTS_DG_D.RData"

# cases DDY data
source("replication-code/7-cases-DDY-data.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_DDY.RData"
# output: "data/cases_DDY_D.RData"

# decisions DDY data
source("replication-code/8-decisions-DDY-data.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_DDY.RData"
# output: "data/decisions_DDY_D.RData"

# network data
source("replication-code/9-network-data.R")
rm(list = ls())
# input: "data/cases_DDY.RData"
# input: "data/cases_DDY_D.RData"
# input: "data/decisions_DDY.RData"
# input: "data/decisions_DDY_D.RData"
# output: "data/cases_network.RData"
# output: "data/cases_network_D.RData"
# output: "data/decisions_network.RData"
# output: "data/decisions_network_D.RData"

##################################################
# load data
##################################################

# cases
load("data/cases.RData")
load("data/cases_TS.RData")
load("data/cases_TS_D.RData")
load("data/cases_CSTS_MS.RData")
load("data/cases_CSTS_MS_D.RData")
load("data/cases_CSTS_DG.RData")
load("data/cases_CSTS_DG_D.RData")
load("data/cases_DDY.RData")
load("data/cases_DDY_D.RData")
load("data/cases_network.RData")
load("data/cases_network_D.RData")

# decisions
load("data/decisions.RData")
load("data/decisions_TS.RData")
load("data/decisions_TS_D.RData")
load("data/decisions_CSTS_MS.RData")
load("data/decisions_CSTS_MS_D.RData")
load("data/decisions_CSTS_DG.RData")
load("data/decisions_CSTS_DG_D.RData")
load("data/decisions_DDY.RData")
load("data/decisions_DDY_D.RData")
load("data/decisions_network.RData")
load("data/decisions_network_D.RData")

##################################################
# write data
##################################################

# cases
write.csv(cases, "build/EUIP-cases.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_TS, "build/EUIP-cases-TS.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_TS_D, "build/EUIP-cases-TS-D.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_CSTS_MS, "build/EUIP-cases-CSTS-MS.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_CSTS_MS_D, "build/EUIP-cases-CSTS-MS-D.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_CSTS_DG, "build/EUIP-cases-CSTS-DG.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_CSTS_DG_D, "build/EUIP-cases-CSTS-DG-D.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_DDY, "build/EUIP-cases-DDY.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_DDY_D, "build/EUIP-cases-DDY-D.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_network, "build/EUIP-cases-network.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_network_D, "build/EUIP-cases-network-D.csv", row.names = FALSE, quote = TRUE)

# decisions
write.csv(decisions, "build/EUIP-decisions.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_TS, "build/EUIP-decisions-TS.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_TS_D, "build/EUIP-decisions-TS-D.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_CSTS_MS, "build/EUIP-decisions-CSTS-MS.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_CSTS_MS_D, "build/EUIP-decisions-CSTS-MS-D.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_CSTS_DG, "build/EUIP-decisions-CSTS-DG.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_CSTS_DG_D, "build/EUIP-decisions-CSTS-DG-D.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_DDY, "build/EUIP-decisions-DDY.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_DDY_D, "build/EUIP-decisions-DDY-D.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_network, "build/EUIP-decisions-network.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_network_D, "build/EUIP-decisions-network-D.csv", row.names = FALSE, quote = TRUE)

##################################################
# write database data
##################################################

# cases
write.csv(cases, "build-database/EUIP-cases.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_TS, "build-database/EUIP-cases-TS.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_TS_D, "build-database/EUIP-cases-TS-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_CSTS_MS, "build-database/EUIP-cases-CSTS-MS.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_CSTS_MS_D, "build-database/EUIP-cases-CSTS-MS-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_CSTS_DG, "build-database/EUIP-cases-CSTS-DG.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_CSTS_DG_D, "build-database/EUIP-cases-CSTS-DG-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_DDY, "build-database/EUIP-cases-DDY.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_DDY_D, "build-database/EUIP-cases-DDY-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_network, "build-database/EUIP-cases-network.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_network_D, "build-database/EUIP-cases-network-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")

# decisions
write.csv(decisions, "build-database/EUIP-decisions.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_TS, "build-database/EUIP-decisions-TS.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_TS_D, "build-database/EUIP-decisions-TS-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_CSTS_MS, "build-database/EUIP-decisions-CSTS-MS.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_CSTS_MS_D, "build-database/EUIP-decisions-CSTS-MS-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_CSTS_DG, "build-database/EUIP-decisions-CSTS-DG.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_CSTS_DG_D, "build-database/EUIP-decisions-CSTS-DG-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_DDY, "build-database/EUIP-decisions-DDY.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_DDY_D, "build-database/EUIP-decisions-DDY-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_network, "build-database/EUIP-decisions-network.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_network_D, "build-database/EUIP-decisions-network-D.csv", row.names = FALSE, quote = TRUE, na = "\\N")

###########################################################################
# end R script
###########################################################################
