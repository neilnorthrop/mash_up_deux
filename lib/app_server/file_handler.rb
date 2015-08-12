require_relative 'haml_builder'
require_relative 'html_builder'

class FileHandler

  attr_accessor :path, :body, :response_code, :content_type, :file_size

  CONTENT_TYPE_MAPPING = {
    'html' => 'text/html',
    'txt'  => 'text/plain',
    'png'  => 'image/png',
    'jpg'  => 'image/jpg',
    'haml' => 'text/html'
  }

  RESPONSE_CODE = {
    '100' => 'Continue',
    '200' => 'OK',
    '201' => 'Created',
    '202' => 'Accepted',
    '400' => 'Bad Request',
    '403' => 'Forbidden',
    '404' => 'Not Found',
    '500' => 'Internal Server Error',
    '502' => 'Bad Gateway'
  }

  DEFAULT_CONTENT_TYPE = 'application/octet-stream'
  WEB_ROOT = './lib/app_server/app/tic_tac_toe/public'

  DEFAULT_INDEX = '/game.haml'
  NOT_FOUND = './public/404.html'

  def initialize(path="")
    @path          = clean_path(path)
    @builder       = pick_builder(@path)
    @body          = ""
    @response_code = ""
    @content_type  = ""
    @file_size     = 0
  end

  def pick_builder(path)
    if extention_type(path) == 'haml'
      return HamlBuilder.new
    else
      return HtmlBuilder.new
    end
  end

  def build_body(path)
    @body = @builder.build(path)
    get_size(@body)
  end

  def get_content_type(path)
    ext = extention_type(path)
    CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
  end

  def extention_type(path)
    File.extname(path).split('.').last
  end

  def handle_file
    if File.exist?(@path) && !File.directory?(@path)
      build_body(@path)
      @response_code = RESPONSE_CODE.rassoc('OK').join("/")
      @content_type = get_content_type(@path)
    else
      build_body('./public/404.html')
      @response_code = RESPONSE_CODE.rassoc('Not Found').join("/")
    end
  end

  def get_size(file)
    self.file_size = file.size
  end

  def clean_path(path)
    clean = []

    parts = path.split("/")
    parts.each do |part|
      next if part.empty? || part == '.'
      part == '..' ? clean.pop : clean << part
    end
    path = File.join(WEB_ROOT, *clean)
    path = File.join(path, DEFAULT_INDEX) if File.directory?(path)
    return path
  end

end
