% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_template.R
\name{estimate_template}
\alias{estimate_template}
\alias{estimate_template.cifti}
\alias{estimate_template.gifti}
\alias{estimate_template.nifti}
\title{Estimate template}
\usage{
estimate_template(
  BOLD,
  BOLD2 = NULL,
  GICA,
  inds = NULL,
  scale = c("global", "local", "none"),
  scale_sm_surfL = NULL,
  scale_sm_surfR = NULL,
  scale_sm_FWHM = 2,
  detrend_DCT = 0,
  center_Bcols = FALSE,
  normA = FALSE,
  Q2 = 0,
  Q2_max = NULL,
  brainstructures = c("left", "right"),
  mask = NULL,
  keep_DR = FALSE,
  FC = FALSE,
  varTol = 1e-06,
  maskTol = 0.1,
  missingTol = 0.1,
  usePar = FALSE,
  wb_path = NULL,
  verbose = TRUE
)

estimate_template.cifti(
  BOLD,
  BOLD2 = NULL,
  GICA,
  inds = NULL,
  scale = c("global", "local", "none"),
  scale_sm_surfL = NULL,
  scale_sm_surfR = NULL,
  scale_sm_FWHM = 2,
  detrend_DCT = 0,
  center_Bcols = FALSE,
  normA = FALSE,
  Q2 = 0,
  Q2_max = NULL,
  brainstructures = c("left", "right"),
  keep_DR = FALSE,
  FC = FALSE,
  varTol = 1e-06,
  maskTol = 0.1,
  missingTol = 0.1,
  usePar = FALSE,
  wb_path = NULL,
  verbose = TRUE
)

estimate_template.gifti(
  BOLD,
  BOLD2 = NULL,
  GICA,
  inds = NULL,
  scale = c("global", "local", "none"),
  scale_sm_surfL = NULL,
  scale_sm_surfR = NULL,
  scale_sm_FWHM = 2,
  detrend_DCT = 0,
  center_Bcols = FALSE,
  normA = FALSE,
  Q2 = 0,
  Q2_max = NULL,
  brainstructures = c("left", "right"),
  keep_DR = FALSE,
  FC = FALSE,
  varTol = 1e-06,
  maskTol = 0.1,
  missingTol = 0.1,
  usePar = FALSE,
  wb_path = NULL,
  verbose = TRUE
)

estimate_template.nifti(
  BOLD,
  BOLD2 = NULL,
  GICA,
  inds = NULL,
  scale = c("global", "local", "none"),
  detrend_DCT = 0,
  center_Bcols = FALSE,
  normA = FALSE,
  Q2 = 0,
  Q2_max = NULL,
  mask = NULL,
  keep_DR = FALSE,
  FC = FALSE,
  varTol = 1e-06,
  maskTol = 0.1,
  missingTol = 0.1,
  usePar = FALSE,
  wb_path = NULL,
  verbose = TRUE
)
}
\arguments{
\item{BOLD, BOLD2}{Vector of subject-level fMRI data in one of the following
formats: CIFTI file paths, \code{"xifti"} objects, GIFTI file paths,
\code{"gifti"} objects, NIFTI file paths, \code{"nifti"} objects,
or \eqn{V \times T} numeric matrices, where \eqn{V} is the number of data
locations and \eqn{T} is the number of timepoints.

If \code{BOLD2} is provided it must be in the same format as \code{BOLD};
\code{BOLD} will be the test data and \code{BOLD2} will be the retest data.
\code{BOLD2} should be the same length as \code{BOLD} and have the same
subjects in the same order. If \code{BOLD2} is not provided, \code{BOLD}
will be split in half; the first half will be the test data and the second
half will be the retest data.}

\item{GICA}{Group ICA maps in a format compatible with \code{BOLD}. Can also
be a (vectorized) numeric matrix (\eqn{V \times Q}) no matter the format of
\code{BOLD}. Its columns will be centered.}

\item{inds}{Numeric indices of the group ICs to include in the template. If
\code{NULL}, use all group ICs (default).

If \code{inds} is provided, the ICs not included will be removed after
calculating dual regression, not before. This is because removing the ICs
prior to dual regression would leave unmodelled signals in the data, which
could bias the templates.}

\item{scale}{\code{"global"} (default), \code{"local"}, or \code{"none"}.
Global scaling will divide the entire data matrix by the mean image standard
deviation (\code{mean(sqrt(rowVars(BOLD)))}). Local scaling will divide each
data location's time series by its estimated standard deviation.}

\item{scale_sm_surfL, scale_sm_surfR, scale_sm_FWHM}{Only applies if
\code{scale=="local"} and \code{BOLD} represents surface data (CIFTI or
GIFTI). To smooth the standard deviation estimates used for local scaling,
provide the surface geometries along which to smooth as GIFTI geometry files
or \code{"surf"} objects, as well as the smoothing FWHM (default: \code{2}).

If \code{scale_sm_FWHM==0}, no smoothing of the local standard deviation
estimates will be performed.

If \code{scale_sm_FWHM>0} but \code{scale_sm_surfL} and
\code{scale_sm_surfR} are not provided, the default inflated surfaces from
the HCP will be used.

To create a \code{"surf"} object from data, see
\code{\link[ciftiTools]{make_surf}}. The surfaces must be in the same
resolution as the \code{BOLD} data.}

\item{detrend_DCT}{Detrend the data? This is an integer number of DCT bases
to use for detrending. If \code{0} (default), do not detrend.}

\item{center_Bcols}{Center BOLD across columns (each image)? This
is equivalent to performing global signal regression. Default:
\code{FALSE}.}

\item{normA}{Scale each IC timeseries (column of \eqn{A}) in the dual
regression estimates? Default: \code{FALSE} (not recommended). Note that the
product \eqn{A \times S} remains the same with either option.}

\item{Q2, Q2_max}{Obtain dual regression estimates after denoising? Denoising is
based on modeling and removing nuisance ICs. It may result in a cleaner
estimate for smaller datasets, but it may be unnecessary (and time-consuming)
for larger datasets.

Set \code{Q2} to control denoising: use a positive integer to specify the
number of nuisance ICs, \code{NULL} to have the number of nuisance ICs
estimated by PESEL, or zero (default) to skip denoising.

If \code{is.null(Q2)}, use \code{Q2_max} to specify the maximum number of
nuisance ICs that should be estimated by PESEL. \code{Q2_max} must be less
than \eqn{T * .75 - Q} where \eqn{T} is the minimum number of timepoints in
each fMRI scan and \eqn{Q} is the number of group ICs. If \code{NULL}
(default), \code{Q2_max} will be set to \eqn{T * .50 - Q}, rounded.}

\item{brainstructures}{Only applies if the entries of \code{BOLD} are CIFTI
file paths. This is a character vector indicating which brain structure(s)
to obtain: \code{"left"} (left cortical surface), \code{"right"} (right
cortical surface) and/or \code{"subcortical"} (subcortical and cerebellar
gray matter). Can also be \code{"all"} (obtain all three brain structures).
Default: \code{c("left","right")} (cortical surface only).}

\item{mask}{Required if and only if the entries of \code{BOLD} are NIFTI
file paths or \code{"nifti"} objects. This is a brain map formatted as a
binary array of the same spatial dimensions as the fMRI data, with
\code{TRUE} corresponding to in-mask voxels.}

\item{keep_DR}{Keep the DR estimates? If \code{FALSE} (default), do not save
the DR estimates and only return the templates. If \code{TRUE}, the DR
estimates are returned too. If a single file path, save the DR estimates as
an RDS file at that location rather than returning them.}

\item{FC}{Include the functional connectivity template? Default: \code{FALSE}
(not fully supported yet.)}

\item{varTol}{Tolerance for variance of each data location. For each scan,
locations which do not meet this threshold are masked out of the analysis.
Default: \code{1e-6}. Variance is calculated on the original data, before
any normalization.}

\item{maskTol}{For computing the dual regression results for each subject:
tolerance for number of locations masked out due to low
variance or missing values. If more than this many locations are masked out,
a subject is skipped without calculating dual regression. \code{maskTol}
can be specified either as a proportion of the number of locations (between
zero and one), or as a number of locations (integers greater than one).
Default: \code{.1}, i.e. up to 10 percent of locations can be masked out.

If \code{BOLD2} is provided, masks are calculated for both scans and then
the intersection of the masks is used, for each subject.}

\item{missingTol}{For computing the variance decomposition across all subjects:
tolerance for number of subjects masked out due to low variance or missing
values at a given location. If more than this many subjects are masked out,
the location's value will be \code{NA} in the templates. \code{missingTol}
can be specified either as a proportion of the number of locations (between
zero and one), or as a number of locations (integers greater than one).
Default: \code{.1}, i.e. up to 10 percent of subjects can be masked out
at a given location.}

\item{usePar, wb_path}{Parallelize the DR computations over subjects? Default:
\code{FALSE}. Can be the number of cores to use or \code{TRUE}, which will
use the number on the PC minus two. If the input data is in CIFTI format, the
\code{wb_path} must also be provided.}

\item{verbose}{Display progress updates? Default: \code{TRUE}.}
}
\value{
A list: the \code{template} and \code{var_decomp} with entries in
matrix format; the \code{mask} of locations without template values due to
too many low variance or missing values; the function \code{params} such as
the type of scaling and detrending performed; the \code{dat_struct} which
can be used to convert \code{template} and \code{var_decomp} to
\code{"xifti"} or \code{"nifti"} objects if the \code{BOLD} format was CIFTI
or NIFTI data; and \code{DR} if \code{isTRUE(keep_DR)}.

Use \code{summary} to print a description of the template results, and
for CIFTI-format data use \code{plot} to plot the template mean and variance
estimates. Use \code{\link{export_template}} to save the templates to
individual RDS, CIFTI, or NIFTI files (depending on the \code{BOLD} format).
}
\description{
Estimate template for Template ICA based on fMRI data
}
\details{
All fMRI data (entries in \code{BOLD} and \code{BOLD2}, and \code{GICA}) must
be in the same spatial resolution.
}
\examples{
nT <- 30
nV <- 400
nQ <- 7
mU <- matrix(rnorm(nV*nQ), nrow=nV)
mS <- mU \%*\% diag(seq(nQ, 1)) \%*\% matrix(rnorm(nQ*nT), nrow=nQ)
BOLD <- list(B1=mS, B2=mS, B3=mS)
BOLD <- lapply(BOLD, function(x){x + rnorm(nV*nT, sd=.05)})
GICA <- mU
estimate_template(BOLD=BOLD, GICA=mU)

\dontrun{
 estimate_template(
   run1_cifti_fnames, run2_cifti_fnames,
   gICA_cifti_fname, brainstructures="all",
   scale="local", detrend_DCT=7, Q2=NULL, varTol=10
 )
}
}
