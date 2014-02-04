require 'active_support/concern'
module Concerns::DoorMethods  extend  ActiveSupport::Concern
  module ClassMethods
    def get_params(uri)
      parse_params(RestClient.get(uri, accept: 'application/json').to_str)
    end

    def send_put_params(uri, json)
      response = RestClient.put(uri, json, content_type: :json)
      if response.status == 200
        return true
      end
      false
    end

    private

    def parse_params(str)
      DoorParams.new(JSON.parse(str))
    end
  end
end