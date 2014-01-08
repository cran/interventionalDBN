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
\item{\code{EGFR, SRC, STAT5, Mek, MAPK, p90RSK, PDK, AKT, GSK, TSC2, BAD, mTOR, p70S6K, S6, FOXO3}}{The remaining columns give the log-concentrations of each node.}
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
