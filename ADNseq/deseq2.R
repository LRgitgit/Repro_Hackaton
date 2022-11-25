library(DESeq2)

#/ simply skip the first line which contains the command line used:
featurecounts <- read.delim("matrix.txt", header = TRUE, skip = 1)

#/ the first column right of Length is where the counts start, until the end of the matrix
column.from = which(colnames(featurecounts) == "Length") + 1
column.end  = ncol(featurecounts)

#/ colData, this you need to modify to match your experimental design, I have four samples here with two groups
coldata = data.frame(id = c(colnames(featurecounts[7:14])), Condition = c("Mutant", "Mutant", "Mutant", "WT", "WT", "WT", "WT", "WT"), stringsAsFactors = TRUE)

dds <- DESeqDataSetFromMatrix(countData = featurecounts[, column.from:column.end], colData = coldata, design = ~Condition)

#/ add gene names to dds
rownames(dds) <- featurecounts$Geneid

dds_tumour_type = varianceStabilizingTransformation(dds, blind = FALSE, fitType = "parametric")

#print(dds_tumour_type)

save(dds, file = "dds.Rdata")
save(dds_tumour_type, file = "dds_tumour_type.Rdata")


dds_processed <- DESeq(dds)

dds_printable = results(dds_processed, alpha=0.05)

print(dds_printable)
save(dds_printable, file = "dds_without_normalization.Rdata")
