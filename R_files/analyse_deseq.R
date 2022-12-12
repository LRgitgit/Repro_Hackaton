library(DESeq2)

#/ simply skip the first line which contains the command line used:
featurecounts <- read.delim("Counts/count_matrix.txt", header = TRUE, skip = 1)

#/ the first column right of Length is where the counts start, until the end of the matrix
column.from = which(colnames(featurecounts) == "Length") + 1
column.end  = ncol(featurecounts)

#/ colData, this you need to modify to match your experimental design, I have four samples here with two groups
coldata = data.frame(id = c(colnames(featurecounts[7:14])), Condition = c("Mutant", "Mutant", "Mutant", "WT", "WT", "WT","WT", "WT"), stringsAsFactors = TRUE)

dds <- DESeqDataSetFromMatrix(countData = featurecounts[, column.from:column.end], colData = coldata, design = ~Condition)

#/ add gene names to dds
rownames(dds) <- featurecounts$Geneid

#/ Process standard analysis with DESeq() and save the results
dds_processed <- DESeq(dds)

dds_printable = results(dds_processed, alpha=0.05)

save(dds_printable, file = "R_files/dds_printable.Rdata")
 
print(dds_printable)
print(na.omit(dds_printable))
