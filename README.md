# flowroute-numbers-ruby
## What is it?

Flowroute-numbers-ruby is a ruby API Wrapper that provides methods for interacting with [Flowroute's](https://www.flowroute.com) v1 API. These methods can be used to accomplish the following:

* Search for purchasable phone numbers
* Purchase phone numbers
* View your owned phone numbers and their related details
* Create new inbound routes
* Update the primary and failover route on a phone number

## Documentation 
The full documentation for Flowroute's v1 API is available at [Developer.flowroute.com](https://developer.flowroute.com/).

## How To Install 

The SDK uses the UniRest ruby library, which will need to be installed before you can use the SDK. To install this package, open a terminal session and execute the following commands

	cd flowroute-numbers-ruby/
	gem build flowroute_numbers.gemspec
	gem install flowroute_numbers-1.0.gem

> Note: You will need to be connected to the internet in order to install the required packages
  
## How To Get Setup

The following shows how to import the SDK and setup your API credentials.

1) Import the SDK module:

	require 'flowroute_numbers'

> Depending on your file system structure, you may need to explicitly state the location of the flowroute_numbers SDK.       
   
2) Configure your API Username and Password from [Flowroute Manager](https://manage.flowroute.com/accounts/preferences/beta/).
 > If you do not have an API Key contact support@flowroute.com:

	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'
	
> These variables can also be hard coded in the Configuration.rb file instead of being overwritten in code. If you go this route, you will need to rebuild the gem and install the new gem.

3) Instantiate your controllers for later use

	pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()
	tnc = FlowrouteNumbers::TelephoneNumbersController.new()
	irc = FlowrouteNumbers::InboundRoutesController.new()     
	
> If you do not want to assign variable names to the controllers and pass your credentials to each controller, you can just hard code the credentials in Configuration.php and call each controller by its full name.

## List of Methods and Example Uses

### PurchasablePhoneNumbersController

The Purchasable Phone Numbers Controller contains all of the methods neccesary to search through Flowroute's phone number inventory. 

#### list_available\_np\_as limit:nil

The list_available\_np\_as method allows you to retrieve a list of every NPA (area code) available in Flowroute's phone number inventory.

| Parameter | Required | Usage                                 |
|-----------|----------|---------------------------------------|
| limit     | False    | Controls the number of items returned (Max 200) |

##### Example Usage
	
	response = pnc.list_available_np_as(limit:10)
	puts response

#### list_area_and_exchange limit: nil, npa: nil, page: nil

The list_area_and_exchange method allows you to retrieve a list of every NPA-NXX (area code and exchange) available in Flowroute's phone number inventory.

| Parameter | Required | Usage                                                         |
|-----------|----------|---------------------------------------------------------------|
| limit     | False    | Controls the number of items returned (Max 200)                         |
| npa       | False    | Limits results to the specified NPA (also known as area code) |
| page      | False    | Determines which page of the results is returned              |

##### Example Usage
		
	response = pnc.list_area_and_exchange(limit:1, npa:206, page:2)
	puts response
	
#### search limit: nil, npa: nil, nxx: nil, page: nil, ratecenter: nil, state: nil, tn: nil

The search method is the most robust option for searching through Flowroute's purchasable phone number inventory. It allows you to search by NPA, NXX, Ratecenter, State, and TN.

| Parameter  | Required                       | Usage                                                                     |
|------------|--------------------------------|---------------------------------------------------------------------------|
| limit      | False                          | Controls the number of items returned (Max 200)                                     |
| npa        | False, unless nxx is present   | Limits results to the specified NPA (also known as area code)             |
| nxx        | False                          | Limits results to the specified NXX (also known as exchange)              |
| page       | False                          | Determines which page of the results is returned                          |
| ratecenter | False                          | Limits results to the specified ratecenter                                |
| state      | False, unless state is present | Limits results to the specified state                                     |
| tn         | False                          | Limits results to the specified telephone number (supports prefix search) |

##### Example Usage

	response = pnc.search(limit:1, npa:206, nxx:641, page:2)
	puts response
	
### TelephoneNumbersController

The Telephone Numbers Controller contains all of the methods neccesary to purchase a new phone number and to manage your owned phone number inventory.

#### purchase billing, number

The purchase method is used to purchase a telephone number from Flowroute's inventory.

| Parameter       | Required | Usage                                                                                |
|-----------------|----------|--------------------------------------------------------------------------------------|
| billing         | True     | A JSON object that specifies which billing method to use. Either "METERED" or "VPRI" |
| telephoneNumber | True     | The telephone number that you would like to purchase                                 |
	
##### Example Usage

	response = tnc.purchase(billing="VPRI", number="14025554831")
	puts response

> If your query is succesful you will be returned an empty string and a 201 Created

#### list\_account\_telephone_numbers limit: nil, page: nil, pattern: nil

The list\_account\_telephone_numbers method is used to retrieve a list of all of the phone numbers on your Flowroute account.

| Parameter | Required | Usage                                                     |
|-----------|----------|-----------------------------------------------------------|
| limit     | False    | Controls the number of items returned (Max 200)           |
| page      | False    | Determines which page of the results is returned          |
| pattern   | False    | A telephone number to search for (supports prefix search) |

##### Example Usage
	
	response = tnc.list_account_telephone_numbers(limit:10, page:2, pattern:206)
	puts response

#### telephone\_number\_details telephone_number

The telephone\_number\_details method is used to retrieve the billing method, primary route, and failover route for the specified telephone number. 

| Parameter       | Required | Usage                                             |
|-----------------|----------|---------------------------------------------------|
| telephoneNumber | True     | The telephone number that you would like to query |

##### Example Usage

	response = tnc.telephone_number_details('12064205788')
	puts response

#### update number, routes

The update method is used to update both the primary and failover route for a phone number. Both the primary and failover route must be specified inside of an array (see Example Usage). The first route name specified will be assigned as the primary route and the second route name specified will be assigned as the failover route. The list of available route names can be retrieved by using the list method in the InboundRoutesController.

| Parameter       | Required | Usage                                                                  |
|-----------------|----------|------------------------------------------------------------------------|
| telephoneNumber | True     | The telephone number that you would like to update routes for          |
| routes          | True     | The names of the primary and failover routes for the phone number (must be an array) |

##### Example Usage
	
	rtes = [{"name": "c8dee26b0ce87fdf678899df52cc30xa"}, {"name": "sip-reg"}]
	response = tnc.update(number='12065555788', routes=rtes)
	puts response

### InboundRoutesController

The Inbound Routes Controller contains the methods required to view all of your existing inbound routes and to create new inbound routes.

#### list limit: nil, page: nil

The list method is used to return all of the existing inbound routes from your Flowroute account.

| Parameter | Required | Usage                                            |
|-----------|----------|--------------------------------------------------|
| limit     | False    | Controls the number of items returned (Max 200)  |
| page      | False    | Determines which page of the results is returned |

##### Example Usage

	response = irc.list(limit:10, page:1)
	puts response
	
#### create\_new\_route route_name, type, value

The create\_new\_route method is used to create a new inbound route.

| Parameter | Required | Usage                                                                                   |
|-----------|----------|-----------------------------------------------------------------------------------------|
| route_name | True     | The name you would like to assign to the new route (supports alphanumeric characters)   |
| type      | True     | The type of route you would like to create. Valid options are "HOST", "PSTN", and "URI" |
| value     | True     | The actual route that you would like to create                                          |

##### Example Usage

	response = irc.create_new_route(route_name='PSTNroute1',type='PSTN',value='18002364455')	
	puts response	
	
	response = irc.create_new_route(route_name='HOSTroute1',type='HOST',value='24.239.23.40:5060')
	puts response
	
	response = irc.create_new_route(route_name='URIroute1',type='URI',value='sip:120664480000@215.122.69.152:5060')
	puts response
