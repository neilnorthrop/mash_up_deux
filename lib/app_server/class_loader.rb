class ClassLoader
  attr_accessor :path_to_files, :loaded_files, :classes

  def initialize(path)
    @path_to_files = path
    @loaded_files  = []
    @classes       = []
  end

  def directory_listing
    Dir.new(Dir.pwd + path_to_files)
  end

  def dir_files
    directory_listing.entries
  end

  def requiring(controller)
    require Dir.pwd + path_to_files + controller
  end

  def load_files
    dir_files.each do |controller|
      next if controller == "." or controller == ".."
      loaded_files << controller
      classes << file_name_to_class_name(controller)
    end
  end

  def file_name_to_class_name(file_name)
    file_name.chomp('.rb').split('_').each(&:capitalize!).join
  end

  def classify
    classes.each do |klass|
      p Object.const_get(klass).new
    end
  end

end
