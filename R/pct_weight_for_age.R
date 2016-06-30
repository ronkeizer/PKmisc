#' Percentile weight for age for children
#'
#' Based on tables from WHO: http://www.who.int/childgrowth/standards/weight_for_age/en/
#'
#' @param age age in years
#' @param sex either `male` or `female`
#' @param weight weight in kg. Optional, if specified, will calculate closest percentile and return in list as `percentile`
#' @param ... parameters passed to `read_who_table()`
#' @export
pct_weight_for_age <- function(age = NULL, weight = NULL, sex = NULL, ...) {
  pct <- pct_for_age_generic(age = age, value = weight, sex = sex, variable = "weight", ...)
  return(pct)
}
