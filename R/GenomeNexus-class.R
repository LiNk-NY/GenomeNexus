.api_header <- function(x) x@api_header

#' @importFrom methods new
.GenomeNexus <- setClass(
    "GenomeNexus",
    contains = "Service",
    slots = c(api_header = "character")
)

#' @importFrom AnVIL operations
#' @importFrom methods callNextMethod
#' @exportMethod operations
setMethod(
    "operations", "GenomeNexus",
    function(x, ..., .deprecated = FALSE)
{
    callNextMethod(
        x, .headers = .api_header(x), ..., .deprecated = .deprecated
    )
})
