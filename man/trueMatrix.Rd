\name{trueMatrix}
\alias{trueMatrix}
\docType{data}
\title{The true edge matrix used to generate \code{interventionalData}.}
\description{The 15 by 15 binary edge matrix that was used to generate the dataset \code{\link{interventionalData}}.}
\usage{data(trueMatrix)}
\source{Simon Spencer}
\seealso{\code{\link{interventionalData}},\code{\link{interventionalDBN-package}}}
%\references{}
\examples{
data(trueMatrix)
pep<-matrix(runif(225,0.2,1)*trueMatrix+runif(225,0,0.5)*(1-trueMatrix),15,15)
plot(0:1, 0:1, t="l", col="grey", xlab="False positive rate",
  ylab="False negative rate",main="An ROC curve.")
linesROC(trueMatrix,pep)
}
\keyword{datasets}
