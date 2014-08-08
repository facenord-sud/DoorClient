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

    def register_for_notifications(url, app_uri)
      url = url + '/pub'
      begin
        response = RestClient.put url, {uri: app_uri}.to_json, accept: 'application/json', content_type: 'application/json'
      rescue RestClient::Exception => e
        Rails.logger.debug "Error #{e.response.code} while contacting the host. The url is: '#{url}'"
      rescue Errno::ECONNREFUSED => e
        Rails.logger.debug "Connection refused. The url is: '#{url}'"
      end
      response.status == 200
    end

    private

    def parse_params(str)
      DoorParams.new(JSON.parse(str))
    end
  end
end