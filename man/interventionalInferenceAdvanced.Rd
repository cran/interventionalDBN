\name{interventionalInferenceAdvanced}
\alias{interventionalInferenceAdvanced}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Dynamic Bayesian Network inference with interventions.}
\description{This function performs exact Bayesian inference for dynamic Bayesian networks using microarray timecourse data. Several intervention models can be chosen to take into account the effect of inhibitors.}
\usage{
interventionalInferenceAdvanced(y, X0, X1, cond, inhibition, inhibitors, max.indeg,
  g = NULL, Sigma = NULL, inferParents = NULL, allowSelfEdges = TRUE,
  perfect = FALSE, fixedEffect = FALSE, mechanismChange = FALSE,
  priorType = "uninformed", priorGraph = NULL, priorStrength = 3,
  fittedValues = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{y}{an \eqn{n} by \eqn{P} matrix filled with the response values, where \eqn{n} is the number of observations and \eqn{P} is the number of nodes.}
  \item{X0}{an \eqn{n} by \eqn{a} matrix - the part of the design matrix that is the same for all models. \eqn{a} is the number of parameters that are in all of the modesl.}
  \item{X1}{an \eqn{n} by \eqn{P} matrix - the part of the design matrix to undergo model selection. \code{colnames(X1)} provides the labels for the output.}
  \item{cond}{an \eqn{n} by \eqn{1} matrix giving the experimental condition number of each sample. Filled with integers from 1 to the number of different conditions.}
  \item{inhibition}{a \eqn{conditions} by \eqn{inhibitors} binary matrix, where element \eqn{(c,i)} is one iff inhibitor \eqn{i} is active in condition \eqn{c}.}
  \item{inhibitors}{an \eqn{inhibitors} by \eqn{P} binary matrix, where element \eqn{(i,p)} is one iff inhibitor \eqn{i} affects node \eqn{p}.}
  \item{max.indeg}{The maximum permitted in-degree for each node.}
  \item{g}{The constant \eqn{g} in Zellner's g-prior. Defaults to \eqn{n}.}
  \item{Sigma}{an \eqn{n} by \eqn{n} covariance matrix of the responses, divided by \eqn{\sigma^2}. Faster if not specified, in which case the identity matrix is assumed.}
  \item{inferParents}{a vector of node indices specifying which nodes to infer parents for. If omitted, parents are inferred for all nodes.}
  \item{allowSelfEdges}{Should self-edges be allowed?}
  \item{perfect}{Apply perfect-out interventions?}
  \item{fixedEffect}{Apply fixed-effect-out interventions?}
  \item{mechanismChange}{Apply mechanism-change-out interventions? Note: cannot be applied with perfect interventions.}
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
  \item{inputs}{A list containing the inputs to \code{interventionalInferenceAdvanced}} 
}
\details{
The function \code{\link{interventionalInference}} provides a simpler, but less general way of coding which inhibitors are active in each condition. 
Currently this advanced version only supports -out forms of the interventions.
By default the fixed effects in the fixedEffect intervention are assumed to be additive in samples with multiple inhibitors.
However if you do not wish for this to be the case, then you can simply define a dummy inhibitor for each combination of inhibitors and a new fixed effect parameter will be estimated.
See example 7 below.}
\references{
Spencer, S.E.F, Hill, S.M. and Mukherjee, S. (2012) Dynamic Bayesian networks for interventional data. CRiSM pre-print 12-24.\cr
Mukherjee, S. and Speed, T.P. Network inference using informative priors. Proc. Nat. Acad. Sci. USA, 105, 14313-14318.
}
\author{Simon Spencer}
\seealso{\code{\link{interventionalDBN-package}}, \code{\link{interventionalInference}}, \code{\link{formatData}}}
\examples{
library(interventionalDBN)
data(interventionalData)# loads interventionalData.
# Load your own data spreadsheet using myData<-read.csv("myDataFile.csv").

# Format the data for network inference
d<-formatData(interventionalData)

# Perform network inference without modelling interventions.
myNetwork0<-interventionalInferenceAdvanced(d$y,d$X0,d$X1,max.indeg=3,fittedValues=TRUE)

# EGFRi is active in conditions 2 and 4, AKTi is active in conditions 3 and 4.
myInhibition<-cbind(c(0,1,0,1),c(0,0,1,1))
myInhibitors<-matrix(0,2,15)
myInhibitors[1,1]<-1 # EGFRi targets EGFR (node 1).
myInhibitors[2,8]<-1 # AKTi targets AKT (node 8).

# Perform network inference with perfect and fixed effect interventions.
myNetwork1<-interventionalInferenceAdvanced(d$y,d$X0,d$X1,d$cond,max.indeg=3,
  inhibition=myInhibition,inhibitors=myInhibitors,perfect=TRUE,fixedEffect=TRUE)

# Perform network inference on with mechanism change interventions.
myNetwork2<-interventionalInferenceAdvanced(d$y,d$X0,d$X1,d$cond,max.indeg=3,
  inhibition=myInhibition,inhibitors=myInhibitors,mechanismChange=TRUE)

# Perform network inference with Mukherjee Prior that prefers to omit self-edges.
myNetwork3<-interventionalInferenceAdvanced(d$y,d$X0,d$X1,d$cond,max.indeg=3,
  inhibition=myInhibition,inhibitors=myInhibitors,perfect=TRUE,fixedEffect=TRUE,
  priorType="Mukherjee",priorGraph=matrix(1,15,15)-diag(rep(1,15)),priorStrength=2)
# Compare with self-edge peps with myNetwork1
diag(myNetwork1$pep)-diag(myNetwork3$pep)

# Perform network inference with Hamming Prior that prefers self-edges,
# and use Empirical Bayes to choose the priorStrength.
myNetwork4<-interventionalInferenceAdvanced(d$y,d$X0,d$X1,d$cond,max.indeg=3,
  inhibition=myInhibition,inhibitors=myInhibitors,perfect=TRUE,fixedEffect=TRUE,
  priorType="Hamming",priorGraph=diag(rep(1,15)),priorStrength=0:10/2)
# You should always check to see if the Empirical Bayes appears to be working.
plotMaxML(myNetwork4)

# Now let's try using using the gradients as the response.
# Note that we have to tranfser Sigma this time, as it is no longer the identity.
d<-formatData(interventionalData,gradients=TRUE,initialIntercept=FALSE)

# Perform network inference on gradients with perfect-out interventions.
myNetwork5<-interventionalInferenceAdvanced(d$y,d$X0,d$X1,d$cond,max.indeg=3,
  Sigma=d$Sigma,inhibition=myInhibition,inhibitors=myInhibitors,perfect=TRUE)

# So far we have assumed that the fixed effects are additive in EGFRi+AKTi.
# Now let's change this, by coding EGFRi+AKTi as a separate inhibitor.
d<-formatData(interventionalData)
# EGFRi+AKTi is active in condition 4.
myInhibition<-cbind(c(0,1,0,0),c(0,0,1,0),c(0,0,0,1))
myInhibitors<-matrix(0,3,15)
myInhibitors[1,1]<-1 # EGFRi targets EGFR (node 1).
myInhibitors[2,8]<-1 # AKTi targets AKT (node 8).
myInhibitors[3,c(1,8)]<-1 # EGFRi+AKTi targets both.

# Perform network inference on gradients with fixed effect interventions.
myNetwork7<-interventionalInferenceAdvanced(d$y,d$X0,d$X1,d$cond,max.indeg=3,
  inhibition=myInhibition,inhibitors=myInhibitors,fixedEffect=TRUE)
}
