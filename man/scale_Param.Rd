% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rox_args_docs.R
\name{scale_Param}
\alias{scale_Param}
\title{scale}
\arguments{
\item{scale}{\code{"global"} (default), \code{"local"}, or \code{"none"}.
Global scaling will divide the entire data matrix by the mean image standard
deviation (\code{mean(sqrt(rowVars(BOLD)))}). Local scaling will divide each
data location's time series by its estimated standard deviation.}
}
\description{
scale
}
\keyword{internal}
