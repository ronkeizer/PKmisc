#' Calculate lean body weight
#' from Janmahasatian S et al. Clin Pharmacokinet. 2005;44(10):1051-65
#'
#' @param weight weight in kg
#' @param height height in cm
#' @param sex either male or female
#' @export
calc_lbw <- function(weight=NULL, height=NULL, sex="male") {
  if(is.null(weight) || is.null(height) || is.null(sex)) {
    stop("Weight, height, and sex need to be specified!")
  }
  if(!(tolower(sex) %in% c("male", "female"))) {
    stop("Sex needs to be either male or female.")
  }
  bmi <- calc_bmi(weight=weight, height=height)
  # placeholder
  if(tolower(sex) == "male") {
    lbw <- (9.27*1000 * weight) / ((6.68*1000) + 216*bmi)
  } else {
    lbw <- (9.27*1000 * weight) / ((8.78*1000) + 244*bmi)
  }
  return(lbw)
}
