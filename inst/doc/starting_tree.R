## -----------------------------------------------------------------------------
# load the packages
library(tbea)
library(ape)

# create a file with multiple trees in TNT format
writeLines(text=c("tread 'three arbitrary trees in TNT format'", 
                  "(Taxon_A ((Taxon_B Taxon_C)(Taxon_D Taxon_E)))*", 
                  "(Taxon_A (Taxon_B (Taxon_C (Taxon_D Taxon_E))))*", 
                  "(Taxon_A (Taxon_C (Taxon_B (Taxon_D Taxon_E))));", 
                  "proc-;"),
           con = "someTrees.tre")

# convert TNT to newick
tnt2newick(file="someTrees.tre", return=TRUE)

# cleanup after the example
file.remove("someTrees.tre")

## -----------------------------------------------------------------------------
# read tree with ape
tree <- read.tree(text="(Acestrorhynchus_falcirostris:0.1296555,
                        ((((Cynodon_gibbus:0.002334399,Cynodon_septenarius:0.00314063)
                        :0.07580842,((Hydrolycus_scomberoides:0.007028806,Hydrolycus_MUN_16211
                        :0.009577958):0.0225477,(Hydrolycus_armatus:0.002431794,
                        Hydrolycus_tatauaia:0.002788708):0.02830852):0.05110053)
                        :0.02656745,Hydrolycus_wallacei:0.01814363):0.1712442,
                        Rhaphiodon_vulpinus:0.04557667):0.1936416);")

# get the node IDs according to the mrca of pairs of appropriate
# species root
mrca(tree)["Acestrorhynchus_falcirostris", "Hydrolycus_armatus"]

# Hydrolycus sensu stricto (cf. Hydrolycus)
mrca(tree)["Hydrolycus_scomberoides", "Hydrolycus_armatus"]

# specify calibrations as a data frame
calibs <- data.frame(node=c(10, 15),
                     age.min=c(43, 40.94),
                     age.max=c(60, 41.6),
                     stringsAsFactors=FALSE)

# calibrate the tree with the information in calibs using ape
set.seed(15)
calibrated <- chronos(phy=tree, calibration=calibs)

# plot the calibrated tree
plot(calibrated, label.offset=1.2)
axisPhylo()

# fetch the plotted tree from the graphic environment
plttree <- get("last_plot.phylo", envir=.PlotPhyloEnv)

# process the node heights and reorder as needed
nodes <- cbind(plttree$xx, plttree$yy)
nodes <- nodes[c(10, 15),]
nodes <- cbind(nodes, calibs[, c("age.min", "age.max")])
colnames(nodes) <- c("x", "y", "min", "max")
nodes <- cbind(nodes, rev.min=-(nodes[, c("min")] - max(plttree$xx)))
nodes <- cbind(nodes, rev.max=-(nodes[, c("max")] - max(plttree$xx)))

# plot the original calibrations as error bars
arrows(x0=nodes[, "rev.max"], x1=nodes[, "rev.min"],
       y0=nodes[,"y"], y1=nodes[,"y"],
       angle=90, length=0.3, lwd=3,
       code=3, col="darkblue")

nodelabels()
tiplabels()

# write the tree
write.tree(phy=calibrated)

