\name{nxt}
\alias{nxt}
\title{Produces the next set of parents from an existing set of parents (internal).}
\description{A function to find the next parent set in the sequence.}
\usage{nxt(g, max.indeg)}
\arguments{
  \item{g}{A binary vector of length \code{nodes}}
  \item{max.indeg}{The maximum in-degree of the network}
}
\value{A different binary vector of length \code{nodes}}
\author{Simon Spencer}
\seealso{\code{\link{countGraphs}},\code{\link{interventionalDBN-package}}}
\examples{
g<-rep(0,7)
for (i in 1:countGraphs(7,3)) {
  cat(g,"\n")
  g<-nxt(g,3)
}
}
