#' @export
is.nil <- function(x) {
  return(any(c(is.null(x), is.na(x), length(x) == 0, is.nan(x), x == "")))
}
