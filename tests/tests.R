library(PKmisc)
library(testit)

## NCA
data <- data.frame(cbind(time = c(0, 1, 2, 4, 6, 8),
                         dv = c(300, 1400, 1150, 900, 700, 400)))
t1 <- nca(data)
assert("NCA estimates are correct (AUCinf)", round(t1$auc_inf) == 9164)
assert("NCA estimates are correct (AUCt)", round(t1$auc_t) == 6824)
assert("NCA estimates are correct (css_t)", round(t1$css) == 853)
assert("NCA estimates are correct (css_tau)", round(t1$css_tau) == 1137)

## BSA
assert("BSA",
       round(calc_bsa(80, 180)$value,2) == 2.00)

## eGFR
err1 <- try(expr = { calc_egfr(scr = .5, weight = 4.5, method = "cockroft_gault") }, silent=TRUE)
assert("Cockroft-gault error", class(err1[1]) == "character") # error message when no weight specified
assert("Cockroft-gault",
       round(calc_egfr(age = 40, sex="male", weight = 80, scr = 1, method = "cockroft_gault")$value) == 111)
assert("Cockroft-gault",
       round(calc_egfr(age = 40, sex="male", weight = 80, height=180, scr = 1, method = "cockroft_gault", relative = TRUE)$value) == 96)

err2 <- try(expr = { calc_egfr(age = 40, weight = 80, scr = 1, method = "malmo_lund_rev", relative = FALSE) }, silent=TRUE)
assert("Malmo-Lund error", class(err2[1]) == "character") # error message when no weight specified
assert("Malmo-Lund revised",
       round(calc_egfr(age = 40, sex="male", scr = 1, method = "malmo_lund_rev")$value) == 84)
assert("Malmo-Lund revised",
       round(calc_egfr(age = 40, sex="male", scr = 1, weight = 80, height = 180, method = "malmo_lund_rev", relative = FALSE)$value) == 97)

err3 <- try(expr = { calc_egfr(age = 0.5, scr = .5, weight = 4.5, method = "schwartz") }, silent=TRUE)
assert("Schwartz revised",
       calc_egfr(age = 0.5, sex="male", scr = .5, weight = 4.5, height = 50, method = "schwartz_revised", scr_assay="idms", relative = TRUE)$value == 41.3)
assert("Schwartz error", class(err3[1]) == "character") # error message when no weight specified
assert("Schwartz revised",
       calc_egfr(age = 0.5, sex = "male", scr = .5,  height = 50, method = "schwartz_revised")$value == 41.3)
assert("Schwartz",
       calc_egfr(age = 0.5, sex = "male", scr = .5, weight = 4.5, height = 50, method = "schwartz")$value == 33)

l <- calc_egfr(
  method = "malmo_lund_rev",
  weight = 45,
  age = 62,
  height = 156,
  scr = c(63, 54, 60, 52),
  scr_unit = rep("umol/l", 4),
  sex = "female",
  relative = FALSE)
assert("multiple calc egfr malmo-lund rev", round(l$value) == c(65,73, 67,74))

## FFM
assert("BMI=20 male 80kg",
       round(calc_ffm (
         weight = 80,
         bmi = 20,
         sex = "male"
       )$value) == 67)
assert("BMI=30 male 80kg",
       round(calc_ffm (
         weight = 80,
         bmi = 30,
         sex = "male"
       )$value) == 56)
assert("BMI=30 female 80kg",
       round(calc_ffm (
         weight = 80,
         bmi = 30,
         sex = "female"
       )$value) == 46)

## PK functions
assert("PK 1cmt iv steady state",
  round(tail(pk_1cmt_iv_ss(tau = 12, t_inf = 2), 1)$dv,3) == 0.954
)
assert("PK 1cmt iv steady state by summation",
  round(tail(pk_1cmt_iv(tau = 12, t_inf = 2, t=seq(from=0, to=10*12, by=.2))$dv,1), 3) == 0.954
)
