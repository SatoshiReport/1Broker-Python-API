#!/usr/bin/python                                                                                                                                               
from pprint import pprint
from time import sleep
from broker1_api_v2 import *
import dateutil.parser
from itertools import izip_longest

max_quote_request = 20


if __name__ == "__main__":

    print "\n***** User Details"
    pprint(user_details())
    sleep(1)

    print "\n***** User Overview"
    pprint(user_overview())
    sleep(1)

    print "\n***** User Bitcoin Deposit Address"
    pprint(user_bitcoin_deposit_address())
    sleep(1)

    print "\n***** User Transaction Log"
    pprint(user_transaction_log())
    sleep(1)

    print "\n***** Market Categories"
    pprint(market_categories())
    sleep(1)

    print "\n***** Market List"
    for category in market_categories():
        pprint(market_list(category))
        sleep(1)
    
    print "\n***** Market Details"
    for category in market_categories():
        for market in market_list(category):
            if market['symbol'] == "EURUSD":
                pprint(market_details(market['symbol']))
                sleep(1)

    print "\n***** Market Quotes by 20s (current max quote requests)"
    symbols = get_symbols()
    symbols = list(izip_longest(*(iter(symbols),) * max_quote_request))
#    pprint(symbols)

    quotes = []
    for sub_symbols in symbols:
        sub_symbols = [x for x in sub_symbols if x is not None]
        symbol_list = ','.join(sub_symbols)
        for market_quote in market_quotes(symbol_list):
#            print market_quote
            quotes.append((market_quote['symbol'], float(market_quote['bid']), float(market_quote['ask']), dateutil.parser.parse(market_quote['updated'])))
        sleep(1)
    pprint(quotes)

    print "\n***** Market Bars by 20s (current max quote requests)"
    for category in market_categories():
        for market in market_list(category):
            if market['symbol'] == "EURUSD":
                pprint(market_bars(market['symbol']))
                sleep(1)

    print "\n***** Create Stopentry Order (should not be filled)"
    symbol = quotes[0][0]
    bid = quotes[0][1]
    ask = quotes[0][2]
    min_increment = ask - bid # not necessarily true but minimium increment is not given
    margin = 0.01 # minimum allowable margin
    direction = "long" # "long" or "short"
    leverage = 1 # upto max leverage
    order_type = "stop_entry" # "market" or "limit" or "stop_entry"
    order_type_parameter = ask + (min_increment * 10) # Only needed for Limit or Stopentry
    stop_loss = bid - (min_increment * 10)
    take_profit = bid + (min_increment * 10)

    order = order_create(symbol, margin, direction, leverage, order_type, order_type_parameter, stop_loss, take_profit)
    pprint(order)
    sleep(1)

    print "\n****** Show The Open Orders"
    orders = order_open()
    pprint(orders)
    sleep(1)

    print "\n***** Cancel All Open Orders"
    for order in orders:
        order_cancel(int(order['order_id']))
        sleep(1)

    print "\n***** Show The Open Orders (There should be none now)"
    orders = order_open()
    pprint(orders)
    sleep(1)

    print "\n***** Create Market Order"
    symbol = "BTCUSD"
    direction = "short"
    order_type = "market" # "market" or "limit" or "stop_entry"
    order_type_parameter = None
    stop_loss = 2000
    take_profit = 2
    shared = "false"
    order = order_create(symbol, margin, direction, leverage, order_type, order_type_parameter, stop_loss, take_profit, shared)
    pprint(order)
    sleep(1)

    while True:
        if order_open() <> []:
            print "Waiting for the order to fill..."
            sleep(1)
        else:
            print "Order filled."
            break

    print "\n***** Position List Open To Show Filled Order"
    position_list = position_open()
    for position in position_list:
        if position['symbol'] == 'BTCUSD':
            pprint(position)
    sleep(1)

    print "\n***** Position Edit to Change StopLoss and TakeProfit"
    market_close = "false" # "true" or "false"
    stop_loss = 2001
    take_profit = 3
    for position in position_list:
        if position['symbol'] == 'BTCUSD':
            pprint(position_edit(position["position_id"], stop_loss, take_profit))
        sleep(1)

    print "\n***** Position List Open to Show Results"
    position_list = position_open()
    for position in position_list:
        if position['symbol'] == 'BTCUSD':
            pprint(position)
    sleep(1)

    print "\nClose and Close Cancel Position"
    stop_loss = None
    take_profit = None
    for position in position_list:
        if position['symbol'] == 'BTCUSD':
            pprint(position_close(position["position_id"]))
            pprint(position_close_cancel(position["position_id"]))
    sleep(1)

    print "\nClose Position"
    for position in position_list:
        if position['symbol'] == 'BTCUSD':
            pprint(position_close(position["position_id"]))
    sleep(1)

    for position in position_open():
        if position['symbol'] == 'BTCUSD':
            print "Waiting for the position to close..."
        else:
            print "Position closed."
            break
        sleep(1)

    print "\nPosition List Open to Show No More Open Positions"
    position_list = position_open()
    for position in position_list:
        if position['symbol'] == 'BTCUSD':
            pprint(position)
    sleep(1)

    print "\nPosition List History to Show Two Last Positions"
    limit = 2
    offset = 0
    pprint(position_history(offset, limit))
    sleep(1)
