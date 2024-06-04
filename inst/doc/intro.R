## ----echo = FALSE-------------------------------------------------------------
library(tbea)

## -----------------------------------------------------------------------------
tbea::findParams(q = c(1, 5.5, 10),
          p = c(0.025,  0.50, 0.975),
          output = "complete",
          pdfunction = "plnorm",
          params = c("meanlog", "sdlog"))

## -----------------------------------------------------------------------------
lnvals <- tbea::lognormalBeast(M = 1, S = 1, meanInRealSpace = TRUE, from = 0, to = 10)
plot(lnvals, type = "l", lwd = 3)

## -----------------------------------------------------------------------------
set.seed(1985)
colors <- c("red", "blue", "lightgray")
below <- tbea::measureSimil(d1 = rnorm(1000000, mean = 3, 1),
                       d2 = rnorm(1000000, mean = 0, 1),
                       main = "Partial similarity",
                       colors = colors)
legend(x = "topright", legend = round(below, digits = 2))

## -----------------------------------------------------------------------------
data(laventa)
hondaIndex <- which(laventa$elevation == 56.4 | laventa$elevation == 675.0) 
mswd.test(age = laventa$age[hondaIndex], sd = laventa$one_sigma[hondaIndex])

## -----------------------------------------------------------------------------
twoLevelsIndex <- which(laventa$sample == "JG-R 89-2" | laventa$sample == "JG-R 88-2")
dataset <- laventa[twoLevelsIndex, ]
# Remove the values 21 and 23 because of their abnormally large standard deviations
tbea::mswd.test(age = dataset$age[c(-21, -23)], sd = dataset$one_sigma[c(-21, -23)])

