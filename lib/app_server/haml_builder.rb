require 'haml'

class HamlBuilder
  def build(path, opt)
    if opt.nil?
      Haml::Engine.new(File.read(path)).render
    else
      Haml::Engine.new(File.read(path)).render(Object.new, :game => opt)
    end
  end
end
