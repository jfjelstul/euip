###########################################################################
# Josh Fjelstul, Ph.D.
# euinfr R package
###########################################################################

# function to call the EUIP API
# takes in the query in the form of a string
# returns a tibble
call_API <- function(query) {

  # call API
  response <- httr::GET(query)

  # convert JSON to tibble
  out <- jsonlite::fromJSON(rawToChar(response$content))

  # check for API errors
  if(names(out)[1] == "error") {
    message <- stringr::str_to_lower(out[1])
    message <- stringr::str_replace(message, "^the", "The")
    message <- stringr::str_c("Error from API: ", message, collapse = "")
    stop(message)
  }

  # convert to a tibble
  out <- dplyr::as_tibble(out)

  # return a tibble
  return(out)
}

###########################################################################
# end R script
###########################################################################
