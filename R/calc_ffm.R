#' Calculate BSA
#'
#' Get an estimate of body-surface area based on weight and height.
#'
#' @references Quantification of Lean Bodyweight Sarayut Janmahasatian,1 Stephen B. Duffull,1,2 Susan Ash,3 Leigh C. Ward,4 Nuala M. Byrne5 and Bruce Green1,2
#' @param weight weight
#' @param bmi BMI
#' @param sex sex
#' @export
calc_ffm <- function (
  weight = NULL,
  bmi = NULL,
  sex = NULL
) {
  if(is.null(weight) || is.null(bmi) || is.null(sex)) {
    stop("Equation needs weight, BMI, and sex of patient!")
  } else {
    if(!(sex %in% c("male", "female"))) {
      stop("Sex needs to be either male or female!")
    }
    if(sex == "male") {
      ffm <- (9.27e03 * weight) / ((6.68e03) + 216 * bmi)
    } else {
      ffm <- (9.27e03 * weight) / ((8.78e03) + 244 * bmi)
    }
    return(list(
      value = ffm,
      unit = "kg"
    ))
  }
}
