\name{countGraphs}
\alias{countGraphs}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Count the number of possible parents}
\description{Counts the number of choices of parents given a maximum in-degree restriction.}
\usage{countGraphs(nodes, max.indeg)}
\arguments{
  \item{nodes}{A positive integer specifying the number of nodes in the network.}
  \item{max.indeg}{A positive integer specifying the in-degree restriction.}
}
\details{Nodes can be a parent to themselves. The number of possible networks is given by\cr
\code{nodes*countGraphs(nodes,max.indeg)}.}
\value{Returns an integer given by \eqn{\sum_{i=0}^m{n \choose i}}{\sum_{i=0}^m{n \choose i}}, where \code{nodes}\eqn{=n} and \code{max.indegree}\eqn{=m}}
%%\references{}
\author{Simon Spencer}
%%\note{}
%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{\code{\link{interventionalInference}}, \code{\link{interventionalDBN-package}}}
\examples{
countGraphs(10,3) # 176, the number of possible parent sets for each node.
10*countGraphs(10,3) # 1760, the total number of possible networks.
}
