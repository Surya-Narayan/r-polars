% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/error_conversion.R
\name{result}
\alias{result}
\title{Capture any R error and return a rust-like Result}
\usage{
result(expr, msg = NULL)
}
\arguments{
\item{expr}{code to capture any error from and wrap as Result}

\item{msg}{handy way to add a context msg}
}
\value{
Result
}
\description{
Capture any R error and return a rust-like Result
}
\examples{

# user internal functions without using :::
result = environment(polars::pl$all)$result
unwrap_err = environment(polars::pl$all)$unwrap_err
unwrap = environment(polars::pl$all)$unwrap
Err = environment(polars::pl$all)$Err

# capture regular R errors or RPolarsErr
throw_simpleError = \() stop("Imma simple error")
result(throw_simpleError())

throw_RPolarsErr = \() unwrap(
  Err(.pr$RPolarsErr$new()$bad_robj(42)$mistyped("String")$when("doing something"))
)
res_RPolarsErr = result(throw_RPolarsErr())
str(res_RPolarsErr)
RPolarsErr = unwrap_err(res_RPolarsErr)
RPolarsErr$contexts()
}
\keyword{internal}
