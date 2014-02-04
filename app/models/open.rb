class Open < ActiveRecord::Base
  include Concerns::DoorMethods
  extend Enumerize

  enumerize :state, in: [:open, :opening, :closing, :closed]

  belongs_to :door
  validates_presence_of :state
  validates :position, numericality: :only_integer, inclusion: 0..100

  def self.fetch(uri)
    params = get_params(uri)
    open = Open.new(params.remove(:uri).params)
    open.state = params.get(:state)
    open
    #Open.new(position: 100, state: :open)
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
    server_params = {}
    server_params['state'] = state.to_s.upcase unless state.nil?
    server_params['position'] = position.to_s unless position.nil?
    server_params.to_json
  end
end
