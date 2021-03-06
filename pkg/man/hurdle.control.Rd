\name{hurdle.control}
\alias{hurdle.control}

\title{Control Parameters for Hurdle Count Data Regression}
\description{
  Various parameters that control fitting of hurdle regression models
  using \code{\link{hurdle}}.
}

\usage{
hurdle.control(method = "BFGS", maxit = 10000, trace = FALSE,
  separate = TRUE, start = NULL, hessian = TRUE, \dots)
}

\arguments{
  \item{method}{characters string specifying the \code{method} argument
    passed to \code{\link[stats]{optim}}.}
  \item{maxit}{integer specifying the \code{maxit} argument (maximal number
    of iterations) passed to \code{\link[stats]{optim}}.}
  \item{trace}{logical or integer controlling whether tracing information on  
    the progress of the optimization should be produced (passed to \code{\link[stats]{optim}}).}
  \item{separate}{logical. Should the estimation of the parameters in the truncated
    count component and hurdle zero component be carried out separately? See details.}
  \item{start}{an optional list with elements \code{"count"} and \code{"zero"}
    (and potentially \code{"theta"}) containing the coefficients for the corresponding component.}
  \item{hessian}{logical. Should the Hessian be computed to derive an estimate of the
    variance-covariance matrix? If \code{FALSE}, the variance-covariance matrix contains only
    \code{NA}s.}
  \item{\dots}{arguments passed to \code{\link[stats]{optim}}.}
}

\details{
  All parameters in \code{\link{hurdle}} are estimated by maximum likelihood
  using \code{\link[stats]{optim}} with control options set in \code{\link{hurdle.control}}.
  Most arguments are passed on directly to \code{optim}, only \code{trace} is also
  used within \code{hurdle} and \code{separate}/\code{start} control how \code{optim}
  is called.

  Starting values can be supplied via \code{start} or estimated by
  \code{\link[stats]{glm.fit}} (default).
  
  If \code{separate = TRUE} (default) the likelihoods of the truncated count component and the
  hurdle zero component will be maximized separately, otherwise the joint likelihood is
  set up and maximized. In case of \code{separate = FALSE} and both \code{dist == "negbin"}
  and \code{zero.dist == "negbin"} the theta parameter is restricted to be identical
  across both negative binomial distributions.
  
  Standard errors are derived numerically using
  the Hessian matrix returned by \code{\link[stats]{optim}}. To supply starting 
  values, \code{start} should be a list with elements \code{"count"} and \code{"zero"}
  and potentially \code{"theta"} (a named vector, for models with negative binomial components 
  only) containing the starting values for the coefficients of the corresponding component 
  of the model.
}

\value{
  A list with the arguments specified.
}

\seealso{\code{\link{hurdle}}}

\examples{
data("CrabSatellites", package = "countreg")

## default start values
fm1 <- hurdle(satellites ~ width + as.numeric(color), data = CrabSatellites,
  dist = "negbin", zero = "negbin")

## user-supplied start values and other options
fm2 <- hurdle(satellites ~ width + as.numeric(color), data = CrabSatellites,
  dist = "negbin",
  zero = "negbin",
  trace = TRUE,
  separate = FALSE,
  start = list(count = c(0.5, 0, 0),
  	       zero = c(-10, 0.5, -0.5),
  	       theta = c(count = 1, zero = 1)))

}

\keyword{regression}
