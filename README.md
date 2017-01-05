# 1Broker
Python and R API for 1Broker (version 2 of their API)

1Broker provides Forex and CFD trading with bitcoin.  They can be accessed here:
https://1broker.com/?c=en/action/r&i=3981

Regardless of which language you use, you will need to set the variable "token" in the top of broker1_api_v2.py or 1brokerv2_test.R with your 1Broker API token which is found on their website under "Access & API Management".

For Python we have three files:
* HttpMD5Util.py - Used for HttpGet calls
* broker1_api_v2.py - Provides a complete library of all 1Broker API calls
* broker1_example_v2.py - Test script to exercise the API completely (a minor amount of bitcoin is needed to test trades)

For R we have two files:
* 1broker.R - Provides a complete library of all 1Broker API calls
* 1brokerv2_test.R - Test script to exercise the API completely (a minor amount of bitcoin is needed to test trades)
