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
#' @param bsa body surface area
#' @param bsa_method BSA estimation method, see `bsa()` for details
#' @param relative report eGFR as per 1.73 m2. Requires BSA depending on `method` chosen.
#' @param unit_out `ml/min` (default), `L/hr`, or `mL/hr`
#' @export
calc_egfr <- function (
  method = "malmo_lund_rev",
  sex = "male", age = 50, scr = 1, race = "other",
  weight = NULL, bsa = NULL, bsa_method = "dubois",
  scr_unit = "mg/dl",
  relative = FALSE,
  unit_out = "mL/min"
  ) {
    available_methods <- c("cockroft_gault", "malmo_lund_rev", "mdrd", "schwartz")
    method <- tolower(method)
    sex <- tolower(sex)
    if(relative) { # report eGFR per 1.73 m2. requires bsa or height as well
      if(is.null(bsa)) {
        if(weight) {
          bsa <- calc_bsa(weight, height, "dubois")
        }
      }
    }
    if(method %in% available_methods) {
      crcl <- c()
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
        }
        if(method == "cockroft_gault") {
          if(tolower(scr_unit[i]) == "umol/l" || tolower(scr_unit[i]) == "micromol/l") {
            scr[i] <- scr[i] / 88.40
          }
          f_sex <- 1
          if (sex == "female") { f_sex <- 0.85 }
          crcl[i] <- f_sex * (140-age) / scr[i] * (weight/72)
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
        }
        if(method == "schwartz") {

        }
        if (unit_out == "L/hr") {
          crcl[i] <- crcl[i] * 60 / 1000
        }
        if (unit_out == "mL/hr") {
          crcl[i] <- crcl[i] * 60
        }
      }
      crcl
    } else {
      return(FALSE)
    }
}
