#' Convert serum creatinine from various assays to Jaffe
#'
#' @param scr vector of serum creatinine values
#' @param from assay type, either `jaffe`, `enzymatic` or `idms`
#' @param to assay type, either `jaffe`, `enzymatic` or `idms`
#' @export
convert_creat_assay <- function(
  scr,
  from = "idms",
  to = "jaffe") {

  ## first convert everything to jaffe
  if (tolower(from) %in% c("enzymatic", "enzym")) {  # default is Jaffe method
     scr <- (scr + 0.112) / 1.05
  }
  if (tolower(from) %in% c("enzymatic_idms", "idms")) {
     scr <- (scr + 0.254) / 1.027
  }

  ## convert to other, if required
  if (tolower(to) %in% c("enzymatic", "enzym")) {  # default is Jaffe method
    scr <- (scr * 1.05) - 0.112
  }
  if (tolower(to) %in% c("enzymatic_idms", "idms")) {
    scr <- (scr * 1.027) - 0.254
  }
  return(scr)
}
