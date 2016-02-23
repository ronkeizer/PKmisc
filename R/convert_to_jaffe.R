#' Convert serum creatinine from various assays to Jaffe
#'
#' @param scr vector of serum creatinine values
#' @param assay assay type, either `enzymatic` or `idms`
#' @export
convert_to_jaffe <- function(scr, assay) {
  if (!is.null(assay)) {
    if(tolower(assay) %in% c("enzymatic", "enzym", "enzymatic_idms", "idms")) {
      if (tolower(assay) %in% c("enzymatic", "enzym")) {  # default is Jaffe method
        scr <- (scr + 0.112) / 1.05
      }
      if (tolower(assay) %in% c("enzymatic_idms", "idms")) {
        scr <- (scr + 0.254) / 1.027
      }
      return(scr)
    } else {
      return(scr)
    }
  } else {
    return(scr)
  }
}
