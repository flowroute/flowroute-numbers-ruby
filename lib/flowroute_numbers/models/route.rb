# This file was automatically generated for flowroute by APIMATIC BETA v2.0 on 02/13/2016

module FlowrouteNumbers
  class Route

    # Unique name of the inbound route, or the reserved options of 'sip-reg'.
    # @return [String]
    attr_accessor :name

    def initialize
    @name = "sip-reg"
    end
    
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
      hash['name'] = self.name
      hash
    end

  end
end