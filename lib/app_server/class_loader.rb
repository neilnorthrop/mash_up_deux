class ClassLoader
  attr_accessor :path_to_files, :loaded_files, :classes

  def initialize(path)
    @path_to_files = path
    @loaded_files  = []
    @classes       = []
  end

  def run
    collect_file_names
    file_require
    collect_class_names
  end

  def file_require
    loaded_files.each do |file|
      requiring(file)
    end
  end

  def requiring(file)
    require Dir.pwd + path_to_files + file
  end

  def file_name_to_class_name(file_name)
    file_name.chomp('.rb').split('_').each(&:capitalize!).join
  end
  alias to_class file_name_to_class_name

  def collect_file_names
    dir_files.each do |file|
      next if file == '.' or file == '..'
      loaded_files << file
    end
  end

  private
  def directory_listing
    Dir.new(Dir.pwd + path_to_files)
  end

  def dir_files
    directory_listing.entries
  end

  def collect_class_names
    loaded_files.each do |file|
      classes << to_class(file)
    end
  end

  def classify
    klasses = []
    classes.each do |klass|
      klasses << Object.const_get(klass).new
    end
    return klasses
  end

end
