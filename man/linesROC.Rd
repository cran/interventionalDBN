\name{linesROC}
\alias{linesROC}
\title{Add an ROC curve to an existing plot.}
\description{A simple function to produce an ROC curve from a known edge matrix and a posterior edge probability matrix.}
\usage{linesROC(trueMatrix, pep, col = "red", lty = 1, lwd = 1)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{trueMatrix}{The 'true' edge matrix.}
  \item{pep}{A matrix of posterior edge probabilities.}
  \item{col}{A colour (passed to segments).}
  \item{lty}{A line type (passed to segments).}
  \item{lwd}{A line width (passed to segments).}
}
\value{The area of the ROC curve.}
\details{The area of the ROC curve is also sent to the console.}
\author{Simon Spencer}
\seealso{\code{\link{interventionalDBN-package}}}
\examples{
trueMatrix<-matrix(rbinom(225,1,0.5),15,15)
pep<-matrix(runif(225,0.2,1)*trueMatrix+runif(225,0,0.5)*(1-trueMatrix),15,15)
plot(0:1, 0:1, t="l", col="grey", xlab="False positive rate",
  ylab="False negative rate", main="An ROC curve.")
linesROC(trueMatrix,pep)
}
\keyword{ aplot }
