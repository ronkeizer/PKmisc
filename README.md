[![Build Status](https://travis-ci.org/ronkeizer/PKmisc.svg?branch=master)](https://travis-ci.org/ronkeizer/PKmisc)
[![codecov](https://codecov.io/gh/ronkeizer/PKmisc/branch/master/graph/badge.svg)](https://codecov.io/gh/ronkeizer/PKmisc)

# PKmisc
Miscellaneous equations and tools for clinical pharmacokinetics

## Tools
Miscellaneous PK tools

- `nca()`: Non-compartmental analysis

## Anthropomorphic equations

- `calc_bsa()`: BSA calculation using various equations
- `calc_ffm()`: Fat-free mass
- `calc_bmi()`: Body mass index
- `calc_ibw()`: Ideal body weight, using various equations for children and adults
- `calc_lbw()`: Lean body weight
- `calc_abw()`: Adjusted body weight (for obese patients)
- `pct_weight_for_age()`: calculate percentile of weight given age (for kids <= 10 yrs)
- `pct_height_for_age()`: calculate percentile of height given age (for kids <= 19 yrs)
- `pct_bmi_for_age()`: calculate percentile of height given age (for kids <= 19 yrs)

## Clinical chemistry

- `calc_egfr()`: eGFR calculation using various equations
- `convert_creat_assay()`: convert between various creatinine assays (Jaffe, IDMS, etc)

## Conversions

- `kg2lbs()`: kg to pounds
- `lbs2kg()`: pounds to kg
- `cm2inch()`: cm to inches
- `inch2cm()`: inches to cm
- `conc2mol()`: concentration to molar
- `mol2conc()`: molar to concentration

## PK compartmental equations

Functions to simulate concentrations for linear PK models.

| function | compartments | administration | type | output |
| --- | --- | --- | --- | --- |
| `pk_1cmt_inf()` | 1 | infusion | single/multi dose | concentration table |
| `pk_1cmt_inf_ss()` | 1 | infusion | steady state | concentration table |
| `pk_1cmt_inf_cmin_ss()` | 1 | infusion | steady state | Cmin |
| `pk_1cmt_inf_cmax_ss()` | 1 | infusion | steady state | Cmax |
| `pk_2cmt_inf()` | 2 | infusion | single/multi dose | concentration table |
| `pk_2cmt_inf_ss()` | 2 | infusion | steady state | concentration table |
| `pk_2cmt_inf_cmin_ss()` | 2 | infusion | steady state | Cmin |
| `pk_2cmt_inf_cmax_ss()` | 2 | infusion | steady state | Cmax |
| `pk_1cmt_bolus()` | 1 | bolus | single/multi dose | concentration table |
| `pk_1cmt_bolus_ss()` | 1 | bolus | steady state | concentration table |
| `pk_1cmt_bolus_cmin_ss()` | 1 | bolus | steady state | Cmin |
| `pk_1cmt_bolus_cmax_ss()` | 1 | bolus | steady state | Cmax |
| `pk_2cmt_bolus()` | 2 | bolus | single/multi dose | concentration table |
| `pk_2cmt_bolus_ss()` | 2 | bolus | steady state | concentration table |
| `pk_2cmt_bolus_cmin_ss()` | 2 | bolus | steady state | Cmin |
| `pk_2cmt_bolus_cmax_ss()` | 2 | bolus | steady state | Cmax |

## Dose calculations

Functions to calculate the dose expected to achieve a specific target exposure.

| function | compartments | administration | target | output |
| --- | --- | --- | --- | --- |
| `pk_1cmt_inf_dose_for_cmin` | 1 | infusion | cmin | dose |
| `pk_1cmt_bolus_dose_for_cmin` | 1 | bolus | cmin | dose |
| `pk_2cmt_inf_dose_for_cmin()` | 2 | infusion | cmin | dose |
| `pk_2cmt_bolus_dose_for_cmin()` | 2 | bolus | cmin | dose |
| `pk_1cmt_inf_dose_for_cmax` | 1 | infusion | cmax | dose |
| `pk_1cmt_bolus_dose_for_cmax` | 1 | bolus | cmax | dose |
| `pk_2cmt_inf_dose_for_cmax()` | 2 | infusion | cmax | dose |
| `pk_2cmt_bolus_dose_for_cmax()` | 2 | bolus | cmax | dose |
| `dose2auc()` | 1 | - | auc | auc |
| `auc2dose()` | 1 | - | auc | dose |
