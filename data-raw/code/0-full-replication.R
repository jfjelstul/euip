################################################################################
# Joshua C. Fjelstul, Ph.D.
# euip R package
################################################################################

# clean workspace
rm(list = ls())

##################################################
# run replication scripts
##################################################

# decisions
source("data-raw/code/1-decisions.R")
rm(list = ls())
# input: "data-raw/infringements-raw.csv"
# input: "data-raw/member_states.RData"
# input: "data-raw/departments.RData"
# output: "data/decisions.RData"

# cases
source("data-raw/code/2-cases.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/cases.RData"

# cases TS data
source("data-raw/code/3-cases-TS-data.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_ts.RData"
# output: "data/cases_ts_d.RData"

# decisions TS data
source("data-raw/code/4-decisions-TS-data.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_ts.RData"
# output: "data/decisions_ts_d.RData"

# cases CSTS data
source("data-raw/code/5-cases-CSTS-data.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_csts_ms.RData"
# output: "data/cases_csts_ms_d.RData"
# output: "data/cases_csts_dp.RData"
# output: "data/cases_csts_dp_d.RData"

# decisions CSTS data
source("data-raw/code/6-decisions-CSTS-data.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_csts_ms.RData"
# output: "data/decisions_csts_ms_d.RData"
# output: "data/decisions_csts_dp.RData"
# output: "data/decisions_csts_dp_d.RData"

# cases DDY data
source("data-raw/code/7-cases-DDY-data.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_ddy.RData"
# output: "data/cases_ddy_d.RData"

# decisions DDY data
source("data-raw/code/8-decisions-DDY-data.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_ddy.RData"
# output: "data/decisions_ddy_d.RData"

# network data
source("data-raw/code/9-network-data.R")
rm(list = ls())
# input: "data/cases_ddy.RData"
# input: "data/cases_ddy_d.RData"
# input: "data/decisions_ddy.RData"
# input: "data/decisions_ddy_d.RData"
# output: "data/cases_net.RData"
# output: "data/cases_net_d.RData"
# output: "data/decisions_net.RData"
# output: "data/decisions_net_d.RData"

##################################################
# codebook
##################################################

# read in data
codebook <- read.csv("data-raw/codebook/codebook.csv", stringsAsFactors = FALSE)

# convert to a tibble
codebook <- dplyr::as_tibble(codebook)

# save
save(codebook, file = "data/codebook.RData")

# documentation
codebookr::document_data(
  path = "R/",
  codebook_file = "data-raw/codebook/codebook.csv",
  markdown_file = "data-raw/codebook/descriptions.txt",
  author = "Joshua C. Fjelstul, Ph.D.",
  package = "euip"
)

##################################################
# load data
##################################################

# cases
load("data/cases.RData")
load("data/cases_ts.RData")
load("data/cases_ts_d.RData")
load("data/cases_csts_ms.RData")
load("data/cases_csts_ms_d.RData")
load("data/cases_csts_dp.RData")
load("data/cases_csts_dp_d.RData")
load("data/cases_ddy.RData")
load("data/cases_ddy_d.RData")
load("data/cases_net.RData")
load("data/cases_net_d.RData")

# decisions
load("data/decisions.RData")
load("data/decisions_ts.RData")
load("data/decisions_ts_d.RData")
load("data/decisions_csts_ms.RData")
load("data/decisions_csts_ms_d.RData")
load("data/decisions_csts_dp.RData")
load("data/decisions_csts_dp_d.RData")
load("data/decisions_ddy.RData")
load("data/decisions_ddy_d.RData")
load("data/decisions_net.RData")
load("data/decisions_net_d.RData")

# codebook
load("data/codebook.RData")

##################################################
# build
##################################################

# cases
write.csv(cases, "build/euip_cases.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_ts, "build/euip_cases_ts.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_ts_d, "build/euip_cases_ts_d.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_csts_ms, "build/euip_cases_csts_ms.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_csts_ms_d, "build/euip_cases_csts_ms_d.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_csts_dp, "build/euip_cases_csts_dp.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_csts_dp_d, "build/euip_cases_csts_dp_d.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_ddy, "build/euip_cases_ddy.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_ddy_d, "build/euip_cases_ddy_d.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_network, "build/euip_cases_net.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_network_d, "build/euip_cases_net_d.csv", row.names = FALSE, quote = TRUE)

# decisions
write.csv(decisions, "build/euip_decisions.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_ts, "build/euip_decisions_ts.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_ts_d, "build/euip_decisions_ts_d.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_csts_ms, "build/euip_decisions_csts_ms.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_csts_ms_d, "build/euip_decisions_csts_ms_d.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_csts_dp, "build/euip_decisions_csts_dp.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_csts_dp_d, "build/euip_decisions_csts_dp_d.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_ddy, "build/euip_decisions_ddy.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_ddy_d, "build/euip_decisions_ddy_d.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_network, "build/euip_decisions_net.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_network_d, "build/euip_decisions_net_d.csv", row.names = FALSE, quote = TRUE)

# codebooks
write.csv(codebook, "build/euip_codebook.csv", row.names = FALSE, quote = TRUE)

##################################################
# server
##################################################

# cases
write.csv(cases, "server/euip_cases.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_ts, "server/euip_cases_ts.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_ts_d, "server/euip_cases_ts_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_csts_ms, "server/euip_cases_csts_ms.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_csts_ms_d, "server/euip_cases_csts_ms_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_csts_dp, "server/euip_cases_csts_dp.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_csts_dp_d, "server/euip_cases_csts_dp_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_ddy, "server/euip_cases_ddy.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_ddy_d, "server/euip_cases_ddy_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_network, "server/euip_cases_network.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(cases_network_d, "server/euip_cases_network_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")

# decisions
write.csv(decisions, "server/euip_decisions.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_ts, "server/euip_decisions_ts.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_ts_d, "server/euip_decisions_ts_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_csts_ms, "server/euip_decisions_csts_ms.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_csts_ms_d, "server/euip_decisions_csts_ms_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_csts_dp, "server/euip_decisions_csts_dp.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_csts_dp_d, "server/euip_decisions_csts_dp_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_ddy, "server/euip_decisions_ddy.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_ddy_d, "server/euip_decisions_ddy_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_network, "server/euip_decisions_net.csv", row.names = FALSE, quote = TRUE, na = "\\N")
write.csv(decisions_network_d, "server/euip_decisions_net_d.csv", row.names = FALSE, quote = TRUE, na = "\\N")

# codebooks
write.csv(codebook, "server/euip_codebook.csv", row.names = FALSE, quote = TRUE, na = "\\N")

################################################################################
# end R script
################################################################################
