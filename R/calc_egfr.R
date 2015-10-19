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
  method = "malmo_lund_rev",
  sex = "male", age = 50, scr = NULL, race = "other",
  weight = NULL, height = NULL, bsa = NULL, bsa_method = "dubois",
  term = "full", ckd = FALSE,
  scr_unit = "mg/dl",
  relative = NULL,
  unit_out = "mL/min"
  ) {
    available_methods <- c("cockroft_gault", "malmo_lund_rev", "mdrd", "schwartz")
    method <- tolower(method)
    sex <- tolower(sex)
    if(is.null(scr)) {
      stop("Serum creatinine value required!")
    }
    if(is.null(relative)) {
      relative <- TRUE # most equations report in /1.73m2
      if(relative == "cockroft_gault") { relative <- FALSE }
    }
    if((relative && method %in% c("cockroft_gault")) || (!relative && method %in% c("mdrd", "schwartz", "malmo_lund_rev")) ) {
      if(!(is.null(weight) && is.null(height))) { # report eGFR per 1.73 m2. requires bsa or height as well
        if(is.null(bsa)) {
          bsa <- calc_bsa(weight, height, "dubois")
        }
      }
    }
    unit_out <- tolower(unit_out)
    if(method %in% available_methods) {
      crcl <- c()
      unit <- unit_out
      for (i in 1:length(scr)) {
        if(method == "mdrd") {
          if(tolower(scr_unit[i]) == "umol/l" || tolower(scr_unit[i]) == "micromol/l") {
            scr[i] <- scr[i] / 88.40
          }
          f_sex <- 1
          f_race <- 1
          if (sex == "female") { f_sex <- 0.762 }
          if (race == "black") { f_race <- 1.210 }
          crcl[i] <- 186 * scr[i]^(-1.154) * f_sex * f_race * age^(-0.203)
          if(!relative) {
            crcl <- crcl * (bsa/1.73)
            unit <- unit
          }
        }
        if(method == "cockroft_gault") {
          if(tolower(scr_unit[i]) == "umol/l" || tolower(scr_unit[i]) == "micromol/l") {
            scr[i] <- scr[i] / 88.40
          }
          f_sex <- 1
          if (sex == "female") { f_sex <- 0.85 }
          crcl[i] <- f_sex * (140-age) / scr[i] * (weight/72)
          if(relative) {
            crcl <- crcl / (bsa/1.73)
            unit <- paste0(unit_out, "/1.73m^2")
          }
        }
        if(method == "malmo_lund_rev") {
          if(tolower(scr_unit[i]) == "mg/dl") {
            scr[i] <- scr[i] * 88.40
          }
          if(sex=="female") {
            if(scr[i] < 150) {
              x <- 2.50 + 0.0121 * log(150-scr[i])
            } else {
              x <- 2.50 - 0.926 * (scr[i]/150)
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
            crcl <- crcl * (bsa/1.73)
            unit <- paste0(unit_out, "/1.73m^2")
          }
        }
        if(method == "schwartz") {
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
          crcl <- (k * height) / scr
          if(!relative) {
            crcl <- crcl * (bsa/1.73)
            message("eGFR from Schwartz commonly reported as relative to 1.73m^2 BSA. Consider using 'relative=TRUE' argument.")
          } else {
            unit <- paste0(unit_out, "/1.73m^2")
          }
        }
        if (length(grep("L/hr", unit_out)) > 0) {
          crcl[i] <- crcl[i] * 60 / 1000
        }
        if (length(grep("mL/hr", unit_out)) > 0) {
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
