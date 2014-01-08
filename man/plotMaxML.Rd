\name{plotMaxML}
\alias{plotMaxML}
\title{Plot the performance of maximum marginal likelihood (Empirical Bayes).}
\description{Make a plot of the marginal likelihood against the prior strength parameter, highlighting the value used to produce the network.}
\usage{plotMaxML(output,xlab="Prior strength",ylab="Marginal likelihood",
  col.max="red",lty.max=3,lwd.max=1,...)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{output}{The object returned from the interventionalInference function.}
  \item{xlab}{A label for the prior strength axis.}
  \item{ylab}{A label for the marginal likelihood axis.}
  \item{col.max}{The colour of the line highlighting the maximum.}
  \item{lty.max}{The line type of the highlight.}
  \item{lwd.max}{The line width of the highlight.}
  \item{...}{Other arguments, such as \code{main}, which are passed to \code{plot}.}
}
\details{It is important to check that the Empirical Bayes calculation is doing something sensible.}
\author{Simon Spencer}
\seealso{\code{\link{interventionalDBN-package}},\code{\link{interventionalInference}}}
\examples{
library(interventionalDBN)
data(interventionalData)# loads interventionalData.
# Load your own data spreadsheet using myData<-read.csv("myDataFile.csv").

# Format the data for network inference
d<-formatData(interventionalData)

# EGFRi is active in conditions 2 and 4, AKTi is active in conditions 3 and 4.
# Each condition has 8 timepoints.
Z<-matrix(0,32,15)
Z[9:16,1]<-1 # EGFR (node 1) inhibited in condition 2
Z[25:32,1]<-1 # EGFR inhibited in condition 4
Z[17:24,8]<-1 # AKT (node 8) inhibited in condition 3
Z[25:32,8]<-1 # AKT inhibited in condition 4

# Perform network inference with Hamming Prior that prefers self-edges,
# and use Empirical Bayes to choose the priorStrength.
myNetwork4<-interventionalInference(d$y,d$X0,d$X1,Z,max.indeg=3,
  perfectOut=TRUE,fixedEffectOut=TRUE,
  priorType="Hamming",priorGraph=diag(rep(1,15)),priorStrength=0:10/2)
# You should always check to see if the Empirical Bayes appears to be working.
plotMaxML(myNetwork4)
}
\keyword{ aplot }
