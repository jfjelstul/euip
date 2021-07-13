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
source("data-raw/code/01_decisions.R")
rm(list = ls())
# input: "data-raw/infringements_raw.csv"
# input: "data-raw/member_states.RData"
# input: "data-raw/departments.RData"
# output: "data/decisions.RData"

# cases
source("data-raw/code/02_cases.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/cases.RData"

# cases TS data
source("data-raw/code/03_cases_ts.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_ts.RData"
# output: "data/cases_ts_ct.RData"

# decisions TS data
source("data-raw/code/04_decisions_ts.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_ts.RData"
# output: "data/decisions_ts_ct.RData"

# cases CSTS data
source("data-raw/code/05_cases_csts.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_csts_ms.RData"
# output: "data/cases_csts_ms_ct.RData"
# output: "data/cases_csts_dp.RData"
# output: "data/cases_csts_dp_ct.RData"

# decisions CSTS data
source("data-raw/code/06_decisions_csts.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_csts_ms.RData"
# output: "data/decisions_csts_ms_ct.RData"
# output: "data/decisions_csts_dp.RData"
# output: "data/decisions_csts_dp_ct.RData"

# cases DDY data
source("data-raw/code/07_cases_ddy.R")
rm(list = ls())
# input: "data/cases.RData"
# output: "data/cases_ddy.RData"
# output: "data/cases_ddy_ct.RData"

# decisions DDY data
source("data-raw/code/08_decisions_ddy.R")
rm(list = ls())
# input: "data/decisions.RData"
# output: "data/decisions_ddy.RData"
# output: "data/decisions_ddy_ct.RData"

# cases network data
source("data-raw/code/09_cases_net.R")
rm(list = ls())
# input: data/cases_ddy.RData
# input: data/cases_ddy_ct.RData
# output: data/cases_net.RData
# output: data/cases_net_ct.RData

# decisions network data
source("data-raw/code/10_decisions_net.R")
rm(list = ls())
# input: data/decisions_ddy.RData
# input: data/decisions_ddy_ct.RData
# output: data/cdecisions_net.RData
# output: data/cdecisions_net_ct.RData

##################################################
# codebook
##################################################

# read in data
variables <- read.csv("data-raw/documentation/euip_variables.csv", stringsAsFactors = FALSE)

# convert to a tibble
variables <- dplyr::as_tibble(variables)

# save
save(variables, file = "data/variables.RData")

##################################################
# datasets
##################################################

# read in data
datasets <- read.csv("data-raw/documentation/euip_datasets.csv", stringsAsFactors = FALSE)

# convert to a tibble
datasets <- dplyr::as_tibble(datasets)

# save
save(datasets, file = "data/datasets.RData")

##################################################
# documentation
##################################################

# documentation
load("data/variables.RData")
load("data/datasets.RData")

# document data
codebookr::document_data(
  file_path = "R/",
  variables_input = variables,
  datasets_input = datasets,
  include_variable_type = TRUE,
  author = "Joshua C. Fjelstul, Ph.D.",
  package = "euip"
)

##################################################
# codebook
##################################################

# create a codebook
codebookr::create_codebook(
  file_path = "codebook/euip_codebook.tex",
  datasets_input = datasets,
  variables_input = variables,
  title_text = "The European Union Infringement Procedure \\\\ (EUIP) Database",
  version_text = "1.0",
  footer_text = "The EUIP Database Codebook \\hspace{5pt} | \\hspace{5pt} Joshua C. Fjelstul, Ph.D.",
  author_names = "Joshua C. Fjelstul, Ph.D.",
  theme_color = "#4D9FEB",
  heading_font_size = 30,
  subheading_font_size = 10,
  title_font_size = 16,
  table_of_contents = TRUE,
  include_variable_type = TRUE
)

##################################################
# load data
##################################################

# cases
load("data/cases.RData")
load("data/cases_ts.RData")
load("data/cases_ts_ct.RData")
load("data/cases_csts_ms.RData")
load("data/cases_csts_ms_ct.RData")
load("data/cases_csts_dp.RData")
load("data/cases_csts_dp_ct.RData")
load("data/cases_ddy.RData")
load("data/cases_ddy_ct.RData")
load("data/cases_net.RData")
load("data/cases_net_ct.RData")

# decisions
load("data/decisions.RData")
load("data/decisions_ts.RData")
load("data/decisions_ts_ct.RData")
load("data/decisions_csts_ms.RData")
load("data/decisions_csts_ms_ct.RData")
load("data/decisions_csts_dp.RData")
load("data/decisions_csts_dp_ct.RData")
load("data/decisions_ddy.RData")
load("data/decisions_ddy_ct.RData")
load("data/decisions_net.RData")
load("data/decisions_net_ct.RData")

# documentation
load("data/variables.RData")
load("data/datasets.RData")

##################################################
# build
##################################################

# cases
write.csv(cases, "build/euip_cases.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_ts, "build/euip_cases_ts.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_ts_ct, "build/euip_cases_ts_ct.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_csts_ms, "build/euip_cases_csts_ms.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_csts_ms_ct, "build/euip_cases_csts_ms_ct.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_csts_dp, "build/euip_cases_csts_dp.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_csts_dp_ct, "build/euip_cases_csts_dp_ct.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_ddy, "build/euip_cases_ddy.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_ddy_ct, "build/euip_cases_ddy_ct.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_net, "build/euip_cases_net.csv", row.names = FALSE, quote = TRUE)
write.csv(cases_net_ct, "build/euip_cases_net_ct.csv", row.names = FALSE, quote = TRUE)

# decisions
write.csv(decisions, "build/euip_decisions.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_ts, "build/euip_decisions_ts.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_ts_ct, "build/euip_decisions_ts_ct.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_csts_ms, "build/euip_decisions_csts_ms.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_csts_ms_ct, "build/euip_decisions_csts_ms_ct.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_csts_dp, "build/euip_decisions_csts_dp.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_csts_dp_ct, "build/euip_decisions_csts_dp_ct.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_ddy, "build/euip_decisions_ddy.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_ddy_ct, "build/euip_decisions_ddy_ct.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_net, "build/euip_decisions_net.csv", row.names = FALSE, quote = TRUE)
write.csv(decisions_net_ct, "build/euip_decisions_net_ct.csv", row.names = FALSE, quote = TRUE)

# documentation
write.csv(variables, "build/euip_variables.csv", row.names = FALSE, quote = TRUE)
write.csv(datasets, "build/euip_datasets.csv", row.names = FALSE, quote = TRUE)

################################################################################
# end R script
################################################################################
