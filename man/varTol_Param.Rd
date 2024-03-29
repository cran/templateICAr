% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rox_args_docs.R
\name{varTol_Param}
\alias{varTol_Param}
\title{varTol}
\arguments{
\item{varTol}{Tolerance for variance of each data location. For each scan,
locations which do not meet this threshold are masked out of the analysis.
Default: \code{1e-6}. Variance is calculated on the original data, before
any normalization. Set to \code{0} to avoid removing locations due to
low variance.}
}
\description{
varTol
}
\keyword{internal}
