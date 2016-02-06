#' @export
is.nil <- function(x) {
  return(any(c(is.null(x), length(x) == 0, x == "")))
}
