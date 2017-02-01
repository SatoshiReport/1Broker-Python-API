#!/usr/bin/python                                                                                                                                               
from HttpMD5Util import httpGet
import os
import datetime


token = os.environ["BROKER1_TOKEN_V2"]
url = "https://1broker.com"
source = "1Broker"
resource_header = "/api/v2/"


def error_check(result):

    if result['warning']:
        string = source + " warning: " + str(result['warning_message'])
        print string
    if result['error']:
        string = source + " error[" + str(result['error_code']) + "]: " + str(result['error_message'])
        print string


def user_details():

    resource = resource_header + "user/details.php"
    params = {
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def user_overview():

    resource = resource_header + "user/overview.php"
    params = {
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def user_bitcoin_deposit_address():

    resource = resource_header + "user/bitcoin_deposit_address.php"
    params = {
        "token": token
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def date_start_string():
    return str(datetime.datetime.fromtimestamp(0).isoformat()) + "Z"

def date_end_string():
    return str(datetime.datetime.utcnow().isoformat()) + "Z"

def user_transaction_log(offset=0, limit=20, date_start=date_start_string(), date_end=date_end_string()):

    print "date start: ", date_start
    print "date end: ", date_end

    resource = resource_header + "user/transaction_log.php"

    params = {
        "token": token,
        "offset": offset, 
        "limit": limit,
        "date_start": date_start,
        "date_end": date_end
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def order_open():

    resource = resource_header + "order/open.php"
    params = {
        "token": token
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def order_create(symbol, margin, direction, leverage, order_type, order_type_parameter, stop_loss=None, take_profit=None, shared="false"):

    resource = resource_header + "order/create.php"
    params = {
        "symbol" : symbol,
        "margin" : margin,
        "direction" : direction,
        "leverage" : leverage,
        "order_type" : order_type,
        "order_type_parameter" : order_type_parameter,
        "token" : token,
        "referral_id" : 3981,
        "stop_loss": stop_loss,
        "take_profit": take_profit,
        "shared": shared
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def order_cancel(order_id):

    resource = resource_header + "order/cancel.php"
    params = {
        "order_id" : order_id,
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def position_open():

    resource = resource_header + "position/open.php"
    params = {
        "token": token
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def position_history(offset=0, limit=20, date_start=date_start_string(), date_end=date_end_string()):

    resource = resource_header + "position/history.php"
    params = {
        "token": token,
        "offset": offset,
        "limit": limit,
        "date_start": date_start,
        "date_end": date_end
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def position_edit(position_id, stop_loss=None, take_profit=None):

    resource = resource_header + "position/edit.php"
    params = {
        "position_id" : position_id,
        "token" : token,
        "stop_loss": stop_loss,
        "take_profit": take_profit
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def position_close(position_id):

    resource = resource_header + "position/close.php"
    params = {
        "position_id" : position_id,
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def position_close_cancel(position_id):

    resource = resource_header + "position/close_cancel.php"
    params = {
        "position_id" : position_id,
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def market_categories():

    resource = resource_header + "market/categories.php"
    params = {
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def market_list(category):

    resource = resource_header + "market/list.php"
    params = {
        "token" : token,
        "category" : category
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def market_details(symbol):

    resource = resource_header + "market/details.php"
    params = {
        "symbol" : symbol,
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def market_quotes(symbols):

    resource = resource_header + "market/quotes.php"
    params = {
        "symbols" : symbols,
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def market_bars(symbol, resolution = 86400, date_start=date_start_string(), date_end=date_end_string()):

    resource = resource_header + "market/bars.php"
    params = {
        "symbol" : symbol,
        "token" : token,
        "resolution" : resolution,
        "date_start" : date_start, 
        "date_end" : date_end
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def get_symbols():

    symbols = []
    for category in market_categories():
        for market in market_list(category):
            symbols.append(market['symbol'])

    return symbols


def get_category_and_symbols():

    categories = []
    for category in market_categories():
        for market in market_list():
            if market['category'] not in categories:
                categories.append(market['category'])

    symbols = []
    for category in categories:
        temp_symbols = []
        for market in market_list():
            if category == market['category']:
                temp_symbols.append(market['symbol'])
                symbols.append((category, temp_symbols))

    return symbols


