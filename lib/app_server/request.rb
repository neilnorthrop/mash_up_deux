require_relative 'file_handler'
require_relative 'response'

class Request

  def build(string)
    request = parse(string)
    file_handler = FileHandler.new(request[:resource])
    file_handler.handle_file
    return Response.build_header(file_handler)
  end

  def parse(string)
    pattern = /\A(?<method>\w+)\s+(?<resource>\S+)\s+(?<version>\S+)/
    match = pattern.match(string)
    return { :method => match["method"], :resource => match["resource"], :version => match["version"], :body => split_body(string) }
  end

  def split_body(string)
    if string.split("\r\n\r\n")[1]
      return string.split("\r\n\r\n")[1]
    else
      return ""
    end
  end

end
