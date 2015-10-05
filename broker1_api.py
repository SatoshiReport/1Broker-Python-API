#!/usr/bin/python                                                                                                                                               
from HttpMD5Util import httpGet
import logging
import os


token = os.environ["BROKER1_TOKEN"]
url = "1broker.com"
source = "1Broker"
resource_header = "/api/v1/"


def error_check(result):

    if result['warning']:
        string = source + " warning: " + result['warning_message']
        print string
        logging.warning(string)
    if result['error']:
        string = source + " error[" + result['error_code'] + "]: " + result['error_message']
        print string
        logging.warning(string)


def account_info():

    resource = resource_header + "account/info.php"
    params = {
        "token" : token
    }

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def account_bitcoindepositaddress():

    resource = resource_header + "account/bitcoindepositaddress.php"
    params = {
        "token": token
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def order_list_open():

    resource = resource_header + "order/list_open.php"
    params = {
        "token": token
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def order_create(symbol, margin, direction, leverage, order_type, order_type_parameter, stop_loss, take_profit):

    resource = resource_header + "order/create.php"
    params = {
        "symbol" : symbol,
        "margin" : margin,
        "direction" : direction,
        "leverage" : leverage,
        "order_type" : order_type,
        "order_type_parameter" : order_type_parameter,
        "token" : token
    }
    if stop_loss:
        params["stop_loss"] = stop_loss
    if take_profit:
        params["take_profit"] = take_profit

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


def position_list_open():

    resource = resource_header + "position/list_open.php"
    params = {
        "token": token
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def position_list_history(limit, offset):

    resource = resource_header + "position/list_history.php"
    params = {
        "token": token
    }   

    if limit:
        params["limit"] = limit
    if offset:
        param["offset"] = offset

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def position_edit(position_id, market_close, stop_loss, take_profit):

    resource = resource_header + "position/edit.php"
    params = {
        "position_id" : position_id,
        "token" : token
    }
    if market_close:
        params["market_close"] = market_close
    if stop_loss:
        params["stop_loss"] = stop_loss
    if take_profit:
        params["take_profit"] = take_profit

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def market_list():

    resource = resource_header + "market/list.php"
    params = {
        "token" : token
    }   

    result = httpGet(url, resource, params, source)
    error_check(result)

    return result['response']


def market_detail(symbol):

    resource = resource_header + "market/detail.php"
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


def get_category_and_symbols(market_list):

    categories = []
    for market in market_list:
        if market['category'] not in categories:
            categories.append(market['category'])

    symbols = []
    for category in categories:
        temp_symbols = []
        for market in market_list:
            if category == market['category']:
                temp_symbols.append(market['symbol'])
        symbols.append((category, temp_symbols))

    return symbols


def get_symbols(market_list):

    symbols = []
    for market in market_list:
        symbols.append(market['symbol'])

    return symbols



