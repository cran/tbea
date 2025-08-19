## -----------------------------------------------------------------------------
# load the package
library(tbea)

# we need to substract the minimum to each quantile
# to offset later
findParams(q=c(40.94-40.94, 41.27-40.94, 41.60-40.94),
           p=c(0.0,  0.50, 0.975),
           output="complete",
           pdfunction="plnorm",
           params=c("meanlog", "sdlog"),
           initVals=c(1,1))

## -----------------------------------------------------------------------------
plot(lognormalBeast(-1.1085098, 0.3538003, meanInRealSpace=FALSE,
                    offset=40.94, from=0, to=4),
     type="l", lwd=2, main="Node calibration for Hydrolycus",
     xlab="Time (Ma)")

## -----------------------------------------------------------------------------
findParams(q=c(40.94-40.94, 41.60-40.94),
           p=c(0.0,  0.975),
           output="complete",
           pdfunction="pexp",
           params=c("rate"),
           initVals=c(1))

# plot the calibration density
curve(dexp((x-40.94), rate=5.589202), from=40.94, to=43,
      main="Node calibration for Hydrolycus",
      xlab="Time (Ma)", ylab="Density")


