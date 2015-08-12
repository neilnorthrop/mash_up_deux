class Request

  def parse(string)
    pattern = /\A(?<method>\w+)\s+(?<resource>\S+)/
    match = pattern.match(string)
    return { :method => match["method"], :resource => match["resource"], :params => split_body(string) }
  end

  def split_body(string)
    if string.split("\r\n\r\n")[1]
      return string.split("\r\n\r\n")[1]
    else
      return ""
    end
  end

end
