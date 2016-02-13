# This file was automatically generated for flowroute by APIMATIC BETA v2.0 on 02/13/2016

module FlowrouteNumbers
  class BillingMethodModel

    # VPRI or METERED
    # @return [String]
    attr_accessor :billing_method

    
    def method_missing (method_name)
      puts "there's no method called '#{method_name}'"
    end

    # Creates JSON of the curent object  
    def to_json
      hash = self.key_map()
      hash.to_json
    end

    # Defines the key map for json serialization  
    def key_map
      hash = {}
      hash['billing_method'] = self.billing_method
      hash
    end

  end
end