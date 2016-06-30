#' Check if values in vector are empty
#'
#' @param x vector
#' @export
is.nil <- function(x) {
  return(any(c(is.null(x), length(x) == 0, x == "")))
}

#' Convert inch to cm
#'
#' @param inch vector
#' @export
inch2cm <- function(inch) {
  return(inch*2.54)
}

#' Convert cm to inch
#'
#' @param cm vector
#' @export
cm2inch <- function(cm) {
 return(cm/2.54)
}
