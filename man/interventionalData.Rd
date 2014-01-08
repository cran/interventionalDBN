\name{interventionalData}
\alias{interventionalData}
\docType{data}
\title{Simulated micro-array timecourse data speadsheet.}
\description{A simulated microarray timecourse dataset, generated using the perfect and fixed effect intervention models.}
\usage{data(interventionalData)}
\format{
A data frame with 32 observations on the following 19 variables.
\describe{
\item{\code{Cell.line}}{a factor with levels representing the cell line.}
\item{\code{Inhibitor}}{a factor with levels describing the inhibitors used in each sample.}
\item{\code{Stimuli}}{a factor with levels describing the stimulus used in each sample.}
\item{\code{Timepoint}}{a integer vector (starting from zero) representing the time index of each sample.}
\item{\code{EGFR}, \code{SRC}, \code{STAT5}, \code{Mek}, \code{MAPK}, \code{p90RSK}, \code{PDK}, \code{AKT}, \code{GSK}, \code{TSC2}, \code{BAD}, \code{mTOR}, \code{p70S6K}, \code{S6}, \code{FOXO3}}{The remaining columns give the log-concentrations of each node.}
}
}
\source{Simulated by Simon Spencer.}
%\references{}
\examples{
data(interventionalData)
interventionalData
}
\seealso{\code{\link{formatData}}, \code{\link{interventionEffects}}, \code{\link{interventionalDBN-package}}.}

\keyword{datasets}
