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
      if parsed_url.query
        hash_qp = CGI::parse(parsed_url.query)
        ordered_qp = URI.encode_www_form(Hash[hash_qp.sort])
      else
        ordered_qp = ''
      end
      canonical_uri = "#{parsed_url.scheme}://#{parsed_url.host}#{parsed_url.path}\n#{ordered_qp}"
      if ordered_qp.nil? || ordered_qp.empty?
        canonical_url = "#{parsed_url.scheme}://#{parsed_url.host}#{parsed_url.path}"
      else
        canonical_url = "#{parsed_url.scheme}://#{parsed_url.host}#{parsed_url.path}?#{ordered_qp}"
      end
      message_string = "#{timestamp}\n#{method}\n#{body_md5}\n#{canonical_uri}"
      signature = OpenSSL::HMAC.hexdigest('sha1', Configuration.password.dup, message_string)
      if method == 'GET'
        response = Unirest.get canonical_url,
                               headers:headers, 
                               auth:{:user=>Configuration.username.dup, :password=>signature}
      elsif method == 'POST'
        response = Unirest.post canonical_url, 
                                headers:headers, 
                                parameters:body, 
                                auth:{:user=>Configuration.username.dup, :password=>signature}
      elsif method == 'PUT'
        response = Unirest.put canonical_url, 
                               headers:headers, 
                               parameters:body, 
                               auth:{:user=>Configuration.username.dup, :password=>signature}
      elsif method == 'PATCH'
        response = Unirest.patch canonical_url, 
                                 headers:headers, 
                                 parameters:body, 
                                 auth:{:user=>Configuration.username.dup, :password=>signature}
      elsif method == 'DELETE'
        response = Unirest.delete canonical_url, 
                                  headers:headers, 
                                  parameters:body, 
                                  auth:{:user=>Configuration.username.dup, :password=>signature}
      end
      response

    end
    
  end
end