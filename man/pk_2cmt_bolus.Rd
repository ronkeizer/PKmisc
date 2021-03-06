% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pk_2cmt_bolus.R
\name{pk_2cmt_bolus}
\alias{pk_2cmt_bolus}
\title{Concentration predictions for 1-compartmental PK model, single or multiple bolus doses}
\usage{
pk_2cmt_bolus(t = c(0:24), dose = 100, tau = 12, CL = 3, V = 30,
  Q = 2, V2 = 20, ruv = NULL)
}
\arguments{
\item{t}{vector of time}

\item{dose}{dose}

\item{tau}{dosing interval}

\item{CL}{clearance}

\item{V}{volume of central compartment}

\item{Q}{inter-compartimental clearance}

\item{V2}{volume of peripheral compartment}

\item{ruv}{residual error (list)}
}
\description{
Concentration predictions for 1-compartmental PK model, single or multiple bolus doses
}
