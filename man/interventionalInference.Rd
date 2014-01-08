\name{interventionalInference}
\alias{interventionalInference}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Dynamic Bayesian Network inference with interventions.}
\description{This function performs exact Bayesian inference for dynamic Bayesian networks using microarray timecourse data. Several intervention models can be chosen to take into account the effect of inhibitors.}
\usage{
interventionalInference(y, X0, X1, Z, max.indeg,
  g = NULL, Sigma = NULL, inferParents = NULL, allowSelfEdges = TRUE,
  perfectOut = FALSE, fixedEffectOut = FALSE, mechanismChangeOut = FALSE,
  perfectIn = FALSE, fixedEffectIn = FALSE, mechanismChangeIn = FALSE,
  priorType = "uninformed", priorGraph = NULL, priorStrength = 3,
  fittedValues = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{y}{an \eqn{n} by \eqn{P} matrix filled with the response values, where \eqn{n} is the number of observations and \eqn{P} is the number of nodes.}
  \item{X0}{an \eqn{n} by \eqn{a} matrix - the part of the design matrix that is the same for all models. \eqn{a} is the number of parameters that are in all of the modesl.}
  \item{X1}{an \eqn{n} by \eqn{P} matrix - the part of the design matrix to undergo model selection. \code{colnames(X1)} provides the labels for the output.}
  \item{Z}{an \eqn{n} by \eqn{P} binary matrix. Entry \eqn{i,j} is one if node \eqn{j} is inhibited in sample \eqn{i}.}
  \item{max.indeg}{The maximum permitted in-degree for each node.}
  \item{g}{The constant \eqn{g} in Zellner's g-prior. Defaults to \eqn{n}.}
  \item{Sigma}{an \eqn{n} by \eqn{n} covariance matrix of the responses, divided by \eqn{\sigma^2}. Faster if not specified, in which case the identity matrix is assumed.}
  \item{inferParents}{a vector of node indices specifying which nodes to infer parents for. If omitted, parents are inferred for all nodes.}
  \item{allowSelfEdges}{Should self-edges be allowed?}
  \item{perfectOut}{Apply perfect-out interventions?}
  \item{fixedEffectOut}{Apply fixed-effect-out interventions?}
  \item{mechanismChangeOut}{Apply mechanism-change-out interventions? Note: cannot be applied with perfect interventions.}
  \item{perfectIn}{Apply perfect-in interventions?}
  \item{fixedEffectIn}{Apply fixed-effect-in interventions?}
  \item{mechanismChangeIn}{Apply mechanism-change-in interventions? Note: cannot be applied with perfect interventions.}
  \item{priorType}{One of \code{"uninformed"}, \code{"Mukherjee"} and \code{"Hamming"}. In the structural Hamming distance prior, each difference from the edges in \code{priorGraph}
  incurs a prior penalty of \code{exp(-priorStrength)}. In the Mukherjee-Speed prior, adding edges from outside \code{priorGraph} earns the same penalty as before, but if a prior edge is omitted a penalty is no longer incurred.}
  \item{priorGraph}{A \eqn{P} by \eqn{P} binary matrix specifying the prior graph. If \eqn{(i,j)=1} then node \eqn{i} influences node \eqn{j}. If omitted, an uninformed prior is used.}
  \item{priorStrength}{The prior strength parameter. Ignored (but don't set it to NA) if \code{priorGraph} is \code{NULL}. If specified as a vector then the value from that gives the highest marginal likelihood is chosen (Empirical Bayes).}
  \item{fittedValues}{Perform a second pass to calculate the fitted values?}
}
\value{
  \item{pep}{A \eqn{P} by \eqn{P} matrix of posterior probabilities, where element \eqn{(i,j)} gives the posterior probability that node \eqn{i} influences node \eqn{j}.}
  \item{MAP}{A \eqn{P} by \eqn{P} binary matrix giving the maximum a posteriori network.}
  \item{parentSets}{A \code{countGraphs(P,max.indeg)} by \eqn{P} binary matrix, where element \eqn{(m,p}=1) iff node \eqn{i} is a parent in model \eqn{m}.}
  \item{ll}{A \code{countGraphs(P,max.indeg)} by \eqn{P} matrix, where element \eqn{(m,p)} gives the log-likelihood for model \eqn{m} for node \eqn{p}.}
  \item{lpost}{A \code{countGraphs(P,max.indeg)} by \eqn{P} matrix, where element \eqn{(m,p)} gives the log-posterior probability for model \eqn{m} for node \eqn{p}.}
  \item{MAPprob}{A \eqn{P} vector where element \eqn{p} gives the posterior probability of the maximum a posteriori model for node \eqn{p}.}
  \item{MAPmodel}{A \eqn{P} vector where element \eqn{p} gives the index of the maximum a posterior model for node \eqn{p} (between 1 and \code{countGraphs(P,max.indeg)}.}
  \item{marginal.likelihood}{A \eqn{P} by \code{length(priorStrength)} matrix that gives the marginal likelihood for each node.}
  \item{ebPriorStrength}{Value of \code{priorStrength} with the largest marginal likelihood, if \code{priorStrength} is a vector; \code{NULL} otherwise.}
  \item{yhat}{The posterior expected fitted values, if \code{fittedValues} is TRUE.}
  \item{inputs}{A list containing the inputs to \code{interventionalInference}} 
}
\details{
This function performs interventional inference with both -in and -out forms of the interventions. The targets of the interventions are specified in the matrix \code{Z}.
This assumes that each node is the target of only one intervention - if this is not the case, you must use the \code{\link{interventionalInferenceAdvanced}} function.
Certain combinations of interventions do not work together, in particular mixtures of perfect and mechanism change interventions. Perfect-in and perfect-out can be used together.
Mechanism-change-in and mechanism-change-out could potentially be used together, but are not currently implemented.}
\references{
Spencer, S.E.F, Hill, S.M. and Mukherjee, S. (2012) Dynamic Bayesian networks for interventional data. CRiSM pre-print 12-24.\cr
Mukherjee, S. and Speed, T.P. Network inference using informative priors. Proc. Nat. Acad. Sci. USA, 105, 14313-14318.
}
\author{Simon Spencer}
\seealso{\code{\link{interventionalDBN-package}}, \code{\link{formatData}}}
\examples{
library(interventionalDBN)
data(interventionalData)# loads interventionalData.
# Load your own data spreadsheet using myData<-read.csv("myDataFile.csv").

# Format the data for network inference
d<-formatData(interventionalData)

# Perform network inference without modelling interventions.
myNetwork0<-interventionalInference(d$y,d$X0,d$X1,max.indeg=3,fittedValues=TRUE)

# EGFRi is active in conditions 2 and 4, AKTi is active in conditions 3 and 4.
# Each condition has 8 timepoints.
Z<-matrix(0,32,15)
Z[9:16,1]<-1 # EGFR (node 1) is inhibited in condition 2
Z[25:32,1]<-1 # EGFR (node 1) is inhibited in condition 4
Z[17:24,8]<-1 # AKT (node 8) is inhibited in condition 3
Z[25:32,8]<-1 # AKT (node 8) is inhibited in condition 4

# Perform network inference with perfect-out and fixed-effect-out interventions.
myNetwork1<-interventionalInference(d$y,d$X0,d$X1,Z,max.indeg=3,
  perfectOut=TRUE,fixedEffectOut=TRUE)

# Perform network inference on with mechanism-change-out interventions.
myNetwork2<-interventionalInference(d$y,d$X0,d$X1,Z,max.indeg=3,
  mechanismChangeOut=TRUE)

# Perform network inference with Mukherjee Prior that prefers to omit self-edges.
myNetwork3<-interventionalInference(d$y,d$X0,d$X1,Z,max.indeg=3,
  perfectOut=TRUE,fixedEffectOut=TRUE,
  priorType="Mukherjee",priorGraph=matrix(1,15,15)-diag(rep(1,15)),priorStrength=2)
# Compare with self-edge peps with myNetwork1
diag(myNetwork1$pep)-diag(myNetwork3$pep)

# Perform network inference with Hamming Prior that prefers self-edges,
# and use Empirical Bayes to choose the priorStrength.
myNetwork4<-interventionalInference(d$y,d$X0,d$X1,Z,max.indeg=3,
  perfectOut=TRUE,fixedEffectOut=TRUE,
  priorType="Hamming",priorGraph=diag(rep(1,15)),priorStrength=0:10/2)
# You should always check to see if the Empirical Bayes appears to be working.
plotMaxML(myNetwork4)

# Now let's try using using the gradients as the response.
# Note that we have to tranfser Sigma this time, as it is no longer the identity.
d<-formatData(interventionalData,gradients=TRUE,initialIntercept=FALSE)
# There are now only 28 observations
Z<-Z[c(2:8,10:16,18:24,26:32),]

# Perform network inference on gradients with perfect-in interventions.
myNetwork5<-interventionalInference(d$y,d$X0,d$X1,Z,max.indeg=3,
  Sigma=d$Sigma,perfectIn=TRUE,fittedValues=TRUE)
  
# Perform network inference on gradients with perfect-in and -out plus fixed-effect out.
myNetwork6<-interventionalInference(d$y,d$X0,d$X1,Z,max.indeg=3,
  Sigma=d$Sigma,perfectIn=TRUE,perfectOut=TRUE)
}
