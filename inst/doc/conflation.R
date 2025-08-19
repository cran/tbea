## -----------------------------------------------------------------------------
# load the package
library(tbea)

# calculate the conflation and plot it
# mind the double quotes which must be used when specifying each distribution
# and the single quotes when specifying the distribution function name
conflate(c("density_fun(x, 'dnorm', mean=10, sd=1)",
           "density_fun(x, 'dnorm', mean=13, sd=0.5)",
           "density_fun(x, 'dnorm', mean=14.4, sd=1.7)"),
         from=0, to=20, n=101, add=FALSE, plot=TRUE)

# plot the individual distributions
curve(density_fun(x, 'dnorm', mean=10, sd=1), add=TRUE, col="red")
curve(density_fun(x, 'dnorm', mean=13, sd=0.5), add=TRUE, col="blue")
curve(density_fun(x, 'dnorm', mean=14.4, sd=1.7), add=TRUE, col="green4")

# legend
legend(x="topleft", lty=1,
       legend=c("Normal(10,1)",
                "Normal(13,0.5)",
                "Normal(14.4,1.7)",
                "Conflation of normals"),
       col=c("red", "blue", "green4", "black"))

# save the conflation coordinates into an object without plotting
# then we can plot or use the xy values if desired
conflated_normals <- conflate(c("density_fun(x, 'dnorm', mean=0, sd=1)",
                                "density_fun(x, 'dnorm', mean=3, sd=1)"),
                              from=-4, to=4, n=101, plot=FALSE)
plot(conflated_normals)

## -----------------------------------------------------------------------------
# first, let's calculate the area under the curve,
# must be approximately 1.0 as it is itself a PDF
integrate(approxfun(conflated_normals), subdivisions=10000,
          lower=-4, upper=4)

# now, use 'quantile_conflation' to calculate quantiles
# for the conflated distribution
q1 <- quantile_conflation(p=0.025, data=conflated_normals,
                          output="quantile")
q2 <- quantile_conflation(p=0.5, data=conflated_normals,
                          output="quantile")
q3 <- quantile_conflation(p=0.975, data=conflated_normals,
                          output="quantile")

