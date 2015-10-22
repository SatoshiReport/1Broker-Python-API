#!/usr/bin/python

import httplib
import urllib
import json
import hashlib
import time
import logging
import notify

sleep_time = 10
sleep_max = 60 * 5
source_flag = {"@OKCoinBTC", "@1BrokerCom"}


def buildMySign(params, secretKey):
    sign = ''
    for key in sorted(params.keys()):
        sign += key + '=' + str(params[key]) +'&'
    data = sign+'secret_key='+secretKey
    return  hashlib.md5(data.encode("utf8")).hexdigest().upper()


def httpGet(url, resource, params, source):
    sleep_count = 0
    sleep_alarm = False
    if source == "btc_usd":
        source = "@OKCoinBTC"

    while True:

        # For testing only
        # conn = httplib.HTTPSConnection(url, timeout=sleep_time/2)
        # temp_params = urllib.urlencode(params)
        # print "temp_params: ", temp_params
        # conn.request("GET", resource + '?' + temp_params)
        # response = conn.getresponse()
        # data = response.read().decode('utf-8')
        # print "response: ", data
        # data = json.loads(data)

        try:
            conn = httplib.HTTPSConnection(url, timeout=sleep_time)
            temp_params = urllib.urlencode(params)
            conn.request("GET", resource + '?' + temp_params)
            response = conn.getresponse()
            data = json.loads(response.read().decode('utf-8'))
        except:
            if sleep_count == 0:
                start_time = str(time.strftime("%a %H:%M %Z", time.localtime()))
            time.sleep(1) # Safety in case http timeout is not called
            sleep_count += (sleep_time + 1)
            logging.info("Sleeping in httpGet, " + str(sleep_count) + " seconds")
            if sleep_alarm == False and sleep_count >= sleep_max:
                string = source + " has been down for over " + str(sleep_max/60) + " minutes"
                logging.info(string)
                sleep_alarm = True
            continue
        else:
            if sleep_alarm == True:
                string = source + " is now back up after being down since " + start_time
                logging.info(string)
                sleep_count = 0
                sleep_alarm = False
            break

    return data


def httpPost(url, resource, params, source):
     headers = {
            "Content-type" : "application/x-www-form-urlencoded",
     }
     sleep_count = 0
     sleep_alarm = False

     while True:

        # For testing only
#        conn = httplib.HTTPSConnection(url, timeout=sleep_time/2)
#        print "conn: ", conn
#        temp_params = urllib.urlencode(params)
#        print "temp_params: ", temp_params
#        conn.request("POST", resource, temp_params, headers)
#        response = conn.getresponse()
#        print "response: ", response
#        data = response.read().decode('utf-8')
#        params.clear()
#        conn.close()

        try:
            conn = httplib.HTTPSConnection(url, timeout=sleep_time)
            temp_params = urllib.urlencode(params)
            conn.request("POST", resource, temp_params, headers)
            response = conn.getresponse()
            data = response.read().decode('utf-8')
            params.clear()
            conn.close()
        except:
            if sleep_count == 0:
                start_time = str(time.strftime("%a %H:%M %Z", time.localtime()))
            time.sleep(1) # Safety in case http timeout is not called
            sleep_count += (sleep_time + 1)
            logging.info("Sleeping in httpPost, " + str(sleep_count) + " seconds")
            if sleep_alarm == False and sleep_count >= sleep_max:
                string = source + " has been down for over " + str(sleep_max/60) + " minutes"
                logging.info(string)
                sleep_alarm = True
            continue
        else:
            if sleep_alarm == True:
                string = source + " is now back up after being down since " + start_time
                logging.info(string)
                sleep_count = 0
                sleep_alarm = False
            break

     return data


        
     
