class Door < ActiveRecord::Base
  include Concerns::DoorMethods

  has_many :locks, -> {order('created_at DESC').limit(20)}, dependent: :destroy
  has_many :opens, -> {order('created_at DESC').limit(20)}, dependent: :destroy

  validates_with DoorValidator

  def register_for_notifications(url, app_uri)
    begin
      response = RestClient.put to_url_for_publisher(url, app_uri), {uri: app_uri}.to_json, accept: 'application/json', content_type: 'application/json'
    rescue RestClient::Exception => e
      Rails.logger.debug "Error #{e.response.code} while contacting the host. The url is: '#{url}'"
        return
    rescue Errno::ECONNREFUSED => e
      Rails.logger.debug "Connection refused. The url is: '#{url}'"
      return
    end
    response.is_a? Hash
  end

  def un_register_for_notifications(url, app_uri)
    begin
      response = RestClient.delete to_url_for_publisher(url, app_uri), accept: 'application/json'
    rescue RestClient::Exception => e
      Rails.logger.debug "Error #{e.response.code} while contacting the host. The url is: '#{url}'"
      return
    rescue Errno::ECONNREFUSED => e
      Rails.logger.debug "Connection refused. The url is: '#{url}'"
      return
    end
    response.is_a? Hash
  end

  def self.fetch(uri)
    if uri.blank? || uri == 'http://' || uri == 'https://'
      logger.debug(uri)
      return Door.new
    end
    begin
      params = get_params(uri).get(:listOfDevices)
      if params.nil?
        door = Door.new()
      else
        door = Door.new(lock_uri: params.get(:lock).get(:uri), open_uri: params.get(:open).get(:uri))
      end
    rescue SocketError, URI::InvalidURIError => e
      door = Door.new()
      logger.info('pas bien')
    end
    door.uri = uri
    door
  end

  private
  def to_url_for_publisher(url, app_uri)
    url + '/pub/' + app_uri
  end
end

