class ClassLoader
  attr_accessor :path_to_files, :loaded_files, :classes

  def initialize(path)
    @path_to_files = path
    @loaded_files  = []
    @classes       = []
    load_files
  end

  def directory_listing
    Dir.new(Dir.pwd + path_to_files)
  end

  def controllers
    directory_listing.entries
  end

  def load_files
    controllers.each do |controller|
      next if controller == "." or controller == ".."
      require Dir.pwd + path_to_files + "/" + controller
      loaded_files << controller
      classes << file_name_to_class(controller)
    end
  end

  def file_name_to_class(file_name)
    file_name.chomp('.rb').split('_').each(&:capitalize!).join
  end

  def classify
    classes.each do |klass|
      p Object.const_get(klass).new
    end
  end

  def draw
    yield
  end
end
