# This file was automatically generated for flowroute by APIMATIC BETA v2.0 on 02/13/2016

module FlowrouteNumbers
  class InboundRoutesController

    # TODO: type endpoint description here
    # @param [Numeric] limit Optional parameter: Number of items to display (max 200)
    # @param [Numeric] page Optional parameter: Page to display if paginated
    # @return mixed response from the API call
    def list limit: nil, page: nil
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/routes/"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "limit" => limit,
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

    # Create a new inbound route to be used by a phone number
    # @param [String] route_name Required parameter: New unique name for the route
    # @param [String] type Required parameter: Type of inbound route
    # @param [String] value Required parameter: The value to be associated with a route.
    # @return String response from the API call
    def create_new_route route_name, type, value
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/routes/{route_name}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "route_name" => route_name,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute SDK 1.0",
        "content-type" => "application/json; charset=utf-8"
      }

      # append custom auth authorization
      CustomAuthUtility.append_custom_auth_params headers

      # invoke the API call request to fetch the response
      response = Unirest.put query_url, headers:headers, parameters:type.to_json

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