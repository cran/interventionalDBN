\name{formatData}
\alias{formatData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Format a microarray spreadsheet ready for interventional network inference function}
\description{This function formats a microarray timecourse dataset ready for the \code{interventionalInference} function.}
\usage{
formatData(d, cellLines = NULL, inhibitors = NULL, stimuli = NULL, times = NULL,
  nodes = NULL, intercept = TRUE, initialIntercept = TRUE, gradients = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{d}{A microarray spreadsheet, a \eqn{samples} by (4 + \eqn{P}) matrix, where \eqn{P} is the number of measurements for each sample.\cr
  Column 1 gives the cell line in each sample.\cr
  Column 2 gives the inhibitor used in each sample.\cr
  Column 3 gives the stimulus used in each sample.\cr
  Column 4 gives the time each sample was measured.}
  \item{cellLines}{A vector specifying a subset of cell lines to analyse (if absent, they are all used).}
  \item{inhibitors}{A vector specifying a subset of the inhibitors to analyse (if absent, they are all used).}
  \item{stimuli}{A vector specifying a subset of the stimuli to analyse (if absent, they are all used).}
  \item{times}{A vector specifying a subset of the times to analyse as the response (if absent, they are all used).}
  \item{nodes}{A vector specifying the indices of a subset of nodes to include in the analysis.\cr
  Further nodes can be removed from the response in the interventionalInferenceDBN function.}
  \item{intercept}{A logical value indicating whether an intercept parameter should be included in all models.}
  \item{initialIntercept}{A logical value indicating whether an intercept parameter should be used to estimate the level at the initial timepoint.
  Only used if the initial timepoint is in the response.}
  \item{gradients}{A logical value indicating whether the concentraion gradient should be used as the response instead of the raw concentrations.
  This model has parallels with a dynamical systems viewpoint, and requires the covariance matrix to be adjusted. See \code{Sigma}.}
}
\details{The entries of column 4 of \code{d} must be real numbers. Missing values are acceptable and are handled as follows:
  \enumerate{
    \item{Missing values in the response are ignored.}
    \item{For the predictors, if a single timepoint is missing, the predictors are interpolated from the two immediate neighbours.}
    \item{If one of the two immediate neighbours is missing then the response is ignored.}
    \item{UNLESS the predictor in question is for the initial observation (which is always missing), in which case 0 is returned, so that the level at zero can be estimated by a second intercept parameter in the \code{interventionalInferenceDBN} function.}
  }
}
\value{
  \item{y}{The \eqn{n} by \eqn{P} response matrix, where \eqn{n} is the number of observations in the response. Not necesarily the same as the number of samples.}
  \item{X0}{The \eqn{n} by \eqn{a} design matrix of predcitors to be included in all models. Usually the intercept and zero intercept (if present).}
  \item{X1}{The \eqn{n} by \eqn{P} design matrix of predictors to undergo model selection.}
  \item{Sigma}{The \eqn{n} by \eqn{n} covariance matrix for a single column of \code{y} (proportional to \eqn{\sigma^2}). The identity matrix, unless \code{gradients} is \code{TRUE}.}
  \item{sampleInfo}{An \eqn{n} by 4 matrix giving the cell line, inhibitor, stimulus and timepoint for each observation used in the response.}
  \item{interpolated}{A matrix similar to \code{sampleInfo}, giving the particulars of any observations for which the predictors were interpolated.
  Empty if no interpolation has been used.}
  \item{cond}{A vector indexing the experimental conditions, given by the cell line, inhibitor and stimulus used in each sample.}
}
\author{Simon Spencer}
\seealso{\code{\link{interventionalInference}}, \code{\link{interventionalInferenceAdvanced}}, \code{\link{interventionalDBN-package}}, \code{\link{interventionEffects}}}
\examples{
data(interventionalData)
# Load your own data spreadsheet using myData<-read.csv("myDataFile.csv").

# Use everything
fullData <- formatData(interventionalData)

# Use only DMSO and EGFRi samples.
halfData <- formatData(interventionalData,inhibitors=c("DMSO","EGFRi"))

# Produce gradients as response
diffData <- formatData(interventionalData,gradients=TRUE,initialIntercept=FALSE)
# Different results if we use the time between observations, rather than the timepoint.
interventionalData[,4]<-rep(c(0,5,10,20,30,60,90,120),4)
diffData2 <- formatData(interventionalData,gradients=TRUE,initialIntercept=FALSE)

# When there is missing data, interpolation also uses the time differences. 
missingData <- interventionalData[-4,]
fullData2 <- formatData(missingData)
}
