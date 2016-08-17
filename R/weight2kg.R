#' Convert any weight unit to kg
#'
#' @param value weight in any allowed unit
#' @param unit unit of weight, one of "lbs", "pound", "pounds", "oz", "ounce", "ounces"
#' @export
weight2kg <- function(value, unit) {
  if (tolower(unit) %in% c("lbs","pound", "pounds")) {
    value <- weight_df$value / 2.20462
  }
  if (tolower(unit) %in% c("oz", "ounce", "ounces")) {
    value <- weight_df$value / 35.274
  }
  return(value)
}
