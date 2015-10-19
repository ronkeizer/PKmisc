library(PKmisc)
library(testit)

## NCA
data <- data.frame(cbind(time = c(0, 1, 2, 4, 6, 8),
                         dv = c(300, 1400, 1150, 900, 700, 400)))
t1 <- nca(data)
assert("NCA estimates are correct (AUCinf)", round(t1$auc_inf) == 9164)
assert("NCA estimates are correct (AUCt)", round(t1$auc_t) == 6824)
assert("NCA estimates are correct (css)", round(t1$css) == 1137)

## BSA
assert("BSA",
       round(calc_bsa(80, 180),2) == 2.00)

## eGFR
assert("Cockroft-gault",
       round(calc_egfr(age = 40, weight = 80, scr = 1, method = "cockroft_gault", relative = FALSE)$value) == 111)
assert("Cockroft-gault",
       round(calc_egfr(age = 40, weight = 80, height=180, scr = 1, method = "cockroft_gault", relative = TRUE)$value) == 96)
assert("Malmo-Lund revised",
       round(calc_egfr(age = 40, scr = 1, weight = 80, height = 180, method = "malmo_lund_rev", relative = TRUE)$value) == 73)
assert("Malmo-Lund revised",
       round(calc_egfr(age = 40, scr = 1, method = "malmo_lund_rev", relative = FALSE)$value) == 84)
assert("Schwartz",
       round(calc_egfr(age = 0.5, scr = .5, weight = 4.5, height = 50, method = "schwartz", relative = TRUE)$value) == 45)
assert("Schwartz",
       round(calc_egfr(age = 0.5, scr = .5, weight = 4.5, height = 50, method = "schwartz", relative = FALSE)$value) == 6)

