class DoorParams

  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def get(key)
    value = params[key.to_s]
    if key == :state and value.is_a? String
      return value.downcase.to_sym
    end
    if value.is_a? Hash
      return DoorParams.new(value)
    end
    value
  end

  def remove(key)
    params.delete(key.to_s)
    self
  end
end