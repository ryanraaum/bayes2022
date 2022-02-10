# From https://frodriguezsanchez.net/post/using-dharma-to-check-bayesian-models-fitted-with-brms/
check_brms <- function(model,             # brms model
                       integer = FALSE,   # integer response? (TRUE/FALSE)
                       plot = TRUE,       # make plot?
                       ...                # further arguments for DHARMa::plotResiduals
) {

  mdata <- brms::standata(model)
  if (!"Y" %in% names(mdata))
    stop("Cannot extract the required information from this brms model")

  dharma.obj <- DHARMa::createDHARMa(
    simulatedResponse = t(brms::posterior_predict(model, ndraws = 1000)),
    observedResponse = mdata$Y,
    fittedPredictedResponse = apply(
      t(brms::posterior_epred(model, ndraws = 1000, re.form = NA)),
      1,
      mean),
    integerResponse = integer)

  if (isTRUE(plot)) {
    plot(dharma.obj, ...)
  }

  invisible(dharma.obj)

}
