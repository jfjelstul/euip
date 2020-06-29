###########################################################################
# Joshua C. Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# function to add a range filter to an existing query
add_range_filter <- function(query, par) {

  # if the filter is not empty
  if(!is.null(par)) {

    # par name
    name <- stringr::str_to_upper(deparse(substitute(par)))

    # collapse into a string
    value <- stringr::str_c(par, collapse = "-")

    # create the filter
    filter <- stringr::str_c(name, "=", value, collapse = "")

    # check if the filter is not the first
    if(!stringr::str_detect(query, "[?]$")) {
      filter <- stringr::str_c("&", filter, collapse = "")
    }

    # add the filter
    query <- stringr::str_c(query, filter, collapse = "")
  }

  # return the query with the new filter
  return(query)
}

# function to add an option filter to an existing query
add_option_filter <- function(query, par) {

  # if the filter is not empty
  if(!is.null(par)) {

    # par name
    name <- stringr::str_to_upper(deparse(substitute(par)))

    # collapse into a string
    value <- stringr::str_c(par, collapse = "+")

    # create the filter
    filter <- stringr::str_c(name, "=", value, collapse = "")

    # check if the filter is not the first
    if(!stringr::str_detect(query, "[?]$")) {
      filter <- stringr::str_c("&", filter, collapse = "")
    }

    # add the filter
    query <- stringr::str_c(query, filter, collapse = "")
  }

  # return the query with the new filter
  return(query)
}

# function to add a logical filter to an existing query
add_logical_filter <- function(query, par) {

  # if the filter is not empty
  if(!is.null(par)) {

    # if TRUE
    if(par == TRUE) {

      # par name
      name <- stringr::str_to_upper(deparse(substitute(par)))

      # collapse into a string
      value <- "TRUE"

      # create the filter
      filter <- stringr::str_c(name, "=", value, collapse = "")

      # check if the filter is not the first
      if(!stringr::str_detect(query, "[?]$")) {
        filter <- stringr::str_c("&", filter, collapse = "")
      }

      # add the filter
      query <- stringr::str_c(query, filter, collapse = "")
    }
  }

  # return the query with the new filter (if not empty)
  return(query)
}

###########################################################################
# end R script
###########################################################################
