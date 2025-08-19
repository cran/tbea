## ----fig.align="center", out.width="100%"-------------------------------------
# load the packages
library(ape)
library(tbea)

# these urls render correctly on html but not on pdf. The former is more important for CRAN.
# download the trees from the supplementary material of Ballen et al. (2022)
t1<-"https://raw.githubusercontent.com/gaballench/cynodontidaeWare/refs/heads/main/bayesian/mrbayes"
t2<-"https://raw.githubusercontent.com/gaballench/cynodontidaeWare/refs/heads/main/bayesian/mrbayes"

mtr1 <- read.nexus(paste(t1, "concatenatedMolmorph.nexus.run1.t", sep="/"))
mtr2 <- read.nexus(paste(t2, "concatenatedMolmorph.nexus.run2.t", sep="/"))

trees <- c(mtr1, mtr2)

# calculate topological frequencies
tpf <- topoFreq(trees, output="trees")

# summarize median branch length
sumtrees <- summaryBrlen(tpf$trees, method="median")

# sort the frequencies in decreasing order
decreasingIdx <- order(tpf$fabs, decreasing=TRUE)

# how many topologies comprise about 90% of the trees?
sum(cumsum(tpf$fabs[decreasingIdx])/sum(tpf$fabs)<0.9)

# plot these four trees with branch lengths already summarized
par(mfrow=c(2,2))
par(oma=c(0, 0, 0, 0))
par(mai=c(0.5, 0.2, 0.5, 0.2))
for(i in 1:4){
    plot(sumtrees[[decreasingIdx[i]]],
         type="unrooted",
         show.node.label=FALSE,
         cex=0.4,
         main=round(tpf$frel[decreasingIdx[i]], digits=2))
}

