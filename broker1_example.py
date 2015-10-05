#!/usr/bin/python                                                                                                                                               
from pprint import pprint
from time import sleep
import logging
from broker1_api import *
import dateutil.parser
from itertools import izip_longest

max_quote_request = 20


if __name__ == "__main__":

    file_log = "1broker.log"

    logging.getLogger('').handlers = []
    logging.basicConfig(filename=file_log, level=logging.INFO, format='%(asctime)s %(funcName)s [%(levelname)s] %(message)s')

    print "\n***** Access Account Info"
    pprint(account_info())
    sleep(1)

    print "\n***** Account Bitcoin Deposit Address"
    pprint(account_bitcoindepositaddress())
    sleep(1)

    print "\n***** Market List"
    market_list = market_list()
    pprint(market_list)
    sleep(1)
    
    print "\n***** Market Details"
    for market in market_list:
        pprint(market_detail(market['symbol']))
        sleep(1)

    print "\n***** Market Quotes by Category"
    symbols = get_category_and_symbols(market_list)
    quotes = []
    pprint(symbols)

    for sub_symbols in symbols:
        symbol_list = ','.join(sub_symbols[1])
        for market_quote in market_quotes(symbol_list):
            print market_quote
            quotes.append((market_quote['symbol'], float(market_quote['bid']), float(market_quote['ask']), dateutil.parser.parse(market_quote['updated'])))
        sleep(1)
    pprint(quotes)

    print "\n***** Market Quotes by 20s (current max quote requests)"
    symbols = get_symbols(market_list)
    symbols = list(izip_longest(*(iter(symbols),) * max_quote_request))
    pprint(symbols)

    quotes = []
    for sub_symbols in symbols:
        sub_symbols = [x for x in sub_symbols if x is not None]
        symbol_list = ','.join(sub_symbols)
        for market_quote in market_quotes(symbol_list):
            print market_quote
            quotes.append((market_quote['symbol'], float(market_quote['bid']), float(market_quote['ask']), dateutil.parser.parse(market_quote['updated'])))
        sleep(1)
    pprint(quotes)

    print "\n***** Create Stopentry Order (should not be filled)"
    symbol = quotes[0][0]
    bid = quotes[0][1]
    ask = quotes[0][2]
    min_increment = ask - bid # not necessarily true but minimium increment is not given
    margin = 0.01 # minimum allowable margin
    direction = "long" # "long" or "short"
    leverage = 1 # upto max leverage
    order_type = "Stopentry" # "Market" or "Limit" or "Stopentry"
    order_type_parameter = ask + (min_increment * 10) # Only needed for Limit or Stopentry
    stop_loss = bid - (min_increment * 10)
    take_profit = bid + (min_increment * 10)

    order = order_create(symbol, margin, direction, leverage, order_type, order_type_parameter, stop_loss, take_profit)
    pprint(order)
    sleep(1)

    print "\n****** Show The Open Orders"
    orders = order_list_open()
    pprint(orders)
    sleep(1)

    print "\n***** Cancel All Open Orders"
    for order in orders:
        order_cancel(int(order['order_id']))
        sleep(1)

    print "\n***** Show The Open Orders (There should be none now)"
    orders = order_list_open()
    pprint(orders)
    sleep(1)

    print "\n***** Create Market Order"
    order_type = "Market" # "Market" or "Limit" or "Stopentry"
    order_type_parameter = None
    stop_loss = bid - (min_increment * 100)
    take_profit = bid + (min_increment * 100)
    order = order_create(symbol, margin, direction, leverage, order_type, order_type_parameter, stop_loss, take_profit)
    pprint(order)
    sleep(1)

    while True:
        if order_list_open() <> []:
            print "Waiting for the order to fill..."
            sleep(1)
        else:
            break

    print "\n***** Position List Open To Show Filled Order"
    position_list = position_list_open()
    pprint(position_list)
    sleep(1)

    print "\n***** Position Edit to Change StopLoss and TakeProfit"
    market_close = "false" # "true" or "false"
    stop_loss = bid - (min_increment * 100)
    take_profit = bid + (min_increment * 100)
    for position in position_list:
        pprint(position_edit(position["position_id"], market_close, stop_loss, take_profit))
        sleep(1)

    print "\n***** Position List Open to Show Results"
    position_list = position_list_open()
    pprint(position_list)
    sleep(1)

    print "\nPosition Edit to Close Position with MarketClose"
    market_close = "true" # "true" or "false"
    stop_loss = None
    take_profit = None
    for position in position_list:
        pprint(position_edit(position["position_id"], market_close, stop_loss, take_profit))
        sleep(1)

    while True:
        if position_list_open() <> []:
            print "Waiting for the position to close..."
            sleep(1)
        else:
            break

    print "\nPosition List Open to Show No More Open Positions"
    position_list = position_list_open()
    pprint(position_list)
    sleep(1)

    print "\nPosition List History to Show Two Last Positions"
    limit = 2
    offset = None
    pprint(position_list_history(limit, offset))
    sleep(1)
