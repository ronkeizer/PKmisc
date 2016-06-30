#' Percentile height for age for children
#'
#' Based on tables from WHO: http://www.who.int/childgrowth/standards/height_for_age/en/
#'
#' @param age age in years
#' @param sex either `male` or `female`
#' @param height height in kg. Optional, if specified, will calculate closest percentile and return in list as `percentile`
#' @param ... parameters passed to `read_who_table()`
#' @export
pct_height_for_age <- function(age = NULL, height = NULL, sex = NULL, ...) {
  pct <- pct_for_age_generic(age = age, value = height, sex = sex, variable = "height", ...)
  return(pct)
}
