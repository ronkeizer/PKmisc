#' Calculate ideal body weight for children and adults
#'
#' Get an estimate of ideal body weight. This function allows several commonly used equations
#'
#' @param age age in years
#' @param weight weight in kg
#' @param height height in cm
#' @param sex either `male` or `female`
#' @param method_children method to use for children >1 and <18 years. Choose from `standard`, `mclaren` (McLaren DS, Read WWC. Lancet. 1972;2:146-148.), `moore` (Moore DJ et al. Nutr Res. 1985;5:797-799), `bmi` (), `ada` (American Dietary Association)
#' @param method_adults method to use for >=18 years. Choose from `devine` (default, Devine BJ. Drug Intell Clin Pharm. 1974;8:650-655).
#' @param digits number of decimals (can be NULL to for no rounding)
#'
#' Equations:
#'
#' <1yo Use actual body weight
#'
#' 1-17 years old ('standard'):
#'   if height < 5ft:
#'     IBW= (height in cm2 x 1.65)/1000
#'   if height > 5ft:
#'     IBW (male) = 39 + (2.27 x height in inches over 5 feet)
#'     IBW (female) = 42.2 + (2.27 x height in inches over 5 feet)
#'
#'   Methods not implemented yet:
#'   McLaren: IBW =
#'     - step1:   x = 50th percentile height for given age
#'     - step2: IBW = 50th percentile weight for x on weight-for-height scale
#'   Moore: IBW = weight at percentile x for given age, where x is percentile of height for given age
#'   BMI: IBW = 50th percentile of BMI for given age x (height in m)^2
#'   ADA: IBW = 50th percentile of WT for given age
#'
#' _ 18 years old (Devine equation)
#'   IBW (male) = 50 + (2.3 x height in inches over 5 feet)
#'   IBW (female) = 45.5 + (2.3 x height in inches over 5 feet)
#'
#' @export
calc_ibw <- function (
  weight = NULL,
  height = NULL,
  age = NULL,
  sex = "male",
  method_children = "standard",
  method_adults = "devine",
  digits = NULL
) {
  available_methods_children <- c("standard") # c("moore", "mclaren", "bmi", "ada")
  method_children <- tolower(method_children)
  if(!(method_children %in% available_methods_children)) {
    stop("Specified method for children not available.")
  }
  available_methods_adults <- c("devine")
  method_adults <- tolower(method_adults)
  if(!(method_adults %in% available_methods_adults)) {
    stop("Specified method for adults not available.")
  }
  if(is.null(age)) {
    stop("Age not specified!")
  }

  ibw <- NULL

  ## babies
  if(age < 1) {
    message("Note: IBW is commonly not used for children < 1 year, most often actual body weight is used for this population.")
    ibw <- weight
  }

  ## children
  if(age >= 1 && age < 18) {
    if(method_children == "standard") {
      if(is.null(height) || is.null(age) || is.null(sex)) {
        stop("Height, age and sex are required!")
      }
      if(cm2inch(height) < 5*12) {
        ibw <- (height^2 * 1.65)/1000
      } else {
        if(tolower(sex) == "male") {
          ibw <- 39 + 2.27 * (cm2inch(height)-(5*12))
        } else {
          ibw <- 42.2 + 2.27 * (cm2inch(height)-(5*12))
        }
      }
    }
  }

  ## adults
  if(age > 18) {
    if(method_adults == "devine") {
      if(is.null(height) || is.null(sex)) {
        stop("Height and sex are required to calculate!")
      }
      if(sex == "male") {
        ibw <- 50 + (2.3 * (cm2inch(height)-(5*12)))
      }
      if(sex == "female") {
        ibw <- 45.5 + (2.3 * (cm2inch(height)-(5*12)))
      }
    }
  }

  if(is.null(ibw)) {
    stop("For some reason, IBW could not be calculated. Check your inputs.")
  }
  if(!is.null(digits)) {
    ibw <- round(ibw, digits=digits)
  }

  return(ibw)
}
