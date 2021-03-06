\name{GSOEP}
\alias{GSOEP}

\title{Health Services (GSOEP)}

\description{
Unbalanced panel concerning the usage of health services in Germany for the years 1984-1988, 1991 and 1994 consisting of 27,326 observations on 22 variables taken from the German Socioeconomic Panel (GSOEP).  The number of visits to a doctor and the number of inpatient hospital visits are given along with several personal socioeconomic characteristics.
}

\usage{data("GSOEP")}

\format{
  A data frame with 27,326 observations on 22 variables.
  \describe{
    \item{id}{identification number indicating 1 to 7 observations for each of the 7,293 cases.}
    \item{female}{factor indicating whether a person is female (\code{yes} or \code{no}).}
    \item{year}{factor giving the calendar year of the observation.}
    \item{age}{age in years.}
    \item{hsat}{personal health satisfaction judged on a scale from 0 (low) to 10 (high). See \emph{Details}.}
    \item{handdum}{dummy variable indicating whether a person is handicapped (\code{=1}) or not (\code{=0}). See \emph{Details}.}
    \item{handper}{degree of handicap expressed in percent from 0 to 100. See \emph{Details}.}
    \item{hhninc}{monthly household net income in 1'000 German marks.}
    \item{hhkids}{factor indicating whether a household has kids below the age of 16 (\code{yes} or \code{no}).}
    \item{educ}{years of schooling. See \emph{Details}.}
    \item{married}{factor indicating whether a person is married (\code{yes} or \code{no}).}
    \item{school}{factor giving the highest schooling degree. \code{haupt} for Hauptschule, \code{real} for Realschule, \code{fach} for Fachschule and \code{abitur} for Gymnasium.}
    \item{univ}{factor indicating whether a person has a university diploma (\code{yes} or \code{no}).}
    \item{working}{factor indicating whether a person is employed (\code{yes} or \code{no}).}
    \item{bluec}{factor indicating whether a person is a blue collar worker (\code{yes} or \code{no}).}
    \item{whitec}{factor indicating whether a person is a white collar worker (\code{yes} or \code{no}).}
    \item{self}{factor indicating whether a person is self employed (\code{yes} or \code{no}).}
    \item{civil}{factor indicating whether a person is a civil servant (\code{yes} or \code{no}).}
    \item{docvis}{number of doctor visits within the last three months.}
    \item{hospvis}{number of hospital visits within the last calendar year.}
    \item{public}{factor indicating whether a person is insured in public health insurance (\code{yes} or \code{no}).}
    \item{addon}{factor indicating whether a person is insured in add-on insurance (\code{yes} or \code{no}).}
  }
}

\details{
The data were first used by Riphahn, Wambach and Million (2003).

As noted by Greene (2007, 2008), there are 40 observations on \code{hsat} taking on values between 6 and 7 although the variable is supposed to be an integer. For three other variables similar problems occur: By construction, \code{handdum} should be a dummy variable but there are 18 observations taking on values between 0 and 1. Also, for \code{handper} 3,290 observations are not integer-valued. Finally, the precision of 148 values of \code{educ} is very suspicious. 

As of 2013, a comment and a reply on data issues are available from the JAE archive. No attempts are made to fix these issues here. Data is used \sQuote{as is} in order to replicate Greene (2007, 2008, 2011).
}

\source{
Journal of Applied Econometrics Data Archive.

\url{http://qed.econ.queensu.ca/jae/2003-v18.4/riphahn-wambach-million/}
}

\references{                                                   
Greene WH (2007). 
 \dQuote{Functional Form and Heterogeneity in Models for Count Data}. 
 \emph{Foundations and Trends in Econometrics}, \bold{1}(2), 113--218.

Greene WH (2008). 
 \dQuote{Functional Forms for the Negative Binomial Model for Count Data}. 
 \emph{Economics Letters}, \bold{99}, 585--590.
 
Greene WH (2011). \emph{Econometric Analysis}, 7th edition. Upper Saddle River, NJ: Prentice Hall.

Riphahn RT, Wambach A, Million A (2003). 
 \dQuote{Incentive Effects in the Demand for Health Care: A Bivariate Panel Count Data Estimation}. 
 \emph{Journal of Applied Econometrics}, \bold{18}(4), 387--405.
}

\examples{
data("GSOEP")

if(exists("nbp.u") & exists("nbp.o")) {

# We fit an NB1, an NB2 and an NBP model as in Greene (2007) ...
model.u <- docvis ~ age + I(age^2) + hsat + handdum + handper + married + educ + 
           hhninc + hhkids + self + civil + bluec + working + public + addon + year
fm.nb1.u <- nbp.u(model.u, data = subset(GSOEP, female == "no"), p.fix = 1)
fm.nb2.u <- nbp.u(model.u, data = subset(GSOEP, female == "no"), p.fix = 2)
fm.nbp.u <- nbp.u(model.u, data = subset(GSOEP, female == "no"))

# ... and show that the former two are inferior to the last one by standard likelihood ratio tests
library("lmtest")
lrtest(fm.nb1.u, fm.nbp.u)
lrtest(fm.nb2.u, fm.nbp.u)

# model with observed heterogeneity
model.o <- docvis ~ age + I(age^2) + hsat + handdum + handper + married + educ + 
           hhninc + hhkids + self + civil + bluec + working + public + addon + year | hhninc + educ
## fm.nbp.o <- nbp.o(model.o, data = subset(GSOEP, female == "no"))

# visualization of the fit
# plot(fm.nbp.o)

# things to replicate from Greene (2011):
# Ex. 11.16, Tab 11.13, pp 451-452: nonlinear regression
# Tab. 14.2, pp 580--581: logistic and Poisson 
# Tab. 14.10, pp 611-613: geometric regression
# Ex. 17.7: binary Chow test (maybe not?)
# Tab 18.14, p 850: Poisson, various negbins
# Tab 18.17, p 860 (panel models, some of)
# Tab 18.19, p 866: hurdle models

# things to replicate from Greene (2008):
# Tab 2: Poisson, various negbins, presumably same as book

}
}

\keyword{datasets}
