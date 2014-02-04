module ApplicationHelper
  def strip_uri(uri)
    uri.sub!(/https\:\/\//, '') if uri.include? 'https://'
    uri.sub!(/http\:\/\//, '')  if uri.include? 'http://'
    uri
  end

  def relative_time(start_time)
    diff_seconds = Time.now - start_time.to_time
    case diff_seconds
      when 0 .. 59
        "#{diff_seconds.to_f.round(0)} seconds ago"
      when 60 .. (3600-1)
        minutes = (diff_seconds/60).to_f.round
        seconds = (diff_seconds/60)-minutes
        "#{minutes} minutes ago"
      when 3600 .. (3600*24-1)
        "#{(diff_seconds/3600).to_f.round(0)} hours ago"
      when (3600*24) .. (3600*24*30)
        "#{(diff_seconds/(3600*24)).to_f.round(0)} days ago"
      else
        start_time.strftime("%m/%d/%Y")
    end
  end
end
