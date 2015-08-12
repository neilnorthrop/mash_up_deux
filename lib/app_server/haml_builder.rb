require 'haml'

class HamlBuilder
  def build(path)
    Haml::Engine.new(File.read(path)).render
  end
end
