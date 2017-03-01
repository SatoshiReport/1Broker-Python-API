# 1Broker
Python API for 1Broker (version 2 of their API)

1Broker provides Forex and CFD trading with bitcoin.  They can be accessed here:
https://1broker.com/?r=3981

You will need to set the variable "token" in the top of broker1_api_v2.py with your 1Broker API token which is found on their website under "Access & API Management".

We have three files:
* HttpMD5Util.py - Used for HttpGet calls
* broker1_api_v2.py - Provides a complete library of all 1Broker API calls
* broker1_example_v2.py - Test script to exercise the API completely (a minor amount of bitcoin is needed to test trades)
