###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

##################################################
# read in data
##################################################

load("data/cases_DDY.RData")
load("data/cases_DDY_D.RData")
load("data/decisions_DDY.RData")
load("data/decisions_DDY_D.RData")

##################################################
# filter data
##################################################

cases_NET <- dplyr::filter(cases_DDY, count_cases > 0)
cases_NET_D <- dplyr::filter(cases_DDY_D, count_cases > 0)
decisions_NET <- dplyr::filter(decisions_DDY, count_decisions > 0)
decisions_NET_D <- dplyr::filter(decisions_DDY_D, count_decisions > 0)

##################################################
# save
##################################################

save(cases_NET, file = "data/cases_NET.RData")
save(cases_NET_D, file = "data/cases_NET_D.RData")
save(decisions_NET, file = "data/decisions_NET.RData")
save(decisions_NET_D, file = "data/decisions_NET_D.RData")

###########################################################################
# end R script
###########################################################################
