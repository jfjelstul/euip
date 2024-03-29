% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/decisions_csts_dp_ct.R
\docType{data}
\name{decisions_csts_dp_ct}
\alias{decisions_csts_dp_ct}
\title{Decision-level cross-sectional time-series data by department and case type}
\format{
A data frame with 10 variables:
\describe{
\item{key_id}{\code{numeric}. An ID number that uniquely identifies each
observation in the dataset. }
\item{year}{\code{numeric}. The year the decision was issued by the
Commission.}
\item{department_id}{\code{numeric}. An ID number that uniquely identifies
each Commission department.}
\item{department}{\code{string}. The name of the Commission department that
opened the infringement case.}
\item{department_code}{\code{string}. A multi-letter code assigned by the
Commission that uniquely identifies each department.}
\item{case_type_id}{\code{numeric}. An ID number that uniquely identifies
each type of state aid cases. Coded \code{1} for noncommunication cases,
which are cases that relate to a member state failing to notify the
Commission that it has transposed a directive by the stated deadline. Coded
\code{2} for nonconformity cases, which are cases that relate to a member
state incorrectly transposing a directive. }
\item{case_type}{\code{string}. The type of the infringement case. There
are two types of cases. Coded \code{noncommunication} for cases that relate
to a member state failing to notify the Commission that it has transposed a
directive by the stated deadline. Coded \code{nonconformity} for cases that
relate to a member state incorrectly transposing a directive. }
\item{decision_stage_id}{\code{numeric}. An ID number that uniquely
identifies each decision stage in the infringement procedure. Coded
\code{1} for letters of formal notice under Article 258 of the Treaty on
the Functioning of the European Union (TFEU), coded \code{2} for reasoned
opinions under Article 258, coded \code{3} for referrals to the Court under
Article 258, coded \code{4} for letters of formal notice under Article 260,
coded \code{5} for reasoned opinions under Article 260, and coded \code{6}
for referrals to the Court under Article 266}
\item{decision_stage}{\code{string}. The decision stage of the infringement
procedure. Possible values include: \code{Letter of formal notice (Article
258)}, \code{Reasoned opinion (Article 259)}, \code{Referral to the Court
(Article 258)}, \code{Letter of formal notice (Article 260)},
\code{Reasoned opinion (Article 260)}, and \code{Referral to the Court
(Article 260)}. }
\item{count_decisions}{\code{numeric}. A count of the number of decisions
made by the Commission in infringement cases at this level of aggregation.}
}
}
\usage{
decisions_csts_dp_ct
}
\description{
This dataset includes aggregated data on the number of decisions per stage
of the infringement procedure per department per year (cross-sectional
time-series data) broken down by case type (noncommunication vs
nonconformity). There is one observation per department per year per
decision stage per case type (2002-2020). The dataset uses current
department names.
}
\keyword{datasets}
