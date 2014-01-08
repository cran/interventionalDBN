\name{warshall}
\alias{warshall}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Find the largest edge probability threshold that connects a pair of nodes.}
\description{This function runs a slight variation on the Warshall algorithm to find the largest posterior edge probability threshold that allows each pair of nodes to remain connected. It is useful for calculating ROC curves based on descendancy information.}
\usage{warshall(M)}
\arguments{
  \item{M}{A square matrix of probabilities.}
}
\details{The Warshall algorithm is \eqn{O(P)^3}, where \eqn{P} is the number of nodes.}
\value{A square matrix, where element \eqn{(i,j)} is the largest edge probability threshold that allows \eqn{i} to remain connected to \eqn{j}.}
%%\references{}
\author{Simon Spencer}
%%\note{}
%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{\code{\link{interventionEffects}}, \code{\link{interventionalDBN-package}}}
\examples{
M1<-rbind(c(0.5,1,0),c(0,0,1),c(0,0,0))# A->B->C
warshall(M1)# A is upstream of B and C, B is upstream of C.
# Note that A is upstream of itself iff there is a cycle.

M2<-matrix(runif(25),5,5)
warshall(M2)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
