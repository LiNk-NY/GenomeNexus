#' @export
GenomeNexus <- function(
    hostname = "www.genomenexus.org",
    protocol = "https",
    api. = "/v2/api-docs",
    token = character()
) {
    if (length(token))
        token <- .handle_token(token)

    apiUrl <- paste0(protocol, "://", hostname, api.)
    .GenomeNexus(
        Service(
            service = "GenomeNexus",
            host = hostname,
            config = httr::config(
                ssl_verifypeer = 0L, ssl_verifyhost = 0L, http_version = 0L
            ),
            authenticate = FALSE,
            api_reference_url = apiUrl,
            api_reference_md5sum = "8cf0867c71d3235551478b386f3f2cb8",
            api_reference_headers = token,
            package = "GenomeNexus",
            schemes = protocol
        ),
        api_header = token
    )
}
