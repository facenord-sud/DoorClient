class Door < ActiveRecord::Base
  include Concerns::DoorMethods

  has_many :locks, -> {order('created_at DESC').limit(20)}, dependent: :destroy
  has_many :opens, -> {order('created_at DESC').limit(20)}, dependent: :destroy

  validates_with DoorValidator

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
end

