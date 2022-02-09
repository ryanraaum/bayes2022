source("renv/activate.R")

setHook("rstudio.sessionInit", function(newSession) {
  if (newSession) {
    if (!rstudioapi::readPreference("bayes2022", FALSE)) {
      rstudioapi::navigateToFile("Getting-Started.R", line = -1L, column = -1L)
      rstudioapi::writePreference("bayes2022", TRUE)
    }
  }
}, action = "append")
