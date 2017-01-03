source("1brokerv2.R")

token <- Sys.getenv("BROKER1_TOKEN_V2")

result <- use_token(token=token)
if (result) {
    cat("Token", token, "has been set\n")
} else {
    cat("Token", token, "has NOT been set.  Be sure to set a valid token.\n")
}
cat("\n")


list[username, email, balance, deposit_unconfirmed, date_created] <- user_details()
cat("username: ", username, "\n")
cat("email: ", email, "\n")
cat("balance: ", balance, "\n")
cat("deposit_unconfirmed: ", deposit_unconfirmed, "\n")
cat("date_created: ", date_created, "\n")
cat("deposit_unconfirmed: ", deposit_unconfirmed, "\n")
cat("\n")


list[username, email, balance, deposit_unconfirmed, date_created, orders_worth, positions_worth, net_worth, orders_open, positions_open] <- user_overview()

cat("username: ", username, "\n")
cat("email: ", email, "\n")
cat("balance: ", balance, "\n")
cat("deposit_unconfirmed: ", deposit_unconfirmed, "\n")
cat("date_created: ", date_created, "\n")
cat("orders_worth: ", orders_worth, "\n")
cat("positions_worth: ", positions_worth, "\n")
cat("net_worth: ", net_worth, "\n")
if (length(orders_open) >= 1) {
    for (i in 1: length(orders_open)) {
        cat("orders_open[", i, "], order_id: ", orders_open[i][[1]]$order_id, "\n")
        cat("orders_open[", i, "], symbol: ", orders_open[i][[1]]$symbol, "\n")
        cat("orders_open[", i, "], margin: ", orders_open[i][[1]]$margin, "\n")
        cat("orders_open[", i, "], leverage: ", orders_open[i][[1]]$leverage, "\n")
        cat("orders_open[", i, "], direction: ", orders_open[i][[1]]$direction, "\n")
        cat("orders_open[", i, "], order_type: ", orders_open[i][[1]]$order_type, "\n")
        cat("orders_open[", i, "], order_type_parameter: ", orders_open[i][[1]]$order_type_parameter, "\n")
        cat("orders_open[", i, "], stop_loss: ", orders_open[i][[1]]$stop_loss, "\n")
        cat("orders_open[", i, "], take_profit: ", orders_open[i][[1]]$take_profit, "\n")
        cat("orders_open[", i, "], shared: ", orders_open[i][[1]]$shared, "\n")
        cat("orders_open[", i, "], copy_of: ", orders_open[i][[1]]$copy_of, "\n")
        cat("orders_open[", i, "], date_created: ", orders_open[i][[1]]$date_created, "\n")
    }
} else {
    cat("order_open: NA\n")
}
if (length(positions_open) >= 1) {
    for (i in 1: length(positions_open)) {
        cat("positions_open[", i, "], position_id: ", positions_open[i][[1]]$position_id, "\n")
        cat("positions_open[", i, "], order_id: ", positions_open[i][[1]]$order_id, "\n")
        cat("positions_open[", i, "], symbol: ", positions_open[i][[1]]$symbol, "\n")
        cat("positions_open[", i, "], margin: ", positions_open[i][[1]]$margin, "\n")
        cat("positions_open[", i, "], leverage: ", positions_open[i][[1]]$leverage, "\n")
        cat("positions_open[", i, "], direction: ", positions_open[i][[1]]$direction, "\n")
        cat("positions_open[", i, "], entry_price: ", positions_open[i][[1]]$entry_price, "\n")
        cat("positions_open[", i, "], profit_loss: ", positions_open[i][[1]]$profit_loss, "\n")
        cat("positions_open[", i, "], profit_loss_percent: ", positions_open[i][[1]]$profit_loss_percent, "\n")
        cat("positions_open[", i, "], value: ", positions_open[i][[1]]$value, "\n")
        cat("positions_open[", i, "], market_close: ", positions_open[i][[1]]$market_close, "\n")
        cat("positions_open[", i, "], stop_loss: ", positions_open[i][[1]]$stop_loss, "\n")
        cat("positions_open[", i, "], take_profit: ", positions_open[i][[1]]$take_profit, "\n")
        cat("positions_open[", i, "], shared: ", positions_open[i][[1]]$shared, "\n")
        cat("positions_open[", i, "], copy_of: ", positions_open[i][[1]]$copy_of, "\n")
        cat("positions_open[", i, "], date_created: ", positions_open[i][[1]]$date_created, "\n")
    }
} else {
    cat("positions_open: NA\n")
}
cat("\n")


list[bitcoin_deposit_address, two_factor_authentication] <- user_bitcoin_deposit_address()
cat("bitcoin_deposit_address: ", bitcoin_deposit_address, "\n")
cat("two_factor_authentication: ", two_factor_authentication, "\n")
cat("\n")


list[transaction_log] <- user_transaction_log(limit = 1)

if (length(transaction_log) >= 1) {
    for (i in 1: length(transaction_log)) {
        cat("transaction_log[", i, "], date: ", transaction_log[i][[1]]$date, "\n")
        cat("transaction_log[", i, "], type: ", transaction_log[i][[1]]$type, "\n")
        cat("transaction_log[", i, "], balance_delta: ", transaction_log[i][[1]]$balance_delta, "\n")
        cat("transaction_log[", i, "], balance_new: ", transaction_log[i][[1]]$balance_new, "\n")
        cat("transaction_log[", i, "], description: ", transaction_log[i][[1]]$description, "\n")}
} else {
    cat("transaction_log: NA\n")
}
cat("\n")


list[order_id, symbol, margin, leverage, direction, order_type, order_type_parameter, stop_loss, take_profit, shared, copy_of, date_created] <- order_create(symbol = "BTCUSD", margin = 0.01, direction="long")
cat("order_id: ", order_id, "\n")
cat("symbol: ", symbol, "\n")
cat("margin: ", margin, "\n")
cat("leverage: ", leverage, "\n")
cat("direction: ", direction, "\n")
cat("order_type: ", order_type, "\n")
cat("order_type_parameter: ", order_type_parameter, "\n")
cat("stop_loss: ", stop_loss, "\n")
cat("take_profit: ", take_profit, "\n")
cat("shared: ", shared, "\n")
cat("copy_of: ", copy_of, "\n")
cat("date_created: ", date_created, "\n")
cat("\n")


list[open] <- order_open()

if (length(open) >= 1) {
    for (i in 1: length(open)) {
        cat("orders_open[", i, "], order_id: ", open[i][[1]]$order_id, "\n")
        cat("orders_open[", i, "], symbol: ", open[i][[1]]$symbol, "\n")
        cat("orders_open[", i, "], margin: ", open[i][[1]]$margin, "\n")
        cat("orders_open[", i, "], leverage: ", open[i][[1]]$leverage, "\n")
        cat("orders_open[", i, "], direction: ", open[i][[1]]$direction, "\n")
        cat("orders_open[", i, "], order_type: ", open[i][[1]]$order_type, "\n")
        cat("orders_open[", i, "], order_type_parameter: ", open[i][[1]]$order_type_parameter, "\n")
        cat("orders_open[", i, "], stop_loss: ", open[i][[1]]$stop_loss, "\n")
        cat("orders_open[", i, "], take_profit: ", open[i][[1]]$take_profit, "\n")
        cat("orders_open[", i, "], shared: ", open[i][[1]]$shared, "\n")
        cat("orders_open[", i, "], copy_of: ", open[i][[1]]$copy_of, "\n")
        cat("orders_open[", i, "], date_created: ", open[i][[1]]$date_created, "\n")
    }
} else {
    cat("orders_open: NA\n")
}
cat("\n")


result <- order_cancel(order_id=order_id)
if (result) {
    cat("Order", order_id, "cancellation has been submitted\n")
} else {
    cat("Order", order_id, "cancellation has NOT been submitted\n")
}
cat("\n")


list[open] <- position_open()

if (length(open) >= 1) {
    for (i in 1: length(open)) {
        cat("position_open[", i, "], position_id: ", open[i][[1]]$position_id, "\n")
        cat("position_open[", i, "], order_id: ", open[i][[1]]$order_id, "\n")
        cat("position_open[", i, "], symbol: ", open[i][[1]]$symbol, "\n")
        cat("position_open[", i, "], margin: ", open[i][[1]]$margin, "\n")
        cat("position_open[", i, "], leverage: ", open[i][[1]]$leverage, "\n")
        cat("position_open[", i, "], direction: ", open[i][[1]]$direction, "\n")
        cat("position_open[", i, "], entry_price: ", open[i][[1]]$entry_price, "\n")
        cat("position_open[", i, "], profit_loss: ", open[i][[1]]$profit_loss, "\n")
        cat("position_open[", i, "], profit_loss_percent: ", open[i][[1]]$profit_loss_percent, "\n")
        cat("position_open[", i, "], value: ", open[i][[1]]$value, "\n")
        cat("position_open[", i, "], market_close: ", open[i][[1]]$market_close, "\n")
        cat("position_open[", i, "], stop_loss: ", open[i][[1]]$stop_loss, "\n")
        cat("position_open[", i, "], take_profit: ", open[i][[1]]$take_profit, "\n")
        cat("position_open[", i, "], shared: ", open[i][[1]]$shared, "\n")
        cat("position_open[", i, "], copy_of: ", open[i][[1]]$copy_of, "\n")
        cat("position_open[", i, "], date_created: ", open[i][[1]]$date_created, "\n")
    }
} else {
    cat("position_open: NA\n")
}
cat("\n")


list[history] <- position_history(limit = 3)

if (length(history) >= 1) {
    for (i in 1: length(history)) {
        cat("position_history[", i, "], position_id: ", history[i][[1]]$position_id, "\n")
        cat("position_history[", i, "], order_id: ", history[i][[1]]$order_id, "\n")
        cat("position_history[", i, "], symbol: ", history[i][[1]]$symbol, "\n")
        cat("position_history[", i, "], margin: ", history[i][[1]]$margin, "\n")
        cat("position_history[", i, "], leverage: ", history[i][[1]]$leverage, "\n")
        cat("position_history[", i, "], direction: ", history[i][[1]]$direction, "\n")
        cat("position_history[", i, "], entry_price: ", history[i][[1]]$entry_price, "\n")
        cat("position_history[", i, "], exit_price: ", history[i][[1]]$exit_price, "\n")
        cat("position_history[", i, "], profit_loss: ", history[i][[1]]$profit_loss, "\n")
        cat("position_history[", i, "], profit_loss_percent: ", history[i][[1]]$profit_loss_percent, "\n")
        cat("position_history[", i, "], value: ", history[i][[1]]$value, "\n")
        cat("position_history[", i, "], stop_loss: ", history[i][[1]]$stop_loss, "\n")
        cat("position_history[", i, "], take_profit: ", history[i][[1]]$take_profit, "\n")
        cat("position_history[", i, "], shared: ", history[i][[1]]$shared, "\n")
        cat("position_history[", i, "], copy_of: ", history[i][[1]]$copy_of, "\n")
        cat("position_history[", i, "], date_created: ", history[i][[1]]$date_created, "\n")
        cat("position_history[", i, "], date_closed: ", history[i][[1]]$date_closed, "\n")
    }
} else {
    cat("position_history: NA\n")
}
cat("\n")


list[order_id, symbol, margin, leverage, direction, order_type, order_type_parameter, stop_loss, take_profit, shared, copy_of, date_created] <- order_create(symbol = "BTCUSD", margin = 0.01, direction="long")
result <- NULL
while( is.null(result) ) {
    list[open] <- position_open()
    if (length(open) >= 1) {
        for (i in 1: length(open)) {
            if (open[i][[1]]$symbol == "BTCUSD") {
                position_id <- open[i][[1]]$position_id
                result <- TRUE
                cat("Order executed.\n")
            }
        }
    }
    if (is.null(result)) {
        cat("Waiting for order to be exceuted.\n")
        Sys.sleep(1)
    }
}
cat("\n")

list[position_id, stop_loss, take_profit] <- position_edit(position_id=position_id)
cat("position_id: ", position_id, "\n")
cat("stop_loss: ", stop_loss, "\n")
cat("take_profit: ", take_profit, "\n")
cat("\n")

list[position_id, stop_loss, take_profit] <- position_edit(position_id=position_id, take_profit=9000)
cat("position_id: ", position_id, "\n")
cat("stop_loss: ", stop_loss, "\n")
cat("take_profit: ", take_profit, "\n")
cat("\n")

list[position_id, stop_loss, take_profit] <- position_edit(position_id=position_id, stop_loss= 500)
cat("position_id: ", position_id, "\n")
cat("stop_loss: ", stop_loss, "\n")
cat("take_profit: ", take_profit, "\n")
cat("\n")

list[position_id, stop_loss, take_profit] <- position_edit(position_id=position_id, take_profit=9000, stop_loss=500)
cat("position_id: ", position_id, "\n")
cat("stop_loss: ", stop_loss, "\n")
cat("take_profit: ", take_profit, "\n")
cat("\n")


result <- position_close(position_id=position_id)
if (result) {
    cat("Position", position_id, "close has been submitted\n")
} else {
    cat("Position", position_id, "close has NOT been submitted\n")
}


result <- position_close_cancel(position_id=position_id)
if (result) {
    cat("Position", position_id, "close cancel has been submitted\n")
} else {
    cat("Position", position_id, "close cancel has NOT been submitted\n")
}
cat("\n")


categories <- market_categories()
for (category in categories) {
    cat("market_category: ", category, "\n")
}
cat("\n")


categories <- market_categories()
for (category in categories) {
    list[market] <- market_list(category=category)
    for (i in 1: length(market)) {
        cat("market_list[", i, "], symbol: ", market[i][[1]]$symbol, "\n")
        cat("market_list[", i, "], name: ", market[i][[1]]$name, "\n")
        cat("market_list[", i, "], category: ", market[i][[1]]$category, "\n")
        cat("market_list[", i, "], type: ", market[i][[1]]$type, "\n")
    }
}
cat("\n")


list[symbol, name, description, category, type, maximun_leverage, maximum_amount, overnight_charge_long_percent, overnight_charge_short_percent, decimals] <- market_details()
cat("symbol: ", symbol, "\n")
cat("name: ", name, "\n")
cat("description: ", description, "\n")
cat("category: ", category, "\n")
cat("type: ", type, "\n")
cat("maximum_leverage: ", maximum_leverage, "\n")
cat("maximum_amount: ", maximum_amount, "\n")
cat("overnight_charge_long_percent: ", overnight_charge_long_percent, "\n")
cat("overnight_charge_short_percent: ", overnight_charge_short_percent, "\n")
cat("decimals: ", decimals, "\n")
cat("\n")


list[quotes] <- market_quotes(symbols='EURUSD')
for (i in 1: length(quotes)) {
    cat("market_quotes[", i, "], symbol: ", quotes[i][[1]]$symbol, "\n")
    cat("market_quotes[", i, "], bid: ", quotes[i][[1]]$bid, "\n")
    cat("market_quotes[", i, "], ask: ", quotes[i][[1]]$ask, "\n")
    cat("market_quotes[", i, "], updated: ", quotes[i][[1]]$updated, "\n")
}
cat("\n")

list[quotes] <- market_quotes()
for (i in 1: length(quotes)) {
    cat("market_quotes[", i, "], symbol: ", quotes[i][[1]]$symbol, "\n")
    cat("market_quotes[", i, "], bid: ", quotes[i][[1]]$bid, "\n")
    cat("market_quotes[", i, "], ask: ", quotes[i][[1]]$ask, "\n")
    cat("market_quotes[", i, "], updated: ", quotes[i][[1]]$updated, "\n")
}
cat("\n")

list[quotes] <- market_quotes(symbols='EURUSD,GOLD')
for (i in 1: length(quotes)) {
    cat("market_quotes[", i, "], symbol: ", quotes[i][[1]]$symbol, "\n")
    cat("market_quotes[", i, "], bid: ", quotes[i][[1]]$bid, "\n")
    cat("market_quotes[", i, "], ask: ", quotes[i][[1]]$ask, "\n")
    cat("market_quotes[", i, "], updated: ", quotes[i][[1]]$updated, "\n")
}
cat("\n")


list[bars] <- market_bars(symbol = "EURUSD")

if (length(history) >= 1) {
    for (i in 1: length(history)) {
        cat("market_bars[", i, "], date: ", bars[i][[1]]$date, "\n")
        cat("market_bars[", i, "], open: ", bars[i][[1]]$o, "\n")
        cat("market_bars[", i, "], high: ", bars[i][[1]]$h, "\n")
        cat("market_bars[", i, "], low: ", bars[i][[1]]$l, "\n")
        cat("market_bars[", i, "], close: ", bars[i][[1]]$c, "\n")
    }
} else {
    cat("market_bars: NA\n")
}
cat("\n")


get_all_quotes()
