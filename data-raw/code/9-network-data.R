################################################################################
# Joshua C. Fjelstul, Ph.D.
# euip R package
################################################################################

# define pipe function
`%>%` <- magrittr::`%>%`

##################################################
# read in data
##################################################

load("data/cases_ddy.RData")
load("data/cases_ddy_d.RData")
load("data/decisions_ddy.RData")
load("data/decisions_ddy_d.RData")

##################################################
# filter data
##################################################

cases_net <- dplyr::filter(cases_ddy, count_cases > 0)
cases_net_d <- dplyr::filter(cases_ddy_d, count_cases > 0)
decisions_net <- dplyr::filter(decisions_ddy, count_decisions > 0)
decisions_net_d <- dplyr::filter(decisions_ddy_d, count_decisions > 0)

##################################################
# cases_net
##################################################

# make an edge list 
cases_net <- dplyr::filter(cases_ddy, count_cases > 0)

# time
cases_net$time <- cases_net$year - min(cases_net$year) + 1

# from node ID
cases_net$from_node_id <- as.numeric(as.factor(cases_net$department_id))

# from node
cases_net$from_node <- cases_net$department

# to node ID
cases_net$to_node_id <- as.numeric(as.factor(cases_net$member_state_id))

# to node
cases_net$to_node <- cases_net$member_state

# edge weight
cases_net$edge_weight <- cases_net$count_cases

# arrange
cases_net <- dplyr::arrange(cases_net, time, from_node_id, to_node_id)

# key ID
cases_net$key_id <- 1:nrow(cases_net)

# select variables
cases_net <- dplyr::select(
 cases_net,
 key_id, time, 
 from_node_id, from_node, to_node_id, to_node,
 edge_weight
)

##################################################
# cases_net_d
##################################################

# make an edge list 
cases_net_d <- dplyr::filter(cases_ddy_d, count_cases > 0)

# time
cases_net_d$time <- cases_net_d$year - min(cases_net_d$year) + 1

# from node ID
cases_net_d$from_node_id <- as.numeric(as.factor(cases_net_d$department_id))

# from node
cases_net_d$from_node <- cases_net_d$department

# to node ID
cases_net_d$to_node_id <- as.numeric(as.factor(cases_net_d$member_state_id))

# to node
cases_net_d$to_node <- cases_net_d$member_state

# edge weight
cases_net_d$edge_weight <- cases_net_d$count_cases

# layer ID
cases_net_d$layer_id <- as.numeric(as.factor(cases_net_d$case_type_id))

# layer
cases_net_d$layer <- cases_net_d$case_type

# arrange
cases_net_d <- dplyr::arrange(cases_net_d, time, layer_id, from_node_id, to_node_id)

# key ID
cases_net_d$key_id <- 1:nrow(cases_net_d)

# select variables
cases_net_d <- dplyr::select(
 cases_net_d,
 key_id, time, 
 layer_id, layer,
 from_node_id, from_node, to_node_id, to_node,
 edge_weight
)

##################################################
# decisions_net
##################################################

# make an edge list 
decisions_net <- dplyr::filter(decisions_ddy, count_decisions > 0)

# time
decisions_net$time <- decisions_net$year - min(decisions_net$year) + 1

# from node ID
decisions_net$from_node_id <- as.numeric(as.factor(decisions_net$department_id))

# from node
decisions_net$from_node <- decisions_net$department

# to node ID
decisions_net$to_node_id <- as.numeric(as.factor(decisions_net$member_state_id))

# to node
decisions_net$to_node <- decisions_net$member_state

# edge weight
decisions_net$edge_weight <- decisions_net$count_decisions

# layer ID
decisions_net$layer_id <- as.numeric(as.factor(decisions_net$decision_stage_id))

# layer
decisions_net$layer <- decisions_net$decision_stage

# arrange
decisions_net <- dplyr::arrange(decisions_net, time, layer_id, from_node_id, to_node_id)

# key ID
decisions_net$key_id <- 1:nrow(decisions_net)

# select variables
decisions_net <- dplyr::select(
 decisions_net,
 key_id, time, 
 layer_id, layer,
 from_node_id, from_node, to_node_id, to_node,
 edge_weight
)

##################################################
# decisions_net_d
##################################################

# make an edge list 
decisions_net_d <- dplyr::filter(decisions_ddy_d, count_decisions > 0)

# time
decisions_net_d$time <- decisions_net_d$year - min(decisions_net_d$year) + 1

# from node ID
decisions_net_d$from_node_id <- as.numeric(as.factor(decisions_net_d$department_id))

# from node
decisions_net_d$from_node <- decisions_net_d$department

# to node ID
decisions_net_d$to_node_id <- as.numeric(as.factor(decisions_net_d$member_state_id))

# to node
decisions_net_d$to_node <- decisions_net_d$member_state

# edge weight
decisions_net_d$edge_weight <- decisions_net_d$count_decisions

# layer ID
decisions_net_d$d1_layer_id <- as.numeric(as.factor(decisions_net_d$case_type_id))
decisions_net_d$d2_layer_id <- as.numeric(as.factor(decisions_net_d$decision_stage_id))

# layer
decisions_net_d$d1_layer <- decisions_net_d$case_type
decisions_net_d$d2_layer <- decisions_net_d$decision_stage

# arrange
decisions_net_d <- dplyr::arrange(decisions_net_d, time, d1_layer_id, d2_layer_id, from_node_id, to_node_id)

# key ID
decisions_net_d$key_id <- 1:nrow(decisions_net_d)

# select variables
decisions_net_d <- dplyr::select(
 decisions_net_d,
 key_id, time, 
 d1_layer_id, d1_layer, d2_layer_id, d2_layer,
 from_node_id, from_node, to_node_id, to_node,
 edge_weight
)

##################################################
# save
##################################################

save(cases_net, file = "data/cases_net.RData")
save(cases_net_d, file = "data/cases_net_d.RData")
save(decisions_net, file = "data/decisions_net.RData")
save(decisions_net_d, file = "data/decisions_net_d.RData")

################################################################################
# end R script
################################################################################
