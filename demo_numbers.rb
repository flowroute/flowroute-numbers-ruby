
#Specify required libraries and gems
require 'flowroute_numbers'
require 'rubygems'

#Your Flowroute API credentials
FlowrouteNumbers::Configuration.username = 'access_key'
FlowrouteNumbers::Configuration.password = 'secret_key' 

#Instantiating FLowroute Numbers Controllers
pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()
tnc = FlowrouteNumbers::TelephoneNumbersController.new()
irc = FlowrouteNumbers::InboundRoutesController.new()     

#List Available NPAs
response = pnc.list_available_np_as(limit:nil)

#List NPA and NXX
response = pnc.list_area_and_exchange(limit:nil, npa:nil, page:nil)

#Search
response = pnc.search(limit:3, npa:206, nxx:641, page:2,ratecenter:"SEATTLE", state:"WA", tn:nil)

#List Routes
response = irc.list(limit:10, page:1)

puts response 
