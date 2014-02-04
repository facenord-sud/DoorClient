class DoorValidator < ActiveModel::Validator
  def validate(record)
    if record.uri.blank?
      record.errors[:uri] << "Can't be blank"
      return
    end
    if record.lock_uri.blank? || record.open_uri.blank?
      record.uri = strip_uri(record.uri)
      record.errors[:uri] << 'Unable to contact the server. Retry or look for misspelling'
    end
  end

  def strip_uri(uri)
    uri.sub!(/https\:\/\//, '') if uri.include? 'https://'
    uri.sub!(/http\:\/\//, '')  if uri.include? 'http://'
    uri
  end
end