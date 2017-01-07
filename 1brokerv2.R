library(httr)
source("https://raw.githubusercontent.com/ggrothendieck/gsubfn/master/R/list.R")


use_token <- function(token) {
    token <<- token
    return(TRUE)
}


order_open <- function() {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/order/open.php", query = list(token=token)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Orders Open: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }
    
    if (data$error) {stop("Orders Open: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Orders Open: Warning: ", data$warning_message, "\n")}
    
    return_vector <- list(data$response)
    return(return_vector)
    
}


user_details <- function() {
    result <- NULL
    while(is.null(result)) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/user/details.php", query = list(token=token)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("User Details: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }
    
    if (data$error) {stop("User Details: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("User Details: Warning: ", data$warning_message, "\n")}
    
    return_vector <- list(data$response$username,
                          data$response$email,
                          as.numeric(data$response$balance),
                          as.numeric(data$response$deposit_unconfirmed),
                          data$response$date_created)
    
    return(return_vector)
    
}


user_overview <- function() {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/user/overview.php", query = list(token=token)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("User Overview: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("User Overview: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("User Overview: Warning: ", data$warning_message, "\n")}
    
    return_vector <- list(data$response$username,
                          data$response$email,
                          as.numeric(data$response$balance),
                          as.numeric(data$response$deposit_unconfirmed),
                          data$response$date_created,
                          as.numeric(data$response$orders_worth),
                          as.numeric(data$response$positions_worth),
                          as.numeric(data$response$net_worth),
                          data$response$orders_open,
                          data$response$positions_open)
    return(return_vector)

}


user_bitcoin_deposit_address <- function() {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/user/bitcoin_deposit_address.php", query = list(token=token)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("User Bitcoin Deposit Address: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("User Bitcoin Deposit Address: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("User Bitcoin Deposit Address: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response$bitcoin_deposit_address,
                          data$response$two_factor_authentication)
    return(return_vector)

}


user_transaction_log <- function(offset = 0, limit = 20, date_start = "1970-01-01T12:00:00Z", date_end = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ")) {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/user/transaction_log.php", query = list(token=token, offset=offset, limit=limit, date_start=date_start, date_end = date_end)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("User Transaction Log: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("User Transaction Log: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("User Transaction Log: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response)
    return(return_vector)

}


order_create <- function(symbol, margin, direction, leverage = 1, order_type = "market", order_type_parameter, stop_loss, take_profit, shared = "false") {
    tryCatch({order_type_parameter}, error = function(e) {order_type_parameter <<- FALSE})
    tryCatch({stop_loss}, error = function(e) {stop_loss <<- FALSE})
    tryCatch({take_profit}, error = function(e) {take_profit <<- FALSE})

    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            if (order_type_parameter != FALSE && stop_loss != FALSE && take_profit != FALSE) {
                data <- content(GET("https://1broker.com/api/v2/order/create.php", query = list(token=token, symbol=symbol, margin=margin, direction=direction, leverage=leverage, order_type=order_type, order_type_parameter=order_type_parameter, stop_loss=stop_loss, take_profit=take_profit, referral_id=3981, shared=shared)), as = "parsed")
            }
            if (order_type_parameter == FALSE && stop_loss != FALSE  && take_profit != FALSE) {
                data <- content(GET("https://1broker.com/api/v2/order/create.php", query = list(token=token, symbol=symbol, margin=margin, direction=direction, leverage=leverage, order_type=order_type, stop_loss=stop_loss, take_profit=take_profit, referral_id=3981, shared=shared)), as = "parsed")
            }
            if (order_type_parameter != FALSE && stop_loss == FALSE && take_profit != FALSE) {
                data <- content(GET("https://1broker.com/api/v2/order/create.php", query = list(token=token, symbol=symbol, margin=margin, direction=direction, leverage=leverage, order_type=order_type, order_type_parameter=order_type_parameter, take_profit=take_profit, referral_id=3981, shared=shared)), as = "parsed")
            }
            if (order_type_parameter != FALSE && stop_loss != FALSE  && take_profit == FALSE) {
                data <- content(GET("https://1broker.com/api/v2/order/create.php", query = list(token=token, symbol=symbol, margin=margin, direction=direction, leverage=leverage, order_type=order_type, order_type_parameter=order_type_parameter, stop_loss=stop_loss, referral_id=3981, shared=shared)), as = "parsed")
            }
            if (order_type_parameter == FALSE && stop_loss == FALSE && take_profit != FALSE) {
                data <- content(GET("https://1broker.com/api/v2/order/create.php", query = list(token=token, symbol=symbol, margin=margin, direction=direction, leverage=leverage, order_type=order_type, take_profit=take_profit, referral_id=3981, shared=shared)), as = "parsed")
            }
            if (order_type_parameter == FALSE && stop_loss != FALSE  && take_profit == FALSE) {
                data <- content(GET("https://1broker.com/api/v2/order/create.php", query = list(token=token, symbol=symbol, margin=margin, direction=direction, leverage=leverage, order_type=order_type, stop_loss=stop_loss, referral_id=3981, shared=shared)), as = "parsed")
            }
            if (order_type_parameter != FALSE && stop_loss == FALSE && take_profit == FALSE) {
                data <- content(GET("https://1broker.com/api/v2/order/create.php", query = list(token=token, symbol=symbol, margin=margin, direction=direction, leverage=leverage, order_type=order_type, order_type_parameter=order_type_parameter, referral_id=3981, shared=shared)), as = "parsed")
            }
            if (order_type_parameter == FALSE && stop_loss == FALSE && take_profit == FALSE) {
                data <- content(GET("https://1broker.com/api/v2/order/create.php", query = list(token=token, symbol=symbol, margin=margin, direction=direction, leverage=leverage, order_type=order_type, order_type_parameter=order_type_parameter, referral_id=3981, shared=shared)), as = "parsed")
            }
            result <- TRUE
            cat("Order", data$response$order_id, "created\n")
        },
        error = function(e) {
            cat("Order Create: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Order Create: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Order Create: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response$order_id,
                          data$response$symbol,
                          as.numeric(data$response$margin),
                          as.numeric(data$response$leverage),
                          data$response$direction,
                          data$response$order_type,
                          as.numeric(data$response$order_type_parameter),
                          as.numeric(data$response$stop_loss),
                          as.numeric(data$response$take_profit),
                          data$response$shared,
                          data$response$copy_of,
                          data$response$date_created
                          )
    return(return_vector)

}


order_cancel <- function(order_id) {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/order/cancel.php", query = list(token=token, order_id=order_id)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Order Cancel: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Order Cancel: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Order Cancel: Warning: ", data$warning_message, "\n")}

    return(TRUE)

}


position_open <- function() {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/position/open.php", query = list(token=token)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Position Open: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Position Open: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Position Open: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response)
    return(return_vector)

}


position_history <- function(offset = 0, limit = 20, date_start = "1970-01-01T12:00:00Z", date_end = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ")) {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/position/history.php", query = list(token=token, offset=offset, limit=limit, date_start=date_start, date_end = date_end)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Position History: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Position History: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Position History: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response)
    return(return_vector)

}


position_edit <- function(position_id, stop_loss, take_profit) {
    tryCatch({stop_loss}, error = function(e) {stop_loss <<- FALSE})
    tryCatch({take_profit}, error = function(e) {take_profit <<- FALSE})

    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            if (stop_loss != FALSE && take_profit != FALSE) {
                data <- content(GET("https://1broker.com/api/v2/position/edit.php", query = list(token=token, position_id=position_id, stop_loss=stop_loss, take_profit=take_profit)), as = "parsed")
            }
            if (stop_loss == FALSE && take_profit != FALSE) {
                data <- content(GET("https://1broker.com/api/v2/position/edit.php", query = list(token=token, position_id=position_id, take_profit=take_profit)), as = "parsed")
            }
            if (stop_loss != FALSE  && take_profit == FALSE) {
                data <- content(GET("https://1broker.com/api/v2/position/edit.php", query = list(token=token, position_id=position_id, stop_loss=stop_loss)), as = "parsed")
            }
            if (stop_loss == FALSE  && take_profit == FALSE) {
                data <- content(GET("https://1broker.com/api/v2/position/edit.php", query = list(token=token, position_id=position_id)), as = "parsed")
            }
            result <- TRUE
        },
        error = function(e) {
            cat("Position Edit: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

                                        #  print(str(data))
    if (data$error) {stop("Position Edit: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Position Edit: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response$position_id,
                          as.numeric(data$response$stop_loss),
                          as.numeric(data$response$take_profit)
                          )
    return(return_vector)

}


position_close <- function(position_id) {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/position/close.php", query = list(token=token, position_id=position_id)), as = "parsed")
            print(GET("https://1broker.com/api/v2/position/close.php", query = list(token=token, position_id=position_id)))
            print(data)
            result <- TRUE
        },
        error = function(e) {
            cat("Position Close: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Position Close: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Position Close: Warning: ", data$warning_message, "\n")}

    return(TRUE)

}


position_close_cancel <- function(position_id) {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/position/close_cancel.php", query = list(token=token, position_id=position_id)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Position Close Cancel: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Position Close Cancel: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Position Close Cancel: Warning: ", data$warning_message, "\n")}

    return(TRUE)

}


market_categories <- function() {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/market/categories.php", query = list(token=token)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Market Categories: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Market Categories: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Market Categories: Warning: ", data$warning_message, "\n")}

    return(data$response)

}


market_list <- function(category = "Index") {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/market/list.php", query = list(token=token, category=category)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Market List: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Market List: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Market List: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response)
    return(return_vector)

}


market_details <- function(symbol="BTCUSD") {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/market/details.php", query = list(token=token, symbol=symbol)), as = "parsed")
#            print(GET("https://1broker.com/api/v2/market/details.php", query = list(token=token, symbol=symbol)))
            result <- TRUE
        },
        error = function(e) {
            cat("Market Details: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Market Details: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Market Details: Warning: ", data$warning_message, "\n")}

#    print(data$response)
    return_vector <- list(data$response$symbol,
                          data$response$name,
                          data$response$description,
                          data$response$category,
                          data$response$type,
                          as.numeric(data$response$maximum_leverage),
                          as.numeric(data$response$maximum_amount),
                          as.numeric(data$response$overnight_charge_long_percent),
                          as.numeric(data$response$overnight_charge_short_percent),
                          as.numeric(data$response$decimals))
    return(return_vector)

}


market_quotes <- function(symbols="BTCUSD") {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/market/quotes.php", query = list(token=token, symbols=symbols)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Market Quotes: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Market Quotes: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Market Quotes: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response)
    return(return_vector)

}


market_bars <- function(symbol, resolution = 86400, date_start = "1970-01-01T12:00:00Z", date_end = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ")) {
    result <- NULL
    while( is.null(result) ) {
        tryCatch({
            data <- content(GET("https://1broker.com/api/v2/market/bars.php", query = list(token=token, symbol=symbol, resolution=resolution, date_start=date_start, date_end = date_end)), as = "parsed")
            result <- TRUE
        },
        error = function(e) {
            cat("Market Bars: Error: ", as.character(e), "\n")
            Sys.sleep(60)
            result <- NULL
        })
    }

    if (data$error) {stop("Market Bars: Error: ", data$error_message, "\n")}
    if (data$warning) {warning("Market Bars: Warning: ", data$warning_message, "\n")}

    return_vector <- list(data$response)
    return(return_vector)

}


get_all_quotes <- function() {
    symbols = ""
    categories <- market_categories()
    for (category in categories) {
        list[market] <- market_list(category=category)
        for (i in 1:length(market)) {
            symbols <- paste0(symbols, market[i][[1]]$symbol, sep=",")
            if (i %% 20 == 0 || i == length(market)) {
                symbols <- substr(symbols, 1, nchar(symbols)-1)
                list[quotes] <- market_quotes(symbols=symbols)
                for (j in 1: length(quotes)) {
                    cat(quotes[j][[1]]$symbol, ":", (as.numeric(quotes[j][[1]]$bid) + as.numeric(quotes[j][[1]]$ask)) / 2, "\n")
                }
                symbols = ""
                Sys.sleep(1)
            }
        }
    }
}


