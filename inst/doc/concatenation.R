## ----eval=FALSE---------------------------------------------------------------
# # load the package
# library(tbea)
# 
# # navigate to the examples/concatenation directory in the package repository
# setwd("examples/concatenation")

## ----eval=FALSE---------------------------------------------------------------
# table2nexus(path="data/morpho.csv",
#             datatype="standard",
#             header=FALSE,
#             sep=",",
#             con="data/morpho.trimmed.nex")

## ----eval=FALSE---------------------------------------------------------------
# nexmatrices <- list.files(path="data", pattern=".nex", full.names=TRUE)
# concatNexus(matrices=nexmatrices,
#             filename="concatenatedMolmorph.nexus",
#             morpho=TRUE,
#             morphoFilename="data/morpho.trimmed.nex",
#             sumFilename="partitions.txt")
# 
# # also, we can provide a pattern and a path
# path <- "data"
# pattern <- "trimmed.nex$"
# concatNexus(pattern=pattern,
#             filename="concatenatedMolmorph.nexus",
#             path=path,
#             morpho=TRUE,
#             morphoFilename=paste(path, grep(pattern="morpho.",
#                                             x=dir(path, pattern), value=TRUE),
#                                  sep="/"),
#             sumFilename="partitions.txt")

