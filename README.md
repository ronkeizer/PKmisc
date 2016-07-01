[![Build Status](https://travis-ci.org/ronkeizer/PKmisc.svg?branch=master)](https://travis-ci.org/ronkeizer/PKmisc)

# PKmisc
Miscellaneous equations and tools for clinical pharmacokinetics

## Tools

Miscellaneous PK tools

- `nca()`: Non-compartmental analysis

## PK compartmental equations

Functions to simulate concentrations for linear PK models.

### Infusions
- `pk_1cmt_inf`: Concentration predictions for 1-compartmental PK model after single or multiple bolus infusions
- `pk_1cmt_inf_ss`: Concentration predictions for 1-compartmental PK model at steady state
- `pk_1cmt_inf_cmin_ss`: Cmin (trough) for linear 1-compartment PK model at steady state
- `pk_1cmt_inf_cmax_ss`: Cmax for linear 1-compartment PK model at steady state
- `pk_2cmt_inf`: Concentration predictions for 2-compartmental PK model after single or multiple bolus infusions
- `pk_2cmt_inf_ss`: Concentration predictions for 2-compartmental PK model at steady state
- `pk_2cmt_inf_cmin_ss`: Cmin (trough) for linear 2-compartment PK model at steady state
- `pk_2cmt_inf_cmax_ss`: Cmax for linear 2-compartment PK model at steady state

### IV bolus
- `pk_1cmt_bolus`: Concentration predictions for 1-compartmental PK model after single or multiple bolus infusions
- `pk_1cmt_bolus_ss`: Concentration predictions for 1-compartmental PK model at steady state
- `pk_1cmt_bolus_cmin_ss`: Cmin (trough) for linear 1-compartment PK model at steady state
- `pk_1cmt_bolus_cmax_ss`: Cmax for linear 1-compartment PK model at steady state
- `pk_2cmt_bolus`: Concentration predictions for 2-compartmental PK model after single or multiple bolus infusions
- `pk_2cmt_bolus_ss`: Concentration predictions for 2-compartmental PK model at steady state
- `pk_2cmt_bolus_cmin_ss`: Cmin (trough) for linear 2-compartment PK model at steady state
- `pk_2cmt_bolus_cmax_ss`: Cmax for linear 2-compartment PK model at steady state

## Anthropomorphic equations

- `calc_bsa()`: BSA calculation using various equations
- `calc_ffm()`: Fat-free mass
- `calc_bmi()`: Body mass index
- `calc_ibw()`: Ideal body weight, using various equations for children and adults
- `calc_lbw()`: Lean body weight
- `calc_abw()`: Adjusted body weight
- `pct_weight_for_age()`: calculate percentile of weight given age (for kids <= 10yrs)
- `pct_height_for_age()`: calculate percentile of height given age (for kids <= 19yrs)

## Clinical chemistry

- `calc_egfr()`: eGFR calculation using various equations
- `convert_creat_assay()`: convert between various creatinine assays (Jaffe, IDMS, etc)
