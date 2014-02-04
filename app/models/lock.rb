class Lock < ActiveRecord::Base
  include Concerns::DoorMethods
  extend Enumerize

  enumerize :state, in: [:open, :closed]

  belongs_to :door
  validates_presence_of :state

  def self.fetch(uri)
    params = get_params(uri)
    lock = Lock.new(params.remove(:uri).params)
    lock.state = params.get(:state)
    lock
    #Lock.new(state: :open)
  end

  def send_to_server(uri)
    json = self.to_j
    begin
      response = RestClient.put(uri, json, content_type: 'application/json', accept: 'application/json')
    rescue Exception => e
      logger.debug(e.message)
      return false
    end
    if response.code == 200
      return true
    end
    false
  end

  def to_j
    {'state' => state.upcase}.to_json
  end
end
