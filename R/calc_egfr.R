#' Calculate eGFR
#'
#' Calculate the estimated glomerulal filtration rate, an estimate of renal function
#'
#' @param method eGFR estimation method, choose from `cockroft_gault`, `mdrd`, `malmo_lund_rev`, `schwartz`
#' @param sex sex
#' @param age age
#' @param scr serum creatinine (mg/dL)
#' @param scr_unit, `mg/dL` or `micromol/L` (==`umol/L`)
#' @param race `black` or `other`
#' @param weight weight
#' @param height height, only relevant when converting to/from BSA-relative unit
#' @param bsa body surface area
#' @param bsa_method BSA estimation method, see `bsa()` for details
#' @param term `pre`-term or `full`-term infants (Schwartz equation only)
#' @param ckd chronic kidney disease? (Schwartz equation only)
#' @param relative `TRUE`/`FALSE`. Report eGFR as per 1.73 m2? Requires BSA if re-calculation required. If `NULL` (=default), will choose value typical for `method`.
#' @param unit_out `ml/min` (default), `L/hr`, or `mL/hr`
#' @export
calc_egfr <- function (
  method = "cockroft_gault",
  sex = NULL,
  age = NULL,
  scr = NULL,
  race = "other",
  weight = NULL,
  height = NULL,
  bsa = NULL,
  term = "full",
  ckd = FALSE,
  bsa_method = "dubois",
  scr_unit = "mg/dl",
  relative = NULL,
  unit_out = "mL/min"
  ) {
    available_methods <- c("cockroft_gault", "malmo_lund_rev", "mdrd", "schwartz")
    method <- tolower(method)
    if(!method %in% available_methods) {
      stop(paste0("Sorry, eGFR calculation method not recognized! Please choose from: ", paste0(available_methods, collapse=" ")))
    }
    if(!is.nil(sex)) {
      sex <- tolower(sex)
    }
    if(is.nil(scr)) {
      stop("Serum creatinine value required!")
    }
    if(is.nil(relative)) {
      relative <- TRUE # most equations report in /1.73m2
      if(method == "cockroft_gault") {
        relative <- FALSE
      }
    }
    if(!is.nil(weight) && !is.nil(height)) {
      if(is.nil(bsa)) {
        bsa <- calc_bsa(weight, height, "dubois")$value
      }
    }
    unit_out <- tolower(unit_out)
    scr_unit <- gsub("%2F", "/", scr_unit)
    unit_out <- gsub("%2F", "/", unit_out)
    if(length(scr_unit) == 1 && length(scr) > 1) {
      scr_unit <- rep(scr_unit, length(scr))
    }
    if(method %in% available_methods) {
      crcl <- c()
      unit <- unit_out
      for (i in 1:length(scr)) {
        if(method == "mdrd") {
          if(is.nil(scr[i]) || is.nil(sex) || is.nil(race) || is.nil(age)) {
            stop("MDRD equation requires: scr, sex, race, and age as input!")
          }
          if(tolower(scr_unit[i]) == "umol/l" || tolower(scr_unit[i]) == "micromol/l") {
            scr[i] <- scr[i] / 88.40
          }
          f_sex <- 1
          f_race <- 1
          if (sex == "female") { f_sex <- 0.762 }
          if (race == "black") { f_race <- 1.210 }
          crcl[i] <- 186 * scr[i]^(-1.154) * f_sex * f_race * age^(-0.203)
          if(!relative) {
            if(is.nil(bsa)) {
              stop("Error: bsa not specified, or weight and height not specified! Can't convert between absolute and relative eGFR!")
            } else {
              crcl[i] <- crcl[i] * (bsa/1.73)
              unit <- unit
            }
          } else {
            unit <- paste0(unit_out, "/1.73m^2")
          }
        }
        if(method == "cockroft_gault") {
          if(is.nil(scr[i]) || is.nil(sex) || is.nil(weight) || is.nil(age)) {
            stop("Cockroft-Gault equation requires: scr, sex, weight, and age as input!")
          }
          if(tolower(scr_unit[i]) == "umol/l" || tolower(scr_unit[i]) == "micromol/l") {
            scr[i] <- scr[i] / 88.40
          }
          f_sex <- 1
          if (sex == "female") {
            f_sex <- 0.85
          }
          crcl[i] <- f_sex * (140-age) / scr[i] * (weight/72)
          if(relative) {
            if(is.nil(bsa)) {
              stop("Error: bsa not specified, or weight and height not specified! Can't convert between absolute and relative eGFR!")
            } else {
              crcl[i] <- crcl[i] / (bsa/1.73)
              unit <- paste0(unit_out, "/1.73m^2")
            }
          }
        }
        if(method == "malmo_lund_rev" || method == "lund_malmo_rev") {
          if(is.nil(scr) || is.nil(sex) || is.nil(age)) {
            stop("Revised Lund-Malmo equation requires: scr, sex, and age as input!")
          }
          if(tolower(scr_unit[i]) == "mg/dl") {
            scr[i] <- scr[i] * 88.40
          }
          if(sex == "female") {
            if(scr[i] < 150) {
              x <- 2.50 + 0.0121 * (150-scr[i])
            } else {
              x <- 2.50 - 0.926 * log(scr[i]/150)
            }
          } else { # male
            if(scr[i] < 180) {
              x <- 2.56 + 0.00968 * (180-scr[i])
            } else {
              x <- 2.56 - 0.926 * log(scr[i]/150)
            }
          }
          crcl[i] <- exp(x - 0.0158*age + 0.438*log(age))
          if(!relative) {
            if(is.nil(bsa)) {
              stop("Error: bsa not specified, or weight and height not specified! Can't convert between absolute and relative eGFR!")
            } else {
              crcl[i] <- crcl[i] * (bsa/1.73)
            }
          } else {
            unit <- paste0(unit_out, "/1.73m^2")
          }
        }
        if(method == "schwartz") {
          if(is.nil(scr[i]) || is.nil(age) || is.nil(sex) || is.nil(height) || is.nil(term)) {
            stop("Schwartz equation requires: scr, sex, height, term, and age as input!")
          }
          k <- 0.55
          if (age < 1) {
            k <- 0.45
            if(term == "pre") {
              k <- 0.33
            }
          } else {
            if(sex == "male") {
              k <- 0.7
            }
            if(ckd) {
              k <- 0.413
            }
          }
          crcl[i] <- (k * height) / scr
          if(!relative) {
            if(is.nil(bsa)) {
              stop("Error: bsa not specified, or weight and height not specified! Can't convert between absolute and relative eGFR!")
            } else {
              crcl[i] <- crcl[i] * (bsa/1.73)
              message("eGFR from Schwartz commonly reported as relative to 1.73m^2 BSA. Consider using 'relative=TRUE' argument.")
            }
          } else {
            unit <- paste0(unit_out, "/1.73m^2")
          }
        }
        if (length(grep("l/hr", tolower(unit_out))) > 0) {
          crcl[i] <- crcl[i] * 60 / 1000
        }
        if (length(grep("ml/hr", tolower(unit_out))) > 0) {
          crcl[i] <- crcl[i] * 60
        }
      }
      return(list(
        value = crcl,
        unit = unit,
        bsa = bsa
      ))
    } else {
      return(FALSE)
    }
}
