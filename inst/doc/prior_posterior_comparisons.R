## -----------------------------------------------------------------------------
# load the package
library(tbea)

# crossplot operates over files or dataframes. Let's create
# two dataframes to exemplified the desirable structure of input data

log1 <- data.frame(sample=seq(from=1, to=10000, by = 100),
                   node1=rnorm(n =100, mean=41, sd=0.5),
                   node2=rnorm(n =100, mean=50, sd=1),
                   node3=rnorm(n =100, mean=25, sd=1))
 
log2 <- data.frame(sample=seq(from=1, to=10000, by = 100),
                   node1=rnorm(n =100, mean=41, sd=0.2),
                   node2=rnorm(n =100, mean=50, sd=0.8),
                   node3=rnorm(n =100, mean=25, sd=0.5))

head(log1)

# run crossplot over nodes 1 and 2 using 'idx.cols' instead of 'pattern', and
# plot the mean instead of the median.
crossplot(log1, log2,
          idx.cols=c(2,3),
          stat="mean",
          bar.lty=1,
          bar.lwd=1,
          identity.lty=2,
          identity.lwd=1,
          extra.space=0.5,
          main="My first crossplot",
          xlab="log 1",
          ylab="log 2",
          pch=19)

# now, load empirical data
data(cynodontidae.prior)
data(cynodontidae.posterior)

# as crossplot operates also over files, let's create temporal
# files for illustration
write.table(cynodontidae.prior, "prior.tsv",
            row.names=FALSE, col.names=TRUE, sep="\t")

write.table(cynodontidae.posterior, "posterior.tsv",
            row.names=FALSE, col.names=TRUE, sep="\t")

# crossplot
crossplot(log1="prior.tsv",
          log2="posterior.tsv",
          stat="median",
          skip.char="#",
          pattern="mrca.date",
          bar.lty=1,
          bar.lwd=2,
          identity.lty=2,
          identity.lwd=2,
          main="Prior-posterior comparison\nCynodontidae",
          xlab="Prior node age (Ma)",
          ylab="Posterior node age (Ma)",
          pch=20, cex=2, col="blue2")

## -----------------------------------------------------------------------------
# integrate the area under the curve
measureSimil(d1=cynodontidae.prior$mrca.date.backward.Hydrolycus.,
             d2=cynodontidae.posterior$mrca.date.backward.Hydrolycus.,
             ylim=c(0, 5),
             xlab="Age (Ma)",
             ylab="Density",
             main="Similarity between prior and posterior\nof the node Hydrolycus")

# file cleanup
file.remove("prior.tsv")
file.remove("posterior.tsv")

