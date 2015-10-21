#' Add residual variability to data
#'
#' @param x data
#' @param ruv list with arguments prop, add
#' @export
add_ruv <- function (x, ruv) {
  return (x * (1 + rnorm(length(x), 0, ruv$prop)) + rnorm(length(x), 0, ruv$add))
}
