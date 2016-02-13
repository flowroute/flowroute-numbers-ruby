# This file was automatically generated for flowroute by APIMATIC BETA v2.0 on 02/13/2016

module FlowrouteNumbers
  class PurchasablePhoneNumbersController

    # Retrieves a list of the NPA-NXXs (area codes and exchanges) that contain purchasable telephone numbers.
    # @param [Numeric] limit Optional parameter: Number of items to display (Max 200)
    # @param [Numeric] npa Optional parameter: Restricts the results to this NPA.
    # @param [Numeric] page Optional parameter: Page to display
    # @return mixed response from the API call
    def list_area_and_exchange limit: nil, npa: nil, page: nil
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/available-tns/npanxxs/"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "limit" => limit,
        "npa" => npa,
        "page" => page,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute SDK 1.0",
        "accept" => "application/json"
      }

      # append custom auth authorization
      CustomAuthUtility.append_custom_auth_params headers

      # invoke the API call request to fetch the response
      response = Unirest.get query_url, headers:headers

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

    # Retrieves a list of all NPAs (area codes) that contain purchasable telephone numbers.
    # @param [Numeric] limit Required parameter: Number of items to display (Max 200).
    # @return mixed response from the API call
    def list_available_np_as limit
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/available-tns/npas/"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "limit" => limit,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute SDK 1.0",
        "accept" => "application/json"
      }

      # append custom auth authorization
      CustomAuthUtility.append_custom_auth_params headers

      # invoke the API call request to fetch the response
      response = Unirest.get query_url, headers:headers

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

    # TODO: type endpoint description here
    # @param [Numeric] limit Optional parameter: Number of items to display (Max 200)
    # @param [Numeric] npa Optional parameter: Restricts the results to the three digit NPA (area code) specified. This is optional, unless NXX is present
    # @param [Numeric] nxx Optional parameter: Restricts the results to the three digit NXX (exchange) specified.
    # @param [Numeric] page Optional parameter: Page to display
    # @param [String] ratecenter Optional parameter: Restricts the results to the ratecenter specified. If present, state is required
    # @param [String] state Optional parameter: Restricts the results to the state specified. This is optional, unless ratecenter is present.
    # @param [String] tn Optional parameter: Restricts the results to the telephone number specified.
    # @return mixed response from the API call
    def search limit: nil, npa: nil, nxx: nil, page: nil, ratecenter: nil, state: nil, tn: nil
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/available-tns/tns/"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "limit" => limit,
        "npa" => npa,
        "nxx" => nxx,
        "page" => page,
        "ratecenter" => ratecenter,
        "state" => state,
        "tn" => tn,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute SDK 1.0",
        "accept" => "application/json"
      }

      # append custom auth authorization
      CustomAuthUtility.append_custom_auth_params headers

      # invoke the API call request to fetch the response
      response = Unirest.get query_url, headers:headers

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