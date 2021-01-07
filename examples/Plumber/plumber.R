library(plumber)
library(rapidoc)
library(ranger)
library(parsnip)
library(pins)

board_register_rsconnect(server = "https://colorado.rstudio.com/rsc",
                         key = Sys.getenv("connect_key"))
model <- pin_get("james/credit_risk_model", board = "rsconnect")

validate_data <- function(data) {
  all(c("age", "sex", "job", "housing", "saving_accounts", "checking_account", "credit_amount", "duration", "purpose") %in% names(data))
}


#* @apiTitle Credit Risk Model


#* API Status
#* @get /status
function() {
  list(
    status = "good",
    time = Sys.time()
  )
}

#* Predict credit risk
#* @parser json
#* @serializer json
#* @post /predict
function(req, res) {
  data <- as.data.frame(req$body)
  if (!validate_data(data)) {
    res$status <- 400
    return(list(error = "Invalid data submitted"))
  }
  predict(model$model, data, type = "prob")
}

#* @plumber
function(pr) {
  pr %>% 
    pr_set_api_spec("openapi.yaml") %>% 
    pr_set_docs("rapidoc")
}
