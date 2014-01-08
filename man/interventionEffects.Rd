\name{interventionEffects}
\alias{interventionEffects}
\title{Calculate interventional effects}
\description{
  This function assesses which nodes are downstream of the nodes that are the target of the interventions.
  The samples are assumed to be independent, and the difference between the inhibited and baseline concentrations is assumed to be Gaussian.
  This leads to a t-distribution for the mean difference across the timecourse.
}
\usage{interventionEffects(d, cellLine, baseline, inhibited)}
\arguments{
  \item{d}{A microarray spreadsheet, a \eqn{samples} by (4 + \eqn{P}) matrix, where \eqn{P} is the number of measurements for each sample.\cr
  Column 1 gives the cell line in each sample.\cr
  Column 2 gives the inhibitor used in each sample.\cr
  Column 3 gives the stimulus used in each sample.\cr
  Column 4 gives the time each sample was measured.}
  \item{cellLine}{The cell line to investigate (must match an entry in column 1 of \code{d}). Must be specified even if there is only one.}
  \item{baseline}{The baseline inhibition condition (must match an entry in column 2 of \code{d}).}
  \item{inhibited}{The active inhibition condition (must match an entry in column 2 of \code{d}).}
}
\details{
  The function performs a t-test for each stimuli seperately as well as for all the stimuli combined together,
  which may be less reliable because the assumptions are stronger.
}
\value{
  \item{n.differences}{A vector giving the number of differences used to calculate the t-statistic for each stimulus.}
  \item{t.statistics}{A vector of t-statistics for the stimuli separately.}
  \item{degrees.freedom}{The corresponding vector of degrees of freedom for each test.}
  \item{p.values}{The corresponding vector of p-values.}
  \item{heatmap.p.values}{The corresponding vector of \eqn{sign(T)(1-p)}.
  This can make a nice heatmap, as significant increases and significant decreases in concentration are at opposite ends of the scale.}
  \item{all.stim.t.statistic}{The t-statistic for the stimuli combined.}
  \item{all.stim.degrees.freedom}{The degrees of freedom for the stimuli combined.}
  \item{all.stim.p.values}{The p-value for the stimuli combined.}
  \item{all.stim.heatmap.p.values}{\eqn{sign(T)(1-p)} for all stimuli combined.}
}
%\references{}
\author{Simon Spencer}
\seealso{\code{\link{formatData}}, \code{\link{interventionalDBN-package}}}
\examples{
data(interventionalData)
effect1<-interventionEffects(interventionalData,1,"DMSO","EGFRi")
effect2<-interventionEffects(interventionalData,1,"DMSO","AKTi")
heats<-rbind(effect1$heatmap.p.values,effect2$heatmap.p.values)
image(heats, breaks=c(-1,-0.95,-0.9,0.9,0.95,1),
  col=c("red","darkred","black","darkgreen","green"),xaxt="n",yaxt="n",
  xlab="Green = up when inhibitor is present\nRed = down when inhibitor is present")
# Or use the package gplots for more colour graduation
#library("gplots")
#image(heats,breaks=c(-1,-0.999,-0.99,-0.975,-0.95,-0.9,0.9,0.95,0.975,0.99,0.999,1)
#  ,col=redgreen(11),xaxt="n",yaxt="n")
axis(1,0:1,c("EGFRi","AKTi"))
axis(2,0:14/14,colnames(effect1$p.values),las=1)
}
