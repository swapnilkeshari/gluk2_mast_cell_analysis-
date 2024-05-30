library(biomaRt)
library(sleuth)
library(openxlsx)
library(ggplot2)
library(ggfortify)
library(dplyr)
library(matrixStats)
library(pheatmap)
library(VennDiagram)
library(stringr)
library(ReactomePA)
library(clusterProfiler)
library(WebGestaltR)
library(org.Mm.eg.db)
library(AnnotationDbi)
library(enrichplot)
library(tidyverse)
library(futile.logger)
# library(devtools)
# devtools::install_github("jishnu-lab/SLIDE")
library(SLIDE)

set.seed(1234)
yaml_path = "/ix/djishnu/Swapnil/kaplanAnalysis/final_analysis/slide_analysis/slide.yaml"
input_params <- yaml::yaml.load_file(yaml_path)

SLIDE::checkDataParams(input_params)
SLIDE::optimizeSLIDE(input_params, sink_file = TRUE)
SLIDE::plotCorrelationNetworks(input_params)
SLIDE::SLIDEcv(yaml_path, nrep = 100, k = 20)


# ORA_analysis <- function(gene_list,g1){
#   genes <- gene_list
#   entrez_genes <- bitr(genes, fromType = "SYMBOL", toType = "ENTREZID", OrgDb = "org.Mm.eg.db")

#   # Reactome pathway over-representation analysis
#   reactome <- enrichPathway(gene = entrez_genes$ENTREZID, organism = "mouse", pvalueCutoff=pvalueCutoff, readable=TRUE)
#   ORA[[paste0(g1, "_Reactome")]] <- reactome

#   # KEGG pathway over-representation analysis
#   kegg <- enrichKEGG(gene = entrez_genes$ENTREZID, organism = "mmu",  pvalueCutoff=pvalueCutoff, use_internal_data = FALSE)
#   kegg2 <- setReadable(kegg, OrgDb = "org.Mm.eg.db", keyType="ENTREZID")
#   kegg2@result$Description <- gsub(pattern = " - Mus musculus (house mouse)", replacement = "", kegg2@result$Description, fixed = T)    
#   ORA[[paste0(g1, "_KEGG")]] <- kegg2

#   for(a1 in names(ORA)){
#     reacORkegg <- ORA[[a1]]
#     if(nrow(reacORkegg) !=0){
#       # Create directories for each result
#       ORA_path <- file.path(cp_path, a1)
#       dir.create(ORA_path, recursive=TRUE)
#       ORA_df <- as.data.frame(reacORkegg)
#       # Convert 'GeneRatio' and 'BgRatio' from character to numeric
#       ORA_df$GeneRatio <- as.numeric( gsub("(\\d+)/(\\d+)", "\\1", ORA_df$GeneRatio, perl=T) ) / as.numeric(gsub("(\\d+)/(\\d+)", "\\2", ORA_df$GeneRatio, perl=T) )
#       ORA_df$BgRatio <- as.numeric( gsub("(\\d+)/(\\d+)", "\\1", ORA_df$BgRatio, perl=T) ) / as.numeric(gsub("(\\d+)/(\\d+)", "\\2", ORA_df$BgRatio, perl=T) )
#       # Now perform the division to create 'RatioOfRatios'
#       ORA_df <- transform(ORA_df, EnrichmentRatio = GeneRatio / BgRatio)
#       write.xlsx(ORA_df, file.path(ORA_path, paste0(a1, ".xlsx")))
      
#       # Plot enrichment result - dotplot
#       fit <- dotplot(reacORkegg, showCategory = 40)
#       ggsave(file.path(ORA_path, paste0(a1, "_dotplot.pdf")), plot = fit, dpi = 300, width = 15, height = 12, units = "in", device="pdf")
#       plots_list[[a1]] <- fit
#     }
    
#     if (nrow(reacORkegg) > 40){
#       # Weighted Set Cover of geneSets
#       weightedPath <- file.path(cp_path, "weightedSetCover", a1)
#       dir.create(weightedPath, recursive=TRUE)
      
#       setCoverNum = abs(0.40*(nrow(ORA_df)))
#       nThreads = 4
#       idsInSet <- sapply(ORA_df$geneID, strsplit, split="/")
#       names(idsInSet) <- ORA_df$ID    
#       minusLogP <- -log(ORA_df$pvalue)
#       minusLogP[minusLogP == Inf] <- -log(.Machine$double.eps)
#       wscRes <- weightedSetCover(idsInSet=idsInSet, costs=(1 / minusLogP), topN=setCoverNum, nThreads=nThreads)
      
#       wscRes_full <- ORA_df[c(match(wscRes$topSets, ORA_df$ID)),]
#       wscRes_full <- wscRes_full[order(wscRes_full$p.adjust), ]
#       write.xlsx(wscRes_full, file.path(weightedPath, paste0(a1, ".xlsx")))
      
#       # Plot enrichment result of weighted set cover - dotplot
#       reacORkegg2 <- reacORkegg
#       reacORkegg2@result <- wscRes_full
      
#       fit <- dotplot(reacORkegg2, showCategory = 20)
#       ggsave(file.path(weightedPath, paste0(a1, "_dotplot.pdf")), plot = fit, dpi = 300, width = 17, height = 12, units = "in", device="pdf")
#       plots_list[[paste0(a1, "weightSet")]] <- fit
#     }
#   }
# }

# pvalueCutoff <-0.05
# ORA <- list()
# plots_list <- list()

# for (d in input_params$delta){
#     for (l in  input_params$lambda){
#         out_path = paste0(input_params$out_path, '/', d, '_', l, '_', 'out/')
#         cp_path <- file.path(out_path, 'pathway_analysis_ORA')
#         dir.create(cp_path, recursive=TRUE)
#         file_list <- list.files(path = out_path, pattern = "^feature_list_.*\\.txt$")
#         combined_data <- data.frame()
#         for (file in file_list) {
#             temp_data <- read.table(file.path(out_path, file), header = TRUE, sep = "\t")
#             combined_data <- rbind(combined_data, temp_data)
            
#             feature_list <- unique(temp_data$name)
#             ORA_analysis(feature_list,paste0(file))
#         }
#         feature_list <- unique(combined_data$name)
#         ORA_analysis(feature_list,"slide_combined")
#     }
# }
