# This file was automatically generated for flowroute by APIMATIC BETA v2.0 on 02/13/2016

module FlowrouteNumbers
  class TelephoneNumbersController

    # Returns the routing and billing information for the specified telephone number on your account
    # @param [String] telephone_number Required parameter: This is the TN for which you would like to retrieve configuration details for
    # @return String response from the API call
    def telephone_number_details telephone_number
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/tns/{telephone_number}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "telephone_number" => telephone_number,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute SDK 1.0"
      }

      response = CustomAuthUtility.append_custom_auth_params method:'GET',
                                                             query_url:query_url,
                                                             headers:headers

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "NOT AUTHORIZED", 401, response.raw_body
      elsif response.code == 500
        raise APIException.new "APPLICATION/SERVER ERROR", 500, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Purchases the telephone number indicated by the request URI, with the billing method indicated in the body. Allowable billing methods are returned in the search results for available telephone numbers.
    # @param [BillingMethod] billing Required parameter: The billing method to apply to the telephone number being purchased.
    # @param [String] number Required parameter: Telephone number to purchase
    # @return String response from the API call
    def purchase billing, number
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/tns/{number}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "number" => number,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute SDK 1.0",
        "content-type" => "application/json; charset=utf-8"
      }

      response = CustomAuthUtility.append_custom_auth_params method:'PUT',
                                                             query_url:query_url,
                                                             body:"{\"billing_method\": #{billing.to_json}}",
                                                             headers:headers

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "NOT AUTHORIZED", 401, response.raw_body
      elsif response.code == 500
        raise APIException.new "APPLICATION/SERVER ERROR", 500, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Retrieves a list of all the phone numbers on your account
    # @param [Numeric] limit Optional parameter: Number of items to display (max 200)
    # @param [Numeric] page Optional parameter: Page to display
    # @param [String] pattern Optional parameter: A full or partial telephone number to search for
    # @return mixed response from the API call
    def list_account_telephone_numbers limit: nil, page: nil, pattern: nil
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/tns/"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "limit" => limit,
        "page" => page,
        "pattern" => pattern,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute SDK 1.0",
        "accept" => "application/json"
      }

      response = CustomAuthUtility.append_custom_auth_params method:'GET',
                                                             query_url:query_url,
                                                             headers:headers

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "NOT AUTHORIZED", 401, response.raw_body
      elsif response.code == 500
        raise APIException.new "APPLICATION/SERVER ERROR", 500, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Updates the routing information for a telephone number on your account, as indicated by the specified URI. The body of the request requires two routes listed in order of preference (primary first and fail over second).
    # @param [String] number Required parameter: The telephone number who's routing you wish to update
    # @param [Array<Route>] routes Required parameter: JSON string containing the The routes obtained from the routes resource that you would like to point your telephone number to.
    # @return String response from the API call
    def update number, routes
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/tns/{number}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "number" => number,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute SDK 1.0",
        "content-type" => "application/json; charset=utf-8"
      }

      response = CustomAuthUtility.append_custom_auth_params method:'PATCH',
                                                             query_url:query_url,
                                                             body:"{\"routes\": #{routes.to_json}}",
                                                             headers:headers

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "NOT AUTHORIZED", 401, response.raw_body
      elsif response.code == 500
        raise APIException.new "APPLICATION/SERVER ERROR", 500, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

  end
end