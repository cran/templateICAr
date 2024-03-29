% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{make_mask}
\alias{make_mask}
\title{Create a mask based on vertices that are invalid}
\usage{
make_mask(BOLD, meanTol = -Inf, varTol = 1e-06, verbose = TRUE)
}
\arguments{
\item{BOLD}{A \eqn{V \times T} numeric matrix. Each row is a location.}

\item{meanTol, varTol}{Tolerance for mean and variance of each data location.
Locations which do not meet these thresholds are masked out of the analysis.
Defaults: \code{-Inf} for \code{meanTol} (ignore), and \code{1e-6} for
\code{varTol}.}

\item{verbose}{Print messages counting how many locations are removed?}
}
\value{
A logical vector indicating valid vertices
}
\description{
Create a mask based on vertices that are invalid
}
\keyword{internal}
