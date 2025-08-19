## -----------------------------------------------------------------------------
# load the packages
library(Kendall)
library(tbea)

# load the data
data(andes)
andes <- andes$ages

# remove missing data
andes <- andes[complete.cases(andes)]

# remove outliers
andes <- sort(andes[which(andes < 10)])
gapsizes <- sapply(2:length(andes), FUN=function(x) andes[x] - andes[x-1])

# run the Mann-Kendall test 
MannKendall(gapsizes)

## -----------------------------------------------------------------------------
# calculate the older theta that is an extension beyond
# the oldest (first from past to present) occurrence
# using the method Strauss-Sadler89
stratCI(times=andes, method="Strauss-Sadler89",
        nparams="one.par", C=0.95, endpoint="first")

# calculate the lower and upper bounds on the confidence interval with a quantile 0.8
stratCI(times=andes, method="Marshall94",
        confidence=0.95, quantile=0.8)

stratCI(times=andes, method="Marshall94",
        confidence=0.95, quantile=0.95)

## -----------------------------------------------------------------------------
# calculate the confidence interval on the oldest time using the
# Strauss-Sadler89 method
straussSadlerAndes <- stratCI(times=andes, method="Strauss-Sadler89",
                              nparams="one.par", C=0.95, endpoint="first")

# calculate the confidence interval under the distribution-free approach
marshallAndes <- stratCI(times=andes, method="Marshall94",
                         confidence=0.95, quantile=0.8)

# plot the estimations
hist(andes, probability=TRUE,
     col=rgb(red=0, green=0, blue=1, alpha=0.3),
     xlim=c(0, 10), main="CIs based on stratigraphic intervals",
     xlab="Age (Ma)")

# plot the lines  for the classical CI estimator of Strauss and Sadler
arrows(x0=straussSadlerAndes["maxObs"], y0=0.025,
       x1=straussSadlerAndes["maxEst"], y1=0.025,
       code=3, angle=90, length=0.1, lwd=3, col="darkblue")

# plot the lines for the CI estimator of Marshall 94
arrows(x0=marshallAndes[1], y0=0.05,
       x1=marshallAndes[2], y1=0.05,
       code=3, angle=90, length=0.1, lwd=3, col="darkgreen")

# plot a legend
legend(x="topright", legend=c("Strauss and Sadler \'89", "Marshall \'94"),
       col=c("darkblue", "darkgreen"), lty=1, lwd=3)

