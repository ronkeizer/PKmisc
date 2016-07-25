#' Convert molar to concentration

#' @param mol concentration in molars
#' @param unit_mol unit of input concentration (molar), one of `mol/L`, `mmol/mL`, `mmol/L`
#' @param mol_weight concentration in g/mol
#' @param unit_conc, output unit, one of `g/l`, `mg/l`, `microg/l`, `mcg/l", `ng/l`, `mg/ml`, `microg/ml`, `mcg/ml`, `ng/ml`
#' @export
mol2conc <- function(
  mol = NULL,
  unit_mol = NULL,
  unit_conc = NULL,
  mol_weight = NULL
  ) {
  if(is.null(mol_weight)) {
    stop("Molecular weight not specified.")
  }
  units_conc <- c("g/l", "mg/l", "microg/l", "mcg/l", "ng/l",
             "mg/ml", "microg/ml", "mcg/ml", "ng/ml")
  if(is.null(unit_conc)) {
    message("Output concentration unit not specified, assuming mg/L.")
    unit_conc <- "mg/l"
  }
  if(is.null(unit_mol)) {
    message("Molar unit not specified, assuming mol/L.")
    unit_mol <- "mol/L"
  }
  unit_conc <- tolower(unit_conc)
  if(unit_conc %in% units_conc) {
    fact <- 1 #  if(unit_conc == "g/l" || unit_conc == "mg/ml") {
    if(unit_conc == "mg/l" || unit_conc == "microg/ml" || unit_conc == "mcg/ml") {
      fact <- 1e3
    }
    if(unit_conc == "microg/l" || unit_conc == "mcg/l" || unit_conc == "ng/ml") {
      fact <- 1e6
    }
    if(unit_conc == "ng/l" || unit_conc == "pcg/ml") {
      fact <- 1e9
    }
    conc <- (mol * mol_weight) * fact
    units_mol <- c("mol/l", "mmol/l", "mmol/ml")
    if(tolower(unit_mol) %in% units_mol) {
      if(tolower(unit_mol) == "mol/l" || tolower(unit_mol) == "mmol/ml") {
        return(list(value = conc, unit = unit_mol))
      }
      if(tolower(unit_mol) == "mmol/l") {
        return(list(value = conc/1e3, unit = unit_mol))
      }
    } else {
      stop(paste0("Unknown unit for molar concentration, choose one of: ", paste(units_mol, collapse=" ")))
    }
  } else {
    stop(paste0("Unknown unit for concentration, choose one of: ", paste(units_conc, collapse=" ")))
  }
}