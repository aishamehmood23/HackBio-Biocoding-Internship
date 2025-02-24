# Stage-2 Task

# Transcriptomics data interpretation and visualization
# Import data
url <- "https://gist.githubusercontent.com/stephenturner/806e31fce55a8b7175af/raw/1a507c4c3f9f1baaa3a69187223ff3d3050628d4/results.txt"
data <- read.table(url, header = TRUE, sep=" ")

# View data and summary statistics
head(data)
dim(data)
str(data)
sapply(data, class)

# Compute the -log10 transformation of p-value for the volcano plot
data$logP <- -log10(data$pvalue)

# Generating volcano plot using base R plot() function
plot(data$log2FoldChange, data$logP,  # Scatter plot with log2 fold change on x-axis and -log10 p-value on y-axis
     pch = 19,                        # Use solid circle points
     xlab = "log2(FoldChange)",       # Label for x-axis
     ylab = "-log10(P-value)",        # Label for y-axis
     col = ifelse(data$log2FoldChange > 1 & data$logP > 2, "red", # (-log10(0.01) = 2), Assign colors based on significance criteria
                  ifelse(data$log2FoldChange < -1 & data$logP > 2, "darkblue", "grey")), # Color downregulated genes blue, others grey
     xlim = c(-3, 3)                  # Set x-axis range from -3 to 3
     ) 

# Add horizontal and vertical threshold lines
abline(v = c(-1,1), col = "black", lty = 2)       # Dashed vertical lines at log2FC = -1 and 1
abline(h = -log10(0.01), col = "black", lty = 2)  # Dashed horizontal line at p-value threshold of 0.01

legend("topright",
       legend = c("Upregulated", "Downregulated"), 
       col = c("red", "darkblue"), 
       pch = 19)

# Extract significantly upregulated genes (log2FoldChange > 1 and p-value < 0.01)
upregulated_genes <- data[data$log2FoldChange > 1 & data$logP > 2,]

# Sort upregulated genes by significance (-log10 p-value) in descending order
top_upregulated_genes <- upregulated_genes[order(-upregulated_genes$logP),]
head(top_upregulated_genes, 5)

# Extract significantly downregulated genes (log2FoldChange < -1 and p-value < 0.01)
downregulated_genes <- data[data$log2FoldChange < -1 & data$logP > 2,]
top_downregulated_genes <- downregulated_genes[order(-downregulated_genes$logP),]
head(top_downregulated_genes, 5)

# Add Gene Labels for Top 5 upregulated genes
text(top_upregulated_genes$log2FoldChange[1:5], top_upregulated_genes$logP[1:5], 
     labels = top_upregulated_genes$Gene[1:5], cex = 0.45, pos = 3, col = "red")

# Add Gene Labels for Top 5 downregulated genes
text(top_downregulated_genes$log2FoldChange[1:5], top_downregulated_genes$logP[1:5], 
     labels = top_downregulated_genes$Gene[1:5], cex = 0.45, pos = 3, col = "darkblue")

# Upregulated Genes Functions, source: www.genecards.org
# EMILIN2: anchoring smooth muscle cells to elastic fibers.
# POU3F4: transcription factor with primary action during early neural development.
# LOC285954: an RNA Gene, and is affiliated with the lncRNA class. Diseases associated include Glioma Susceptibility 1 and Gastric Cancer.
# VEPH1: results in impaired TGF-beta signaling.
# DTHD1: encodes a protein which contains a death domain. Death domain-containing proteins function in signaling pathways as well as in apoptosis pathway.

# Downregulated Genes Functions, source: www.genecards.org
# TBX5: involved in heart development and limb pattern formation.
# LAMA2: mediates the attachment, migration, and organization of cells into tissues during embryonic development.
# CAV2: involved in essential cellular functions, and may function as a tumor suppressor.
# IFITM1: the protein encoded by this gene restricts cellular entry by diverse viral pathogens, such as influenza A virus, Ebola virus and Sars-CoV-2.
# TNN: in tumors, stimulates angiogenesis by elongation, migration and sprouting of endothelial cells.
