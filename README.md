# flowroute-numbers-ruby

**flowroute-numbers-ruby** is a Ruby API Wrapper that provides methods for interacting with **v1** (version 1) of the [Flowroute](https://www.flowroute.com) API. These methods can be used to accomplish the following:

* Search for purchasable phone numbers
* Purchase phone numbers
* View your owned phone numbers and their related details
* Create new inbound routes
* Update the primary and failover route on a phone number

### Documentation 
The full documentation for the v1 Flowroute API is available [here](https://developer.flowroute.com/v1.0/docs).

##Before you begin

The following is required before you can deploy the SDK.

### Have your API credentials

You will need your Flowroute API credentials (Access Key and Secret Key). These can be found on the **Preferences > API Control** page of the [Flowroute](https://manage.flowroute.com/accounts/preferences/api/) portal. If you do not have API credentials, contact <mailto:support@flowroute.com>.

### Have a code text editor

Steps in this SDK describe creating one or more script files that allow you to execute the methods. Script files can be created either using a terminal window shell or through using a code text editor. For example, *Sublime Text*. 

## Install the required libraries

> **Note:** You must be connected to the Internet in order to install the required libraries.

The SDK uses the UniRest Ruby library, which must be installed before you can use the SDK. 

1. Open a terminal session. 

2. If needed, create a parent directory folder where you want to install the SDK.
 
3. Go to the newly created folder, and run the following:

 	`git clone https://github.com/flowroute/flowroute-numbers-ruby.git`
 	
 	The `git clone` command clones the **flowroute-numbers-ruby** repository as a sub directory within the parent folder.
 	
4.	Change directories to the newly created **flowroute-numbers-ruby** directory.

5.	Run the following:

		gem build flowroute_messaging.gemspec
		gem install flowroute_messaging-1.0.gem

6.	Import the SDK.

## Import the SDK and set up your API credentials

Importing the SDK in order to execute Controller methods requires that you either run commands by creating and running a script or by running commands directly through the shell. The following instructions describe importing the SDK and running the [Controllers](#controllers) by creating and running a script.

1.	Using a code text editor, create a new file.

2.	At the top of the file, first add a line pointing to the library installation:

		require /users/<user>/<directory path>/flowroute-numbers-ruby/lib/flowroute_numbers/
		
	where:
	
	*	`<user>` is the user name of the user in whose directory the library is installed.
	
	* 	`<directory path>` points to the location of the **flowroute_numbers** subdirectory of the **flowroute-numbers-ruby** installation.
	
3.	Add a line requiring RubyGems:
	
		require 'rubygems'
		
4.	Next, add lines that pass your API credentials to the Controllers:

		FlowrouteNumbers::Configuration.username = 'AccessKey'
		FlowrouteNumbers::Configuration.password = 'SecretKey'   

5.	Replace `AccessKey` and `SecretKey` with your own Access Key and Secret Key.

	>**Note:** You can hard code these values in **Configuration.rb**. However, if you do this you will need to rebuild the gem and install it. Regardless of where you pass your API credentials, verify that you enter them correctly in the file. An incorrectly entered Key throws an `HTTP Response Not OK` message when invoking a method.

6.	Add the following lines to instantiate the three Controllers:

		pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()
		tnc = FlowrouteNumbers::TelephoneNumbersController.new()
		irc = FlowrouteNumbers::InboundRoutesController.new()     
	
	>**Note:** The Controllers use variable names (`pnc`, `tnc`, and `irc`. If you do not want to assign variable names to the Controllers and pass your credentials to each controller, you can hard code the credentials in **Configuration.rb** and then call each controller by its full name. This SDK does not cover those steps.

7.	Optionally, add a line that prints out a response when parameters are passed to a method, allowing you to see a response in the terminal window for invoked method:

		puts response

	>**Important:** Throughout this SDK, `response` is used in method examples. `response` is a variable name that can be changed to a name of your own choosing. It can support an unlimited number of characters. If you choose to rename `response`, make sure that any method that references that variable name is also changed to use the new name. In the following example, `response` is changed to `blob` wherever `response` is used:
>
>`#List NPA and NXX`<br>
>`blob = pnc.list_available_np_as(limit:nil)`<br>
>`puts (blob) 

8.	Save the Ruby file in your top-level **flowroute-numbers-ruby** directory with a .rb extension. For example, *mycontrollers.rb*.

9.	Add Controller methods as needed. See [Controllers](#controllers).

#####Example Ruby file

The following shows an example of a single Ruby file that instantiates all Controllers:

	require '/Users/jdoe/Documents/SDKs/flowroute-numbers-ruby/lib/flowroute_numbers/'
	require 'rubygems'
	
	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'  

	pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()
	tnc = FlowrouteNumbers::TelephoneNumbersController.new()
	irc = FlowrouteNumbers::InboundRoutesController.new()
	
	puts response

With this in mind, you can then decide the approach you want to take towards creating a file. You can create your own Ruby file using any of the following options:
 
 1.	Create a single file that contains all of the Controllers and methods, then commenting (#) out the lines for each Controller and method you don't want to run.
 
 2.	Create a unique file for each Controller, adding only those lines relevant to that Controller and related methods, and then commenting out the lines for each method you're not using. This procedure creates three unique Ruby files.
 
 3.	Create a unique file for each method. Each file will then contain the lines instantiating the relevant Controller and method.

This SDK describes the second option, creating three Ruby files, one for each Controller. However, regardless of which option you select, the file(s) should be saved in the **flowroute-numbers-ruby** directory. When you want to invoke a method, run the following on the command line in the **flowroute-numbers-ruby** directory:

		ruby <Controller File Name.rb>

## Controllers<a name=controllers></a>

The following sections describe **flowroute-numbers-ruby** Controllers:

*	[`PurchasablePhoneNumbersController`](#purchaseno)

*	[`TelephoneNumbersController`](#telephoneno)

*	[`InboundRoutesController`](#inboundco) 

>**Important:** The SDK displays sample responses. Formatting of the responses is provided for clarity only. They are not intended to show the formatting of your own response. 

### PurchasablePhoneNumbersController<a name=purchaseno></a>

Location: **./flowroute-numbers-ruby/lib/flowroute_numbers/controllers**

The PurchasablePhoneNumbersController contains all of the methods necessary to search through Flowroute's phone number inventory. The following shows an example **purchase.rb** file that invokes only the PurchasablePhoneNumbersController methods:

	require '/Users/jdoe/Documents/SDKs/flowroute-numbers-ruby/lib/flowroute_numbers/'
	require 'rubygems'
	
	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'  

	pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()
	
	#List Available NPAs
	response = pnc.list_available_np_as(limit:nil)
		
	#List NPA and NXX
	pnc.list_area_and_exchange(limit:nil, npa:nil, page:nil)
		
	#Search
	response = pnc.search(limit:nil, npa:nil, nxx:nil, page:nil, ratecenter:"nil", state:"nil", tn:nil)
	
	puts response

When creating your own Ruby file, add each method after `pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()`, but before `puts response`. If you do not want to invoke a specific method, comment out that method's lines with `#`. 

The Controller contains the following methods:

*	[`listAvailableNPAs()`](#listnpa)

* 	[`listAreaAndExchange()`](#listnpanxx)

* 	[`search()`](#searchno)

Run the following from the **flowroute-numbers-ruby** directory in a terminal window to call the Controller methods:

	ruby purchase.rb

#### `list_available_np_as(limit)`<a name=listnpa></a>

The `list_available_np_as` method retrieves a list of every NPA (area code) available in Flowroute's phone number inventory.

#####Usage

Add the following lines to your Ruby file:

	#List Available NPAs
	response = pnc.list_available_np_as(limit:nil)

| Parameter | Required |Type |Description                           |
|-----------|----------|-----|--------------------------------|
| `limit`     | False  |integer| Controls the number of items returned. The maximum number of items is 200. If no number is passed, `nil` is used by default, and a maximum of ten NPAs are returned. |

##### Example usage

The following example limits the number of items to return to `3`.
	
	#List Available NPAs
	response = pnc.list_available_np_as(limit:3)

#####Example response

Based on the request above, the following three NPAs are returned:

	{
  	"npas": {
   	 "201": {
   	   "nxxs": "/v1/available-tns/npanxxs/?npa=201",
   	   "tns": "/v1/available-tns/tns/?npa=201"
   	 },
   	 "203": {
   	   "nxxs": "/v1/available-tns/npanxxs/?npa=203",
   	   "tns": "/v1/available-tns/tns/?npa=203"
   	 },
   	 "202": {
   	   "nxxs": "/v1/available-tns/npanxxs/?npa=202",
   	   "tns": "/v1/available-tns/tns/?npa=202"
   	 }
  	},
  	"links": {
   	 "next": "/v1/available-tns/npas/?limit=3&page=2"
  	}
	}

#####Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code|HTTP Response Not OK|Typically this occurs when a `limit` does not fall within the allowed number range, such as greater than `200` or a negative number. |

#### `list_area_and_exchange (limit, npa, page)`<a name=listnpanxx></a>

The `listAreaAndExchange` method allows you to retrieve a list of every NPANXX (area code and exchange) combination available in Flowroute's phone number inventory.

#####Usage

Add the following lines to your Ruby file:

	#List NPA and NXX
	response = pnc.list_area_and_exchange(limit:nil, npa:nil, page:nil)
	
The method takes the following parameters:

| Parameter | Required |Type| Description                                                         |
|-----------|----------|--------------|-------------------------------------------------|
| `limit`     | False    | integer| Controls the number of items returned. The maximum number of items is `200`. If neither a number nor `nil` are passed, a default of ten NPANXX combinations are returned.                 |
| `npa`       | False  | integer| Three-digit area code. Limits results to the specified NPA. If `null` is passed, all NPAs are returned. Partial number search is also supported. For example, passing `20` returns all NPA and NXX results that include `20`.|
| `page`      | False  |integer  | Sets which page of the results is returned.` Next` and `Prev` URLs provided at the bottom of the response provide navigation pointers. The `page` value overrides the value set for the `limit`. For example, if `nil` is set for both parameters, all pages are returned instead of just `10`.   |

#####Example usage

In the following, a request is made to limit the results to `2`, the NPA to `203` and to display `page` `3`:

	#List NPA and NXX
	response = pnc.list_area_and_exchange(limit:2, npa:203, page:3)

#####Example response

Based on the example usage above, the following two NPANXX combinations are returned on page `2`, organized by `npanxxs`. 

```sh
{
  "npanxxs": {
    "203654": {
      "tns": "/v1/available-tns/tns/?npa=203&nxx=654"
    },
    "203648": {
      "tns": "/v1/available-tns/tns/?npa=203&nxx=648"
    }
  },
  "links": {
    "prev": "/v1/available-tns/npanxxs/?npa=203&limit=2&page=2",
    "next": "/v1/available-tns/npanxxs/?npa=203&limit=2&page=4"
  }
}
```

>**Note:** If no results are found based on the passed parameters, `{}` is returned as a response.

#####Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code|HTTP Response Not OK|Typically this occurs when a `limit` does not fall within the allowed number range, such as greater than `200` or a negative number; or if `0` or a negative number are passed for the `page`. |
	
#### `search limit: (nil, npa, nxx, page, ratecenter, state, tn)`<a name=searchno></a>

The search method is the most robust option for searching through Flowroute's purchasable phone number inventory. It allows you to search by NPA, NXX, Ratecenter, State, and/or TN.

#####Usage

Add the following lines to your Ruby file:

	#Search
	response = pnc.search(limit:nil, npa:nil, nxx:nil, page:nil, ratecenter:"nil", state:"nil", tn:nil)

The method takes the following parameters:

| Parameter  | Required|   Type|          Description                                         |
|------------|----------|------|--------------------------------------------------------|
| `limit`     | False    | integer| Controls the number of items returned. The maximum number of items is 200. If neither a number nor `null` are passed, a default of ten NPANXX combinations are returned.                      |
| `npa`       | False, unless `nxx` is passed, then `True`.  | integer| Three-digit area code. Limits results to the specified NPA. If `null` is passed, all NPAs are returned. Partial number search is also supported. For example, passing `20` returns all NPA and NXX results that include `20`.|
| `nxx`       |False  | integer |Three-digit exchange. Limits the results for the specified NXX. If no `nxx` is passed, `null` is used and all results are returned. Partial search is also supported. For example, passing `'45'` for the `nxx` returns exchanges that include `45`. Note that if you pass an `nxx` you must also pass an `npa`. |
| `page`      | False   | integer |Sets which page of the results is returned.` Next` and `Prev` URLs provided at the bottom of the response provide navigation pointers. If `null` is passed, all pages are returned.   |            |
| `ratecenter` | False |string             | Limits the results to the specified ratecenter.  There is no limit on the number of characters that can be passed. This field is case-insensitive and must be enclosed in quotes (`""`). |                      |
| `state`      | False, unless `ratecenter` is passed, then `True`.|string | Limits results to the specified state or Canadian province. Must be formatted using the two-letter state or province/territory abbreviation. This field is case-insensitive and must be enclosed in quotes (`""`).                    |
| `tn`         | False  |string             | Limits results to the specified telephone number. The phone number must be passed as an 11-digit number formatted as *`1NPAXXXXXX`*.  |

##### Example Usage

In the following example, a search request sets the `limit` to `3`, the `npa` to `206`, the `nxx` to `641`, to `display` page `2`, the `ratecenter` to `"SEATTLE"`, the `state` to `"WA"`, and the `tn` to `nil`.

	#Search
	response = pnc.search(limit:3, npa:206, nxx:641, page:2, ratecenter:"SEATTLE", state:"WA", tn:nil)
	
##### Example response

Based on the passed search parameters, the following is returned:

	{
	  "tns": {
    "12066417744": {
      "initial_cost": "1.00",
      "monthly_cost": "1.25",
      "billing_methods": [
        "VPRI",
        "METERED"
      ],
      "ratecenter": "SEATTLE",
      "state": "WA"
    },
    "12066417667": {
      "initial_cost": "1.00",
      "monthly_cost": "1.25",
      "billing_methods": [
        "VPRI",
        "METERED"
      ],
      "ratecenter": "SEATTLE",
      "state": "WA"
    },
    "12066417669": {
      "initial_cost": "1.00",
      "monthly_cost": "1.25",
      "billing_methods": [
        "VPRI",
        "METERED"
      ],
      "ratecenter": "SEATTLE",
      "state": "WA"
   	 }
  	},
  	"links": {
   	 	"prev": "/v1/available-tns/tns/?npa=206&nxx=641&state=WA&ratecenter=SEATTLE&limit=3&page=1",
   	 	"next": "/v1/available-tns/tns/?npa=206&nxx=641&state=WA&ratecenter=SEATTLE&limit=3&page=3"
  		}
	}		

>**Note:** If no results are found based on the passed parameters, `{}` is returned as a response.

##### Response field descriptions	

The following information is returned in the response:

Parameter | Description                                             |
|--------|-------------------------------------------------------|
| `tns`  | Object composed of a `telephone number`, `state`, `ratecenter`, and `billing_methods`.|                           |
||	*`telephone number`*- The retrieved telephone number object, which is composed of:|
||	<ul><ul><li> `initial_cost`- The one-time fixed cost for that telephone number. The default value is USD `1.00`.</ul>|
| | <ul><ul><li>`monthly_cost`- The recurring monthly cost to maintain that telephone number. The default value is USD `1.25`.</ul>|
| |<ul><ul><li>`billing_methods`- Displays the billing methods available for the telephone number: <ul><li>`[0] VPRI`, or</ul></li> <ul><li>`[1] METERED` </ul></li>|
||	`ratecenter`- The ratecenter associated with the NPANXX.|
||	`state`- The US state or Canadian province or territory in which the NPANXX is located.</ol>|

#####Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code|HTTP Response Not OK|Typically this occurs when a passed value does not fall within the range of allowed values. For example, this might be a `limit` that does not fall within the `1` to `200` range. |

### TelephoneNumbersController<a name=telephoneno></a>

Location: **./flowroute-numbers-ruby/lib/flowroute_numbers/controllers**

The TelephoneNumbersController contains all of the methods necessary to purchase and manage a Flowroute number. The following shows a sample file, **phonenumbers.rb**, that invokes only the TelephoneNumbersController methods:

	require '/Users/jdoe/Documents/SDKs/flowroute-numbers-ruby/lib/flowroute_numbers/'
	require 'rubygems'
	
	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'  

	tnc = FlowrouteNumbers::TelephoneNumbersController.new()
	
	#Purchase a Telephone Number
	response = tnc.purchase(billing="billing method", number="phone number")
	
	#List Account Telephone Numbers
	response = tnc.list_account_telephone_numbers(limit:nil, page:nil, pattern:nil)
	
	#Telephone Number Details
	response = tnc.telephone_number_details('number')
	
	#Update Telephone Number Routes
	rtes = [name: "primary route name", name: "failover route name"]
	response = tnc.update(number='telephoneNumbe', routes=rtes)
	
	puts response
	

Add any of the following TelephoneNumbersController methods after `tnc = FlowrouteNumbers::TelephoneNumbersController.new()`, but before `puts response`. If you do not want to invoke a specific method, comment out that method's lines with `#`.  

The Controller contains the following methods:

*	[`purchase`](#purchaseno)
*	[`listAccountTelephoneNumbers`](#listnumbers)
*	[`telephoneNumberDetails`](#phonedetails)
*	[`update`](#updateroute)

#### `purchase (billing, number)`<a name=purchaseno></a>

The purchase method is used to purchase a telephone number from Flowroute's inventory. 

#####Usage

Add the following lines to your Ruby file:

	#Purchase a Telephone Number
	response = tnc.purchase(billing="billing method", number="phone number")

The method takes the following parameters:

| Parameter       | Required | Type|Description                                                 |                                                          
|-----------------|----------|--------|-------------------------------------------------------|
| `billing method`   | True     |string  | Sets the billing method applied to the purchased number. `billing method` must be one of the following: <ul><li>`METERED` — unlimited concurrent calls, each billed per-minute used.</li> <li> `VPRI` — limits the number of concurrent calls to the number of VPRI channels you have, but with unlimited usage on each channel. </li></ul>|       
| `phone number` | True    | string | The Flowroute telephone number to purchase, using an 11-digit E.164 format: *`1NPANXXXXXX`*.                |

##### Example Usage

In the following method, the billing method is `VPRI`, and the phone number to purchase is one retrieved from the [search](#searchno) method.

	#Purchase a Telephone Number
	response = tnc.purchase(billing="VPRI", number="12066417744")

##### Example response

A successful purchase returns an empty line.

##### Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code.  |HTTP Response Not OK|This can be caused when an incorrect phone number or billing method are entered, or if the number to purchase has already been purchased.|

#### `list_account_telephone_numbers (limit, page, pattern)`<a name=listnumbers></a>

The `listAccountTelephoneNumbers` method is used to retrieve a list of all of the phone numbers on your Flowroute account.

##### Usage

Add the following lines to your file:

	#List Account Telephone Numbers
	response = tnc.list_account_telephone_numbers(limit:nil, page:nil, pattern:nil)
	
The method takes the following parameters:

| Parameter | Required |     Type | Description                                    |
|-----------|----------|-----------|-----------------------------------------------|
| `limit`     | False    | integer| Controls the number of items returned. The maximum number of phone numbers is 200. If neither a number nor `nil` are passed, a default of ten numbers are returned.                      
| `page`      | False  |integer  | Sets which page of the results is returned.` Next` and `Prev` URLs provided at the bottom of the response provide navigation pointers. If `nil` is passed, all pages are returned.   |
| `pattern`   | False | string  | The phone number on which to search. Partial number search is supported; for example, if `206` is passed the response returns all phone numbers which include `206`. If neither a number nor `nil` are passed, all numbers associated with the account are returned.  |

##### Example Usage

For this example, the `limit` is `1`, the `page` is `nil`, and the `pattern` includes `206`.
	
	#List Account Telephone Numbers
	response = tnc.list_account_telephone_numbers(limit:1, page:nil, pattern:206)

#####Example response

Based on the passed parameters, the number purchased using the [purchase](#purhcaseno) method above is returned as the response:

	{
  		"tns": {
   	 	"12066417848": {
   	   	"billing_method": "VPRI",
   	   	"routes": [
   	   	  {
   	   	    "type": "HOST",
   	   	    "name": "HOSTroute1",
   	   	    "value": "24.239.23.40:5060"
   	   	  },
   	   	  {
   	   	    "type": "URI",
   	   	    "name": "URIroute1",
   	   	    "value": "sip:16476998778@215.122.69.152:5060"
   	   	  }
   	   	],
   	   	"detail": "/v1/tns/12066417848"
   	 	}
  		},
  		"links": {
    	"next": "/v1/tns/?pattern=206&limit=1&page=2"
  		}
	}   
	
>**Note:** If no results are found based on the passed parameters, `{}` is returned as a response.
>
##### Response field descriptions

The following information is returned in the response:

Parameter | Description                                             |
|--------|-------------------------------------------------------|
| `tns`  | Object composed of a `telephone number`, `billing_method`, and `routes`.|                           
||	*`telephone number`*- The retrieved telephone number object, which is composed of:|
||	<ul><ul><li> `billing_method`- The billing method assigned to the phone number when the number was purchased. This will be either `METERED` or `VPRI`.</ul>|
| |<ul><ul><li>`routes`- Displays the primary `[0]` and failover `[1]` routes for the phone number: <ul><li>`type` — Indicates the type of route: `HOST`, `PSTN`, or `URI`. If no route is assigned, `SIP-REG` is the default name assigned to the route.</ul></li> <ul><li>`name` — Name of the route. If no `name` was given to the route, `sip-reg` is the assigned default name.</ul></li> **Note:** Routes are created using the [createNewRoute](#createroute) method and existing routes can be viewed using the [mlist](#listroutes) method.|

##### Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code|HTTP Response Not OK|Typically this occurs when a `limit` does not fall within the allowed number range, such as greater than `200` or a negative number; or if `0` or a negative number are passed for the `page`. |

#### `telephone_number_details (number)`<a name=phonedetails></a>

The `telephone_number_details` method is used to retrieve the billing method, primary route, and failover route for the specified telephone number. 

##### Usage

Add the following lines to your Ruby file:

	#Telephone Number Details
	response = tnc.telephone_number_details('number')

The method takes the following parameter:

| Parameter       | Required | Type   |Description                                    |
|-----------------|----------|--------|-------------------------------------------|
| `number` | True     | string |    The telephone number on which to query. You must use an 11-digit, E.164 number, formatted as *`1NPANXXXXXX`*. Neither partial number search nor multiple number search are supported. |

##### Example Usage

In the following example, the details for the number purchased using the [purchase](#purchaseno) method are requested:

	#Telephone Number Details
	response = tnc.telephone_number_details('12066417744')

##### Example response

The response returns the following phone number details:

	{
 	 "billing_method": "VPRI",
  	"routes": [
  	  {
  	    "type": "SIP-REG",
  	    "name": "sip-reg"
  	  },
  	  {
  	    "type": "SIP-REG",
 	    "name": "sip-reg"
 	   }
 		 ]
	}

##### Response field descriptions	
 
The following information is returned in the response:

Parameter | Description                                             |
|--------|-------------------------------------------------------|                       
|`billing_method`| The billing method assigned to the phone number when the number was purchased. This will be either `METERED` or `VPRI`.|
|`routes` |Displays the primary and failover routes for the phone number. The first route group displays information about the primary route, the second about the failover route:<br> <ul><li>`type` — Indicates the type of route: `HOST`, `PSTN`, or `URI`. If no route is assigned, `SIP-REG` is the default name assigned to the route.</li> <li>`name` — Name of the route. If no `name` was given to the route, `sip-reg` is the default name.</ul></li>**Note:** Routes are created using the [createNewRoute](#createroute) method and can be assigned using the `update` method.|

##### Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code.  |HTTP Response Not OK|This can be caused when an incorrect phone number is entered, or a number not owned by you is entered.|

#### `update(number, routes)`<a name=updateroute></a>

The `update` method is used to update both the primary and failover route for a phone number, specified within an array. See Example Usage below. The first route name specified within the array is assigned as the primary route and the second route name assigned as the failover route. The list of available route names can be retrieved by using the the [`list`](#listroutes) method in the InboundRoutesController.

>**Note:** In order to apply an existing route to a number, the route must first be created using the [createNewRoute](#createRoute) method. To view a list of your existing routes, use the [`list`](#listroutes) method.

##### Usage

Add the following lines to your Ruby file:

	#Update Telephone Number Routes
	rtes = [name: "primary route name", name: "failover route name"]
	response = tnc.update(number='telephoneNumber', routes=rtes)

First, define the variable name that identifies the array:

| Parameter       | Required | Type |Description |                                                     
|-----------------|----------|-------|----------------------------------------------------------|
|`rtes`|True| string| Variable name that identifies the array. This field can be of unlimited characters. In this example, `rtes` is used.|

Next, define the variables that compose the array:

| Parameter       | Required | Type |Description |                                                     
|-----------------|----------|-------|----------------------------------------------------------|
|`primary/failover route name`|True| string| Name of a current route. The first `name` in the array will be assigned the primary route; the second `name` will be assigned the secondary, or failover, route. See [`create_new_route`](#createroute) for the steps to create a route.|
| `telephoneNumber` | True     | string |    The telephone number on which to update routes. You must use a Flowroute phone number in an 11-digit, E.164 format: *`1NPANXXXXXX`*.|  

##### Example Usage

The following example updates the routes for the telephone number purchased using the [purchase](#purchaseno) method:
	
	#Update Telephone Number Routes
	rtes = [{name: "HOSTroute1"}, {name: "URIroute1"}]
	response = tnc.update(number='12066417744', routes=rtes)

#####Example response

An empty string (`""`) is returned for a successful update. To view the route changes on the phone number, run the 
[`listAccountTelephoneNumbers()`](#listnumbers) or [`telephoneNumberDetails()`](#phonedetails) methods.

#####Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code|HTTP Response Not OK|Typically this occurs when a `number` is incorrect, or an incorrect `route name` is passed. |

### InboundRoutesController<a name=inboundco></a>

Location: **./flowroute-numbers-ruby/lib/flowroute_numbers/controllers**

The Inbound Routes Controller contains the methods required to view all of your existing inbound routes and to create new inbound routes. Methods must be added to a Ruby file and that file run from the **flowroute-numbers-ruby** directory in a terminal window. The following shows an example file,  **routes.rb**, containing all of the Controller's methods:

	require '/Users/jdoe/Documents/SDKs/flowroute-numbers-ruby/lib/flowroute_numbers/'
	require 'rubygems'
	
	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'  

	irc = FlowrouteNumbers::InboundRoutesController.new()
	
	#List Routes
	response = irc.list(limit:nil, page:nil)
	
	#Create a New Route
	response = irc.create_new_route(route_name='route_name',type='route_type',value='value')
	 
	puts response   

Add the following InboundRoutesController methods after `irc = FlowrouteNumbers::InboundRoutesController.new()`, but before `puts response`. If you do not want to invoke a specific method, comment out that method's lines with `#`.  

The Controller contains the following methods:

*	[`list`](#listroutes)
* 	[`createNewRoute`](#createroute)

#### `list (limit, page)`<a name=listroutes></a>

The list method is used to return all of the existing inbound routes from your Flowroute account.

#####Usage
 
Add the following lines to your Ruby file:

		#List Routes
		response = irc.list(limit:nil, page:nil)

The method takes the following parameters:

| Parameter | Required | Type   |Description                                    |
|-----------|----------|---------|----------------------------------------|
| `limit:nil`     | False    | integer| Controls the number of routes returned. The maximum number is 200. If neither a number nor `null` are passed, a default of ten routes are returned.  |                    
| `page:nil`      | False  |integer  | Sets which page of the results is returned.` Next` and `Prev` URLs provided at the bottom of the response provide navigation pointers. If `nil` is passed, all pages are returned.   |

##### Example Usage

In the following example, a `limit` of `10` routes is to be returned, and only `page` `1` displayed:

	#List Routes
	response = irc.list(limit:10, page:1)

	
#####Example response

Based on the parameters passed in the request, the following is returned:

	{
 	 	"routes": {
 	   		"HOSTroute1": {
 	     		"type": "HOST",
	      		"value": "24.239.23.40:5060"
	    		},
	    	"PSTNroute1": {
				"type": "PSTN",
				"value": "178"
	    		},
	    	"URIroute1": {
	      		"type": "URI",
	      		"value": "sip:16476998778@215.122.69.152:5060"
   	 			},
   		 	"sip-reg": {
   	   		 	"type": "SIP-REG",
   	  	 	 	"value": null
   	 			}
  			}
	}
These routes can be applied to any of your purchased phone numbers using the [`update`](#updateroute) method.

#####Response field descriptions

The following information is returned in the response:

| Parameter |  Description                                                     |
|-----------|--------------------------------------------------------------------------------|
| `[routeName]` |  The name of the route assigned using the [`createNewRoute`](#createroute) method. It is composed of:<ul> <li>`type`  The type of route created using the `createNewRoute` method. Will be `HOST`, `PSTN`, or `URI`. If no route type was assigned, `SIP-REG` is used as the default. <li>`value` Value of the route, assigned to the route `type` using the `createNewRoute` method.</ul</li>|

#####Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code|HTTP Response Not OK|Typically this occurs when a `limit` does not fall within the allowed number range, such as greater than `200` or a negative number; or if `0` or a negative number are passed for the `page`. |

#### `create_new_route(name, type, value)`<a name=createroute></a>

The `create_new_route ` method is used to create a new inbound route.

#####Usage

Add the following lines to your Ruby file:

	#Create a New Route
	response = irc.create_new_route(route_name='route_name',type='route_type',value='value') 

The method takes the following parameters:

| Parameter | Required | Type| Description                                                                        |
|-----------|----------|------|-----------------------------------------------------------------------------|
| `name` | True    |  string| The name of the new route. An unlimited number of alphanumeric characters is supported. There are no unrestricted characters.  |
| `type`      | True   |  string |The type of route you would like to create. Valid options are `HOST`, `PSTN`, and `URI`. |
| `value`     | True    |string |  Value of the route, dependent on the `type`: <ul><li>If `HOST`, the value must be an IP address or URL with an optional port number—for example, an IP address could be `24.239.23.40:5060` or a URL could be `myphone.com`. If no port is specified, the server will attempt to use DNS SRV records. <li>If `PSTN`, the value must be formatted as a valid E.164, 11-digit formatted North American phone number—for example,`12065551212 `. You cannot use the same number as the number for which the route is created. <li>If `URI`, the value must be formatted as  `protocol:user@domain[:port][;transport=<tcp/udp>`—for example, `sip:alice@seattle.com`,  `sip: 12065551212@215.122.69.152:5060;transport=tcp`, or `sips:securecall@securedserver.com`. You cannot use the same number as the number for which the route is created.</li></ul>              |
##### Example Usage

In the following example, three routes are created, one each for the `PSTN`, `HOST`, and `URI` types:

	#Create a New Route
	response = irc.create_new_route(route_name='MyPSTN',type='PSTN',value='12065551212')
	puts response  
	response = irc.create_new_route(route_name='MyHost',type='HOST',value='24.239.23.40:5060')
	puts response  
	response = irc.create_new_route(route_name='MyURI',type='URI',value='sip:12065551212@215.122.69.152:5060')
	puts response  


>**Note**: In the example above, `puts response` is added after each line. This returns a success or error response for each line.

#####Example response

An empty string (`""`) is returned for each successfully created route; no other code or message is returned. An error encountered for a specific `irc.create_new_route()` line will not prevent the other routes from being created.

#####Error response

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code|HTTP Response Not OK|Typically this occurs when an incorrect number of digits was passed for the telephone number. The number must use E.164, 11-digit `1NPANXXXXXXXXX` format. |