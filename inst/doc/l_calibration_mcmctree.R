## -----------------------------------------------------------------------------
# load the package
library(tbea)

# estimate the c parameter for the L distribution
cparam <- c_truncauchy(tl=0.4094, tr=0.4160, p=0.001, pr=0.975, al=0.025)
cparam

## ----eval=FALSE, fig.align="center", out.width="55%"--------------------------
# # load the package
# library(mcmc3r)
# 
# # using the function dL to plot the L density
# curve(dL(x, tL=0.4094, p=0.001, c=cparam), from=0.4094, to=0.4160)

