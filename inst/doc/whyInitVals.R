## ----echo = FALSE-------------------------------------------------------------
findParamsPrototype <- function(q = c(-1.959964, 0.000000, 1.959964), p = c(0.025,  0.50, 0.975), output = "complete", densit="pnorm", params = c("mean", "sd"), initVals = rep(1, times = l)) {
    l <- length(params)
    cl <- vector("list", 2  + length(params))
    cl[[1]] <- as.name(densit)
    cl[[2]] <- q
    names(cl) <- c(NA, "q", params)
    mode(cl) <- "call"
    quadraticFun <- function(x) {
        cl[3:(l+2)] <- x
        res <- eval(cl)
        sum((res - p)^2)
    }    
    res <- optim(initVals, quadraticFun)
    if (output == "parameters") {
        return(res$par)
    }
    return(res)
}

## ----eval = TRUE, warning = FALSE---------------------------------------------
# X = seq... is the set of values to try, from min(q) to max(q). 
parameters <- sapply(X = seq(0.6915029, 0.9974714, length.out = 1000),
                     FUN = function(x) {
                         findParamsPrototype(q = c(0.6915029, 0.9330330, 0.9974714),
                                    p = c(0.025, 0.5, 0.975),
                                    densit = "pbeta",
                                    params = c("shape1", "shape2"),
                                    initVals = c(x, x))$par
                     },
                     simplify = TRUE)

plot(density(t(parameters)[, 1]), main = "Density for shape1", xlab = "Shape1", ylab = "Density")
abline(v = mean(parameters[1, ]), col = "red")

plot(density(t(parameters)[, 2]), main = "Density for shape2", xlab = "Shape2", ylab = "Density")
abline(v = mean(parameters[2, ]), col = "red")

## ----warning = FALSE----------------------------------------------------------
# check that quantiles are rigth:
qnorm(c(0.025, 0.5, 0.975), mean = 10, sd = 1)

# simulate the parameters
simInitVals <- seq(0.001, 10, length.out = 10000)
parameters2 <- sapply(X = simInitVals,
                     FUN = function(x) {
                         findParamsPrototype(q = c(8.040036, 10.000000, 11.959964),
                                    p = c(0.025, 0.5, 0.975),
                                    densit = "pnorm",
                                    params = c("mean", "sd"),
                                    initVals = c(x, x))$par
                     },
                     simplify = TRUE)

# plot the results
plot(y = parameters2[1,], x = simInitVals, main = "Estimates for the mean", xlab = "Simulated init. vals.", ylab = "Parameter estimate")
abline(h = 10, col = "red")

plot(y = parameters2[2,], x = simInitVals, main = "Estimates for the st.dev.", xlab = "Simulated init. vals.", ylab = "Parameter estimate")
abline(h = 1, col = "red")

## -----------------------------------------------------------------------------
meanNeighbors <- which(simInitVals > (mean(simInitVals) - 0.1) & simInitVals < (mean(simInitVals) + 0.1))

plot(y = parameters2[1,][meanNeighbors], x = simInitVals[meanNeighbors], main = "Neighbors of mean(quantiles)", xlab = "Simulated init. vals.", ylab = "Parameter estimate")
abline(h = 10, col = "red")

plot(y = parameters2[2,][meanNeighbors], x = simInitVals[meanNeighbors], main = "Neighbors of mean(quantiles)", xlab = "Simulated init. vals.", ylab = "Parameter estimate")
abline(h = 1, col = "red")

## -----------------------------------------------------------------------------
plot(density(parameters2[1,][meanNeighbors]), main = "Neighbors of mean(quantiles)", ylab = "Parameter estimate")
abline(v = 10, col = "red")

plot(density(parameters2[2,][meanNeighbors]), main = "Neighbors of mean(quantiles)", ylab = "Parameter estimate")
abline(v = 1, col = "red")

