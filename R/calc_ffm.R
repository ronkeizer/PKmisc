#' Calculate fat-free mass
#'
#' Get an estimate of body-surface area based on weight, height, and sex (and age for Storset equation).
#'
#' References:
#' `green`: Janmahasatian et al. Clin Pharmacokinet. 2005;44(10):1051-65)
#' `holford`: McCune J et al. Clin Cancer Res 2013
#' `storset`: Storset E et al. TDM 2016
#'
#' @param weight total body weight in kg
#' @param bmi BMI, only used in `green` method. If `weight` and `height` are both specified, `bmi` will be calculated on-the-fly.
#' @param height height in cm, only required for `holford` method, can be used instead of `bmi` for `green` method
#' @param sex sex, either `male` of `female`
#' @param age age, only used for Storset equation
#' @param method estimation method, either `green` (default), `holford`, or `storset`
#' @export
calc_ffm <- function (
  weight = NULL,
  bmi = NULL,
  sex = NULL,
  height = NULL,
  age = NULL,
  method = "green",
  digits = 1) {
  methods <- c("green", "holford", "storset")
  if(! method %in% methods) {
    stop(paste0("Unknown estimation method, please choose from: ", paste(methods, collapse=" ")))
  }
  if(is.null(sex) || !(sex %in% c("male", "female"))) {
    stop("Sex needs to be either male or female!")
  }
  if(method == "green") {
    if(is.null(weight) || (is.null(bmi) & is.null(height)) || is.null(sex)) {
      stop("Equation needs weight, BMI or height, and sex of patient!")
    } else {
      if(is.null(bmi)) {
        bmi <- calc_bmi(height = height, weight = weight)
      }
      if(sex == "male") {
        ffm <- (9.27e03 * weight) / ((6.68e03) + 216 * bmi)
      } else {
        ffm <- (9.27e03 * weight) / ((8.78e03) + 244 * bmi)
      }
    }
  }
  if(method == "holford") {
    whs_max <- 42.92
    whs_50 <- 30.93
    if(sex == "female") {
      whs_max <- 37.99
      whs_max <- 35.98
    }
    ffm <- (whs_max * (height/100)^2 * weight) / (whs_50 * (height/100)^2 + weight)
  }
  if(method == "storset") { # based on kidney transplant patient
    if(is.null(weight) || is.null(height) || is.null(sex) || is.null(age)) {
      stop("Equation needs weight, height, sex, and age of patient!")
    } else {
      if(sex == "male") {
        ffm <- (11.4 * weight) / (81.3 + weight) * (1 + height * 0.052) * (1-age*0.0007)
      } else {
        ffm <- (10.2 * weight) / (81.3 + weight) * (1 + height * 0.052) * (1-age*0.0007)
      }
    }
  }
  return(list(
    value = round(ffm, digits),
    unit = "kg",
    method = tolower(method)
  ))
}
