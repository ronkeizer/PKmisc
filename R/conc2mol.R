#' Convert concentration to molar
#'
#' Assuming units of concentration and molecular weight are in same units of weight and volume
#'
#' @param conc concentration in e.g. g/L
#' @param unit, one of `g/l`, `mg/l`, `microg/l`, `mcg/l", `ng/l`, `mg/ml`, `microg/ml`, `mcg/ml`, `ng/ml`
#' @param mol_weight concentration in g/mol
#' @param unit_out one of `mol/L`, `mmol/mL`, `mmol/L`
#' @export
conc2mol <- function(
  conc = NULL,
  unit = NULL,
  mol_weight = NULL,
  unit_out = "mol/l") {
  unit <- tolower(unit)
  units <- c("g/l", "mg/l", "microg/l", "mcg/l", "ng/l",
             "mg/ml", "microg/ml", "mcg/ml", "ng/ml")
  if(is.null(unit)) {
    message("Unit not specified, assuming mg/L.")
    unit <- "mg/l"
  }
  if(unit %in% units) {
    if(unit == "g/l" || unit == "mg/ml") {
      fact <- 1
    }
    if(unit == "mg/l" || unit == "microg/ml" || unit == "mcg/ml") {
      fact <- 1e3
    }
    if(unit == "microg/l" || unit == "mcg/l" || unit == "ng/ml") {
      fact <- 1e6
    }
    if(unit == "ng/l" || unit == "pcg/ml") {
      fact <- 1e9
    }
    mol <- (conc/fact)/mol_weight
    units_out <- c("mol/l", "mmol/l", "mmol/ml")
    if(tolower(unit_out) %in% units_out) {
      if(tolower(unit_out) == "mol/l" || tolower(unit_out) == "mmol/ml") {
        return(list(value = mol, unit=unit_out))
      }
      if(tolower(unit_out) == "mmol/l") {
        return(list(value = mol*1e3, unit=unit_out))
      }
    } else {
      stop(paste0("Unknown unit for output, choose one of: ", paste(units_out, collapse=" ")))
    }
  } else {
    stop(paste0("Unknown unit for concentration, choose one of: ", paste(units, collapse=" ")))
  }
}
