# This file was automatically generated for flowroute by APIMATIC BETA v2.0 on 02/13/2016
require 'Digest'
require 'time'
require 'uri'
require 'cgi'
require 'openssl'

module FlowrouteNumbers 
  class CustomAuthUtility
    
    # Appends the necessary OAuth credentials for making this authorized call
    # @param [Hash] The out going request to access the resource
    def self.append_custom_auth_params method:'GET', query_url:nil, body: nil, headers: nil
      timestamp = Time.now.utc.iso8601
      headers['X-Timestamp'] = timestamp

      body_md5 = ""
      if body
        body_md5 = Digest::MD5.hexdigest(body)
      end

      parsed_url = URI(query_url)
      hash_qp = CGI::parse(parsed_url.query)
      ordered_qp = URI.encode_www_form(Hash[hash_qp.sort])
      canonical_uri = "#{parsed_url.scheme}://#{parsed_url.host}#{parsed_url.path}\n#{ordered_qp}"
      message_string = "#{timestamp}\n#{method}\n#{body_md5}\n#{canonical_uri}"
      signature = OpenSSL::HMAC.hexdigest('sha1', Configuration.password.dup, message_string)
      if method == 'GET'
        response = Unirest.get query_url,
                               headers:headers, 
                               auth:{:user=>Configuration.username.dup, :password=>signature}
      elsif method == 'POST'
        response = Unirest.post query_url, 
                                headers:headers, 
                                parameters:body, 
                                auth:{:user=>Configuration.username.dup, :password=>signature}
      elsif method == 'PUT'
        response = Unirest.put query_url, 
                               headers:headers, 
                               parameters:body, 
                               auth:{:user=>Configuration.username.dup, :password=>signature}
      elsif method == 'PATCH'
        response = Unirest.patch query_url, 
                                 headers:headers, 
                                 parameters:body, 
                                 auth:{:user=>Configuration.username.dup, :password=>signature}
      elsif method == 'DELETE'
        response = Unirest.delete query_url, 
                                  headers:headers, 
                                  parameters:body, 
                                  auth:{:user=>Configuration.username.dup, :password=>signature}
      end
      response

    end
    
  end
end