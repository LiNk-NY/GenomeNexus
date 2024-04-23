setGeneric("getVariant", function(api, x) standardGeneric("getVariant"))

setMethod("getVariant", c("GenomeNexus", "GRanges"), function(api, x) {


})

# api$fetchVariantAnnotationByGenomicLocationGET
# genomicLocation = df$genomicLocation,
glNames <- c("chromosome", "start", "end", "referenceAllele", "variantAllele")

glNames2 <- c("chr", "startPosition", "endPosition", "referenceAllele", "variantAllele")

setMethod("getVariant", c("GenomeNexus", "ANY"), function(api, x) {
    x <- dplyr::rename(
        x,
        Chromosome = "chr",
        Start_Position = "startPosition",
        End_Position = "endPosition",
        Reference_Allele  = "referenceAllele",
        Tumor_Seq_Allele2 = "variantAllele"
    )
    oncoCode <- OncoTree::searchTypeQuery(
        "code", strsplit("acc_tcga", "_tcga")[[1]]
    )[["code"]]
    x$ONCOTREE_CODE <- oncoCode
    readr::write_delim(x, file = "~/test/acc_mutation_tab.txt", delim = "\t")

    results <- readr::read_delim("~/test/acc_mutation_result.txt", delim = "\t")

    write_delim(x, "~/data/variants.csv")

    x <- allmuts
    sub <- x[, glNames2]
    names(sub) <- glNames
    ll <- api$fetchVariantAnnotationByGenomicLocationPOST(
        genomicLocations = sub[1:2, ]
    ) |> httr::content()

    genomicLocation <- paste(
        x$chr, x$startPosition, x$endPosition,
        x$referenceAllele, x$variantAllele, sep = ","
    )
    api$fetchVariantAnnotationByGenomicLocationPOST(
        genomicLocations = genomicLocation
    )
})

if (FALSE) {

debugonce(cBioPortalData:::.portalExperiments)
cbio <- cBioPortalData::cBioPortal()

acc <- cBioPortalData::cBioPortalData(
    api = cbio, by = "hugoGeneSymbol", studyId = "acc_tcga",
    genePanelId = "IMPACT341", molecularProfileIds = "acc_tcga_mutations"
)
allmuts <- expers[["acc_tcga_mutations"]] |> as.data.frame()

save(allmuts, file = "~/data/allmuts.Rda")
load("~/data/allmuts.Rda")
x <- allmuts
}
