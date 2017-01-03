get_symbol_details <- function(symbol) {

library(jsonlite)
library(RCurl)

token = "6c059bc15b86e92a1df48c4d556f4d52"
    
result <- NULL
while( is.null(result) ) {
    tryCatch({
    data0 <- fromJSON(getURL(paste0("https://1broker.com/api/v1/market/detail.php?symbol=",symbol,"&token=",token)))
    data1 <- fromJSON(getURL(paste0("https://1broker.com/api/v1/market/quotes.php?symbols=",symbol,"&token=",token)))
#    cat(length(data0), "\n")
#    cat(length(data1), "\n")
#    print("data0: ", data0, "\n")
#    print("data1: ", data1, "\n")    
#    flush.console()
    if (length(data0) == 4 && length(data1) == 4) {
      result <- TRUE
    }
  }, 
  error = function(e) {
    cat("Get Symbol Details: Error retrieving data\n")
    Sys.sleep(60)
    result <- NULL
  })
} 

on_long <- as.numeric(data0$response$overnight_charge_long_percent)
on_short <- as.numeric(data0$response$overnight_charge_short_percent)
#print(on_long)
#print(on_short)
#print(toString(data0$response$category))

if (toString(data0$response$category) == "Crypto") {
  trading_minutes = 365.25 * 24 * 60
}
if (toString(data0$response$category) == "Stock" || toString(data0$response$category) == "Index") {
  trading_minutes = (((365.25 * (5/7)) - 9) * 6.5 * 60) - (3 * 60)
}
if (toString(data0$response$category) == "Commodity" || toString(data0$response$category) == "Forex") {
  trading_minutes = (365.25 * (4/7) * 24 * 60) + (365.25 * (1/7) * 23 * 60)
}
#print(trading_minutes)

ask <- as.numeric(data1$response[3])
bid <- as.numeric(data1$response[2])          
spread <- ask - bid
#print(spread)

return_vector <- c(on_long, on_short, trading_minutes, spread)
return(return_vector)
}

#symbol = "VOW"
# cat(symbol,"\n")
#symbol_details <- get_symbol_details(symbol)
#print(symbol_details[1]) # daily fee on long
#print(symbol_details[2]) # daily fee on short
#print(symbol_details[3]) # trading minutes per year
#print(symbol_details[4]) # spread (needs to be divided by 2)


get_results <- function(query, function_name) {
  result <- NULL
  while( is.null(result) ) {
    tryCatch({
      cons <- dbListConnections(MySQL())
      for(con in cons)
        dbDisconnect(con)
      mydb = dbConnect(MySQL(), user='root', password='ubuntu917', dbname='1broker', host='mysql.cx5li9mlv1tt.us-east-1.rds.amazonaws.com')
      rs <- dbSendQuery(mydb, query)
      result <- TRUE
    }, 
    error = function(e) {
      cat(function_name, ": Get Results: Error retrieving data: ", conditionMessage(e), "\n")
      Sys.sleep(60)
      result <- NULL
    })
  } 
  results = fetch(rs, n = -1)
  
  return(results)
}



apply_fees <- function(symbol, frequency, combined_forecasts, leverage, spArimaGarchReturns) {

symbol_details <- get_symbol_details(symbol)
daily_fee_long <- symbol_details[1]
daily_fee_short <- symbol_details[2]
trading_minutes_per_year <- symbol_details[3]
spread <- symbol_details[4]
apply_daily_fee_when <- (60 / frequency) * 24

#print(combined_forecasts)
    
for (i in 2:length(combined_forecasts)) {
  # Apply daily fee
  if (leverage > 1 && i %% apply_daily_fee_when == 0) {
    if (spArimaGarchReturns[i] > 0) {
      spArimaGarchReturns[i] = spArimaGarchReturns[i] - (spArimaGarchReturns[i] * daily_fee_long * (leverage-1))
    } else {
      spArimaGarchReturns[i] = spArimaGarchReturns[i] + (spArimaGarchReturns[i] * daily_fee_short * (leverage-1))
    }
  }
  # Apply spread
#  cat("i-1: ", forecasts$returns[i - 1],"\n")
#  cat("i: ", i, " ")

  if (as.numeric(combined_forecasts[(i - 1), ]) != as.numeric(combined_forecasts[i, ])) {
#  if (combined_forecasts$returns[i - 1] != combined_forecasts$returns[i]) {
    if (spArimaGarchReturns[i] > 0) {
      spArimaGarchReturns[i] = spArimaGarchReturns[i] - (spread * leverage)
    } else {
      spArimaGarchReturns[i] = spArimaGarchReturns[i] + (spread * leverage)
    }
  }
}
    
return(spArimaGarchReturns)
}


apply_fees_ok <- function(combined_forecasts, spArimaGarchReturns, data) {
    spread = 0.03 / 100
    for (i in 2:length(combined_forecasts)) {
        if (as.numeric(combined_forecasts[(i - 1), ]) != as.numeric(combined_forecasts[i, ])) {
            if (spArimaGarchReturns[i] > 0) {
                spArimaGarchReturns[i] = spArimaGarchReturns[i] - (spread * as.numeric(data[i,4]))
            } else {
                spArimaGarchReturns[i] = spArimaGarchReturns[i] + (spread * as.numeric(data[i,4]))
            }
        }
    }

    return(spArimaGarchReturns)
}


get_trade_count <- function(combined_forecasts) {
    trade_count = 0
    for (i in 2:length(combined_forecasts)) {
        if (as.numeric(combined_forecasts[(i - 1), ]) != as.numeric(combined_forecasts[i, ])) {
            trade_count = trade_count + 1
        }
    }

    return(trade_count)
}
        
    
