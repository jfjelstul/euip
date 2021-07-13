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
load("data/cases_ddy_ct.RData")

##################################################
# cases_net
##################################################

# make an edge list
cases_net <- dplyr::filter(cases_ddy, count_cases > 0)

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
cases_net <- dplyr::arrange(cases_net, year, from_node_id, to_node_id)

# key ID
cases_net$key_id <- 1:nrow(cases_net)

# select variables
cases_net <- dplyr::select(
  cases_net,
  key_id, year,
  from_node_id, from_node, to_node_id, to_node,
  edge_weight
)

# save
save(cases_net, file = "data/cases_net.RData")

##################################################
# cases_net_ct
##################################################

# make an edge list
cases_net_ct <- dplyr::filter(cases_ddy_ct, count_cases > 0)

# from node ID
cases_net_ct$from_node_id <- as.numeric(as.factor(cases_net_ct$department_id))

# from node
cases_net_ct$from_node <- cases_net_ct$department

# to node ID
cases_net_ct$to_node_id <- as.numeric(as.factor(cases_net_ct$member_state_id))

# to node
cases_net_ct$to_node <- cases_net_ct$member_state

# edge weight
cases_net_ct$edge_weight <- cases_net_ct$count_cases

# layer ID
cases_net_ct$layer_id <- as.numeric(as.factor(cases_net_ct$case_type_id))

# layer
cases_net_ct$layer <- cases_net_ct$case_type

# arrange
cases_net_ct <- dplyr::arrange(cases_net_ct, year, layer_id, from_node_id, to_node_id)

# key ID
cases_net_ct$key_id <- 1:nrow(cases_net_ct)

# select variables
cases_net_ct <- dplyr::select(
  cases_net_ct,
  key_id, year,
  layer_id, layer,
  from_node_id, from_node, to_node_id, to_node,
  edge_weight
)

# save
save(cases_net_ct, file = "data/cases_net_ct.RData")

################################################################################
# end R script
################################################################################
