% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cases_ddy.R
\docType{data}
\name{cases_ddy}
\alias{cases_ddy}
\title{Case-level directed dyad-year data}
\format{
A data frame with 9 variables:
\describe{
\item{key_id}{\code{numeric}. An ID number that uniquely identifies each
observation in the dataset. }
\item{year}{\code{numeric}. The year the case was opened by the
Commission.}
\item{department_id}{\code{numeric}. An ID number that uniquely identifies
each Commission department.}
\item{department}{\code{string}. The name of the Commission department that
opened the infringement case.}
\item{department_code}{\code{string}. A multi-letter code assigned by the
Commission that uniquely identifies each department.}
\item{member_state_id}{\code{numeric}. An ID number that uniquely
identifies each member state. This ID number is assigned when member states
are sorted by accession date and then alphabetically. }
\item{member_state}{\code{string}. The name of the member state that the
Commission opened the case against. }
\item{member_state_code}{\code{string}. A two letter code assigned by the
Commission that uniquely identifies each member state. }
\item{count_cases}{\code{numeric}. A count of the number of cases opened by
the Commission at this level of aggregation.}
}
}
\usage{
cases_ddy
}
\description{
This dataset includes aggregated data on the number of infringement cases
per department per member state per year (directed dyad-year data). There
is one observation per department per member state per year (2002-2020),
excluding directed dyad-years where the state was not a member of the EU.
The dataset uses current department names.
}
\keyword{datasets}
