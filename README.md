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

The following are required before you can deploy the SDK.

### Have your API credentials

You will need your Flowroute API credentials (Access Key and Secret Key). These can be found on the **Preferences > API Control** page of the [Flowroute](https://manage.flowroute.com/accounts/preferences/api/) portal. If you do not have API credentials, contact <mailto:support@flowroute.com>.

### Know your Flowroute phone number

To create and send a message, you will need your Flowroute phone number, which should be enabled for SMS. If you do not know your phone number, or if you need to verify whether or not it is enabled for SMS, you can find it on the [DIDs](https://manage.flowroute.com/accounts/dids/) page of the Flowroute portal.
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

Importing the SDK requires that you run commands either by creating and running a script or through the shell. The following instructions describe importing the SDK and running the `messages_controller` by creating and running a script.

1.	Using a code text editor — for example, *Sublime Text* — create a new file.

2.	At the top of the file, first add a line pointing to the library installation:

		require /users/<user>/<directory path>/flowroute-numbers-ruby/lib/flowroute_numbers/
		
	where:
	
	*	`<user>` is the user name of the user in whose directory the library is installed.
	
	* 	`<directory path>` points to the location of the **flowroute_numbers** subdirectory of the **flowroute-numbers-ruby** installation.
	
3.	Add a line for RubyGems:
	
		require 'rubygems'
		
3.	Next, add lines which pass your credentials to the Controllers:

		FlowrouteNumbers::Configuration.username = 'AccessKey'
		FlowrouteNumbers::Configuration.password = 'SecretKey'   

4.	Replace `AccessKey` and `SecretKey` with your own Access Key and Secret Key.

	>**Note:** You can hard code these values in **Configuration.rb**. However, if you do this you will need to rebuild the gem and install it.

5.	Add the following lines to instantiate the three Controllers for later use:

		pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()
		tnc = FlowrouteNumbers::TelephoneNumbersController.new()
		irc = FlowrouteNumbers::InboundRoutesController.new()     
	
	>**Note:** The Controllers use variable names. If you do not want to assign variable names to the Controllers and pass your credentials to each controller, you can hard code the credentials in **Configuration.rb** and then call each controller by its full name. This SDK does not cover those steps.

6.	Optionally, add a line that prints out a response when parameters are passed to a method:

		puts response

	>**Note:** `response` is a variable name that can be of your own choosing and can be of unlimited characters. However, the name you choose should be used consistently when you use a Controller and method. For these SDK examples, `response` is used. 

The following shows an example of a single Ruby file that instantiates all Controllers:

	require '/Users/jdoe/Documents/SDKs/flowroute-numbers-ruby/lib/flowroute_numbers/'
	require 'rubygems'
	
	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'  

	pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()
	tnc = FlowrouteNumbers::TelephoneNumbersController.new()
	irc = FlowrouteNumbers::InboundRoutesController.new()
	
	puts response


You can create your own Ruby file by any of the following methods:
 
 1.	Create a single file that contains all of the Controllers and methods, then commenting (#) out the lines for each Controller and method you don't want to run.
 
 2.	Create a unique file for each Controller, adding only those lines relevant to that Controller and related methods, and then commenting out the lines for each method you're not using. This procedure creates three unique Ruby files.
 
 3.	Create a unique file for each method. Each file will then contain the lines instantiating the relevant Controller.

This SDK describes the second option, creating unique Ruby files. However, regardless of which option you select, the file(s) should be saved in the **flowroute-numbers-ruby** directory. When you want to run a method, run the following on the command line in the **flowroute-numbers-ruby** directory:

		ruby <Controller File Name.rb>

## Controllers

This following sections describe **flowroute-numbers-ruby** Controllers:

*	[`PurchasablePhoneNumbersController`](#purchaseno)

*	[`TelephoneNumbersController`](#telephoneno)

*	[`InboundRoutesController`](#inboundco) 

>**Important:** The SDK displays sample responses. Formatting of the responses is provided for clarity only. They are not intended to show the formatting of your own response. 

### PurchasablePhoneNumbersController<a name=purchaseno></a>

The Purchasable Phone Numbers Controller contains all of the methods necessary to search through Flowroute's phone number inventory. Methods must be added to a Ruby file and that file run from the **flowroute-numbers-ruby** directory in a terminal window. For example, you can create a **purchase.rb** file contains the following information:

	require '/Users/jdoe/Documents/SDKs/flowroute-numbers-ruby/lib/flowroute_numbers/'
	require 'rubygems'
	
	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'  

	pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()
	
	puts response

You can then add any of the following Controller methods after the line above:

*	[`listAvailableNPAs()`](#listnpa)

* 	[`listAreaAndExchange()`](#listnpanxx)

* 	[`search()`](#searchno)

#### `list_available_np_as(limit)`<a name=listnpa></a>

The list_available_np_as method allows you to retrieve a list of every NPA (area code) available in Flowroute's phone number inventory.

#####Usage

Add the following line to your Ruby file between `pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()` and the `put response`

	response = pnc.list_available_np_as(limit:nil);

>**Note:** `response` can be any name of you choose, and of any length, but the name you choose must be used consistently in the method.

| Parameter | Required |Type |Description                           |
|-----------|----------|-----|--------------------------------|
| `limit`     | False  |integer| Defines controls the number of items returned. The maximum number of items is 200. If no number is passed, `nil` is used by default, and a maximum of ten NPAs are returned. |

##### Example usage
	
	response = pnc.list_available_np_as(limit:3)

#####Example response

Based on the request above, `put response` returns the following three NPAs.

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
#### `list_area_and_exchange (limit, npa, page)`<a name=listnpanxx></a>

The `listAreaAndExchange` method allows you to retrieve a list of every NPANXX (area code and exchange) combination available in Flowroute's phone number inventory.

#####Usage

Add the following line to your Ruby file between `pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()` and the `put response`
	
	response = pnc.list_area_and_exchange(limit:x, npa:nil, page:nil)

>**Note:** `response` can be any name of your choosing, and of any length, but the name you choose must be used consistently in the method.
	
The method takes the following parameters:

| Parameter | Required |Type| Description                                                         |
|-----------|----------|--------------|-------------------------------------------------|
| `limit`     | False    | integer| Controls the number of items returned. The maximum number of items is 200. If neither a number nor `nil` are passed, a default of ten NPANXX combinations are returned.                 |
| `npa`       | False  | integer| Three-digit area code. Limits results to the specified NPA. If `null` is passed, all NPAs are returned. Partial number search is also supported. For example, passing `20` returns all NPA and NXX results that include `20`.|
| `page`      | False  |integer  | Sets which page of the results is returned.` Next` and `Prev` URLs provided at the bottom of the response provide navigation pointers. The `page` value overrides the value set for the `limit`. For example, if `nil` is set for both parameters, all pages are returned instead of just `10`.   |

#####Example usage

In the following, a request is made to limit the results to `2`, the NPA to `203` and to display page `3`:

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

##### Example Usage
		
	response = pnc.list_area_and_exchange(limit:1, npa:206, page:2)

>**Note:** `response` can be any name of your choosing, and of any length, but the name you choose must be used consistently in the method.	
	
#### `search limit: (nil, npa, nxx, page, ratecenter, state, tn)`<a name=searchno></a>

The search method is the most robust option for searching through Flowroute's purchasable phone number inventory. It allows you to search by NPA, NXX, Ratecenter, State, and/or TN.

#####Usage

Add the following line to your Ruby file between `pnc = FlowrouteNumbers::PurchasablePhoneNumbersController.new()` and the `put response`

	response = pnc.search(limit:nil, npa:nil, nxx:nil, page:nil, ratecenter:"nil", state:"nil", tn:nil)

The method supports the following parameters:

| Parameter  | Required|   Type|          Description                                         |
|------------|----------|------|--------------------------------------------------------|
| `limit`     | False    | integer| Controls the number of items returned. The maximum number of items is 200. If neither a number nor `null` are passed, a default of ten NPANXX combinations are returned.                      |
| `npa`       | False, unless `nxx` is passed, then `True`.  | integer| Three-digit area code. Limits results to the specified NPA. If `null` is passed, all NPAs are returned. Partial number search is also supported. For example, passing `20` returns all NPA and NXX results that include `20`.|
| `nxx`       |False  | integer |Three-digit exchange. Limits the results for the specified NXX. If no `nxx` is passed, `null` is used and all results are returned. Partial search is also supported. For example, passing `'45'` for the `nxx` returns exchanges that include `45`. Note that if you pass an `nxx` you must also pass an `npa`. |
| `page`      | False   | integer |Sets which page of the results is returned.` Next` and `Prev` URLs provided at the bottom of the response provide navigation pointers. If `null` is passed, all pages are returned.   |            |
| `ratecenter` | False |string             | Limits the results to the specified ratecenter.  There is no limit on the number of characters that can be passed. This field is case-sensitive and must be enclosed in quotes (`""`). |                      |
| `state`      | False, unless `ratecenter` is passed, then `True`.|string | Limits results to the specified state or Canadian province. Must be formatted using the two-letter state or province/territory abbreviation. This field is case-sensitive and must be enclosed in quotes (`""`).                    |
| `tn`         | False  |string             | Limits results to the specified telephone number. The phone number must be passed as an 11-digit number formatted as *`1NPAXXXXXX`*.  |##### Example Usage

##### Example Usage

In the following example, a search request sets the `limit` to `3`, `206` for the `npa`, `641` for the `nxx`, `2` for the `page`, `SEATTLE` for the `ratecenter`, `WA` for the `state`, and `nil` for the `tn`.

	response = pnc.search(limit:3, npa:206, nxx:641, page:2, ratecenter:"SEATTLE", state:"WA", tn:nil)
	
#####Example response

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

#####Response field descriptions	

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

### TelephoneNumbersController<a name=telephoneno></a>

The TelephoneNumbersController contains all of the methods necessary to purchase and manage a Flowroute number. Methods must be added to a Ruby file and that file run from the **flowroute-numbers-ruby** directory in a terminal window.. For example, you can create a **telephone.rb** file contains the following information:

	require '/Users/jdoe/Documents/SDKs/flowroute-numbers-ruby/lib/flowroute_numbers/'
	require 'rubygems'
	
	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'  

	tnc = FlowrouteNumbers::TelephoneNumbersController.new()
	
	puts response

Add any of the following TelephoneNumbersController methods between `tnc = FlowrouteNumbers::TelephoneNumbersController.new()` and `puts response` and then comment out each method as needed.

*	[`purchase`](#purchaseno)
*	[`listAccountTelephoneNumbers`](#listnumbers)
*	[`telephoneNumberDetails`](#phonedetails)
*	[`update`](#updateroute)

#### `purchase (billing, number)`<a name=purchaseno></a>

The purchase method is used to purchase a telephone number from Flowroute's inventory. 

#####Usage

Add the following line between `tnc = FlowrouteNumbers::TelephoneNumbersController.new()` and `puts response`:

	response = tnc.purchase(billing="billing method", number="phone number")

>**Note:** `response` can be any name of your choosing, and of any length, but the name you choose must be used consistently in the method.

The parameters can take the following values:

| Parameter       | Required | Type|Description                                                 |                                                          
|-----------------|----------|--------|-------------------------------------------------------|
| `billing = billing method`   | True     |string  | Sets the billing method applied to the purchased number. `billing method` must be one of the following: <ul><li>`METERED` — unlimited concurrent calls, each billed per-minute used.</li> <li> `VPRI` — limits the number of concurrent calls to the number of VPRI channels you have, but with unlimited usage on each channel. </li></ul>|       
| `number = phone number` | True    | string | The `phone number` to purchase, using an E.164 *`1NPANXXXXXX`* format.                |
##### Example Usage

In the following method, the billing method is VPRI, and the phone number is a number retrieved from the [search](#searchno) method.

	response = tnc.purchase(billing="VPRI", number="12066417744")

#####Example response

*	A successful purchase returns an empty string: `""`
* 	An error response can return the following:

	| Error code | Message  | Description                                           |
	|------------|----------|-------------------------------------------------------|
	|No error code.  |HTTP Response Not OK|This can be caused when an incorrect phone number or billing method are entered.|

#### `list_account_telephone_numbers (limit, page, pattern)`<a name=listnumbers></a>

The `listAccountTelephoneNumbers` method is used to retrieve a list of all of the phone numbers on your Flowroute account.

#####Usage
Add the following line between `tnc = FlowrouteNumbers::TelephoneNumbersController.new()` and `puts response`:

	response = tnc.list_account_telephone_numbers(limit:nil, page:nil, pattern:nil)
	
>**Note:** `response` can be any name of your choosing, and of any length, but the name you choose must be used consistently in the method.

The method takes the following parameters:

| Parameter | Required |     Type | Description                                    |
|-----------|----------|-----------|-----------------------------------------------|
| `limit`     | False    | integer| Controls the number of items returned. The maximum number of phone numbers is 200. If neither a number nor `nil` are passed, a default of ten numbers are returned.                      
| `page`      | False  |integer  | Sets which page of the results is returned.` Next` and `Prev` URLs provided at the bottom of the response provide navigation pointers. If `nil` is passed, all pages are returned.   |
| pattern   | False | string  | The phone number on which to search. Partial number search is supported; for example, if `206` is passed the response returns all phone numbers which include `206`. If neither a number nor `nil` are passed, all numbers associated with the account are returned.  |

##### Example Usage

For this example, the `limit` is `1`, the `page` is `nil`, and the `pattern` includes `206`.
	
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
#####Response field descriptions
The following information is returned in the response:

Parameter | Description                                             |
|--------|-------------------------------------------------------|
| `tns`  | Object composed of a `telephone number`, `billing_method`, and `routes`.|                           
||	*`telephone number`*- The retrieved telephone number object, which is composed of:|
||	<ul><ul><li> `billing_method`- The billing method assigned to the phone number when the number was purchased. This will be either `METERED` or `VPRI`.</ul>|
| |<ul><ul><li>`routes`- Displays the primary `[0]` and failover `[1]` routes for the phone number: <ul><li>`type` — Indicates the type of route: `HOST`, `PSTN`, or `URI`. If no route is assigned, `SIP-REG` is the default name assigned to the route.</ul></li> <ul><li>`name` — Name of the route. If no `name` was given to the route, `sip-reg` is the assigned default name.</ul></li> **Note:** Routes are created using the [createNewRoute](#createroute) method and existing routes can be viewed using the [mlist](#listroutes) method.|

#### `telephone_number_details (number)`<a name=phonedetails></a>

The `telephone_number_details` method is used to retrieve the billing method, primary route, and failover route for the specified telephone number. 

#####Usage


Add the following line between `tnc = FlowrouteNumbers::TelephoneNumbersController.new()` and `puts response`:

	response = tnc.telephone_number_details('number')

The method takes the following parameter:

| Parameter       | Required | Type   |Description                                    |
|-----------------|----------|--------|-------------------------------------------|
| `number` | True     | string |    The telephone number on which to query. You must use an 11-digit, E.164 number, formatted as *`1NPANXXXXXX`*. Neither partial number search nor multiple number search are supported. |

##### Example Usage

In the following example, the details for the number purchased using the [purchase](#purchaseno) method is passed:

	response = tnc.telephone_number_details('12066417744')

#####Example response
The response returns the following information phone number details:

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

#####Response field descriptions	
 
The following information is returned in the response:

Parameter | Description                                             |
|--------|-------------------------------------------------------|                       
|`billing_method`| The billing method assigned to the phone number when the number was purchased. This will be either `METERED` or `VPRI`.|
|`routes` |Displays the primary and failover routes for the phone number. The first route group displays information about the primary route, the second about the failover route:<br> <ul><li>`type` — Indicates the type of route: `HOST`, `PSTN`, or `URI`. If no route is assigned, `SIP-REG` is the default name assigned to the route.</li> <li>`name` — Name of the route. If no `name` was given to the route, `sip-reg` is the default name.</ul></li>**Note:** Routes are created using the [createNewRoute](#createroute) method and can be assigned using the `update` method.|

#####Error response

An error response can return the following:

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code.  |HTTP Response Not OK|This can be caused when an incorrect phone number is entered.|

#### `update(number, routes)`<a name=updateroute></a>

The `update` method is used to update both the primary and failover route for a phone number, specified within an array. See Example Usage below. The first route name specified within the array is assigned as the primary route and the second route name assigned as the failover route. The list of available route names can be retrieved by using the the [`list`](#listroutes) method in the InboundRoutesController.

>**Note:** In order to apply an existing route to a number, the route must first be created using the [createNewRoute](#createRoute) method. To view a list of your existing routes, use the [`list`](#listroutes) method.

#####Usage
Add the following lines between `tnc = FlowrouteNumbers::TelephoneNumbersController.new()` and `puts response`:

	rtes = [name: "primary route name", name: "failover route name"]
	response = tnc.update(number='telephoneNumbe', routes=rtes)

>**Important:** `rtes` and `response` are variables that can be assigned any name of you choose, and of any length; however, you must use those names consistently within the method.

The method takes the following parameters:

| Parameter       | Required | Type |Description                                                       |
|-----------------|----------|-------|-----------------------------------------------------------------|
|`name:"route name"`|True| string| Name of an existing route. The first `name` in the array will be assigned the primary route; the second `name` in the array will be assigned the secondary, or failover, route. 
| `telephoneNumber` | True     | string |    The telephone number for which to update the route. You must use an 11-digit, E.164 number, formatted as *`1NPANXXXXXX`*.| 

##### Example Usage

The following example updates the routes for the telephone number purchased using the [purchase](#purchaseno) method:
	
	rtes = [{name: "HOSTroute1"}, {name: "URIroute1"}]
	response = tnc.update(number='12066417744', routes=rtes)

#####Example response

An empty string (`""`) is returned for a successful update. To view the route changes on the phone number, run the 
[`listAccountTelephoneNumbers()`](#listnumbers) or [`telephoneNumberDetails()`](#phonedetails) methods.

### InboundRoutesController<a name=inboundco></a>

The Inbound Routes Controller contains the methods required to view all of your existing inbound routes and to create new inbound routes.Methods must be added to a Ruby file and that file run from the **flowroute-numbers-ruby** directory in a terminal window. For example, you can create a **routes.rb** file that must contain the following information:

	require '/Users/jdoe/Documents/SDKs/flowroute-numbers-ruby/lib/flowroute_numbers/'
	require 'rubygems'
	
	FlowrouteNumbers::Configuration.username = 'AccessKey'
	FlowrouteNumbers::Configuration.password = 'SecretKey'  

	irc = FlowrouteNumbers::InboundRoutesController.new()
	
	puts response

Add the following InboundRoutesController methods between `irc = FlowrouteNumbers::InboundRoutesController.new()` and `puts response` and then comment out each method as needed. You can also create individual files for each method as long as each file contains the information above.

*	[`list`](#listroutes)
* 	[`createNewRoute`](#createroute)

#### `list (limit, page)`<a name=listroutes></a>

The list method is used to return all of the existing inbound routes from your Flowroute account.

#####Usage

Add the following InboundRoutesController methods between `irc = FlowrouteNumbers::InboundRoutesController.new()` and `puts response`
 
		response = irc.list(limit:nil, page:nil);

The method takes the following parameters:

| Parameter | Required | Type   |Description                                    |
|-----------|----------|---------|----------------------------------------|
| `limit:nil`     | False    | integer| Controls the number of routes returned. The maximum number is 200. If neither a number nor `null` are passed, a default of ten routes are returned.  |                    
| `page:nil`      | False  |integer  | Sets which page of the results is returned.` Next` and `Prev` URLs provided at the bottom of the response provide navigation pointers. If `nil` is passed, all pages are returned.   |

##### Example Usage

In the following example, a limit of `10` routes is to be returned, and only page `1` displayed:

	response = irc.list(limit:10, page:1);
	
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
| `[routeName]` |  The name of the route assigned using the `createNewRoute` method. It is composed of:<ul> <li>`type`  The type of route created using the `createNewRoute` method. Will be `HOST`, `PSTN`, or `URI`. If no route type was assigned, `SIP-REG` is used as the default. <li>`value` Value of the route, assigned to the route `type` using the `createNewRoute` method.</ul</li>|

#### `create_new_route(name, type, value)`<a name=createroute></a>

The `create_new_route `method is used to create a new inbound route.

#####Usage
Add the following line between `irc = FlowrouteNumbers::InboundRoutesController.new()` and `puts response`. You can create multiple routes simultaneously by adding the line for each route to create.

	response = irc.create_new_route(route_name='route_name',type='route_type',value='value')    

The method takes the following parameters:

| Parameter | Required | Type| Description                                                                        |
|-----------|----------|------|-----------------------------------------------------------------------------|
| `name` | True    |  string| The name of the new route. An unlimited number of alphanumeric characters is supported. There are no unrestricted characters.  |
| `type`      | True   |  string |The type of route you would like to create. Valid options are `HOST`, `PSTN`, and `URI`. |
| `value`     | True    |string |  Value of the route, dependent on the `type`: <ul><li>If `HOST`, the value must be an IP address or URL with an optional port number—for example, an IP address could be `24.239.23.40:5060` or a URL could be `myphone.com`. If no port is specified, the server will attempt to use DNS SRV records. <li>If `PSTN`, the value must be formatted as a valid E.164, 11-digit formatted North American phone number—for example,`12065551212 `. You cannot use the same number as the number for which the route is created. <li>If `URI`, the value must be formatted as  `protocol:user@domain[:port][;transport=<tcp/udp>`—for example, `sip:alice@seattle.com`,  `sip: 12065551212@215.122.69.152:5060;transport=tcp`, or `sips:securecall@securedserver.com`. You cannot use the same number as the number for which the route is created.</li></ul>              |
##### Example Usage

In the following example, routes are created for `PSTN`, `HOST`, and `URI`:

	response = irc.create_new_route(route_name='MyPSTN',type='PSTN',value='12065551212')
	response = irc.create_new_route(route_name='MyHost',type='HOST',value='24.239.23.40:5060')
	response = irc.create_new_route(route_name='MyURI',type='URI',value='sip:12065551212@215.122.69.152:5060')

#####Example response

An empty string (`""`) is returned for each successfully created route; no other code or message is returned. An error encountered for a specific `irc.create_new_route()` line will not prevent the other routes from being created.

####Error response
The following errors can be returned:

| Error code | Message  | Description                                           |
|------------|----------|-------------------------------------------------------|
|No error code|HTTP Response Not OK|Typically this occurs when a `value` is malformed. |