## -----------------------------------------------------------------------------
# load the package
library(tbea)

# load the data
data(andes)
ages <- andes$ages
ages <- ages[complete.cases(ages)] # remove NAs
ages <- ages[which(ages < 10)] # remove outliers

# Draper-Smith, OLS
draperSmithNormalX0 <- xintercept(x=ages, method="Draper-Smith",
                                  alpha=0.05, robust=FALSE)

# Draper-Smith, Robust fit
draperSmithRobustX0 <-xintercept(x=ages, method="Draper-Smith",
                                 alpha=0.05, robust=TRUE)

# bootstrap, OLS
bootstrapNormalX0 <- xintercept(x=ages, method="Bootstrap",
                                p=c(0.025, 0.975), robust=FALSE)

# bootstrap, Robust fit
bootstrapRobustX0 <- xintercept(x=ages, method="Bootstrap",
                                p=c(0.025, 0.975), robust=TRUE)

# plot the estimations
hist(ages, probability=TRUE,
     col=rgb(red=0, green=0, blue=1, alpha=0.3),
     xlim=c(0, 10), main="CDF-based on confidence intervals",
     xlab="Age (Ma)")

# plot the lines for the estimator of Draper and Smith using lm
arrows(x0=draperSmithNormalX0$ci["upper"], y0=0.025,
       x1=draperSmithNormalX0$ci["lower"], y1=0.025,
       code=3, angle=90, length=0.1, lwd=3, col="darkblue")

# plot the lines for the estimator of Draper and Smith using rfit
arrows(x0=draperSmithRobustX0$ci["upper"], y0=0.05,
       x1=draperSmithRobustX0$ci["lower"], y1=0.05,
       code=3, angle=90, length=0.1,
       lwd=3, col="darkgreen")

# plot the lines for the estimator based on bootstrap
arrows(x0=bootstrapRobustX0$ci["upper"], y0=0.075,
       x1=bootstrapRobustX0$ci["lower"], y1=0.075,
       code=3, angle=90, length=0.1,
       lwd=3, col="darkred")

# plot a legend
legend(x="topright", legend=c("Draper and Smith with lm",
                              "Draper and Smith with rfit",
                              "Bootstrap on x0"),
       col=c("darkblue", "darkgreen", "darkred"),
       lty=1, lwd=3)

