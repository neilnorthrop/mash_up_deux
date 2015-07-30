require './lib/app_server/class_loader.rb'
require 'minitest/autorun'

class ClassLoaderTest < MiniTest::Test

  def setup
    @class_loader = ClassLoader.new('/test/app_server/fixtures/')
  end

  def test_file_name_to_class_name
    assert_equal 'FileTesting', @class_loader.file_name_to_class_name('file_testing.rb')
  end

  def test_requiring
    assert_equal true, @class_loader.requiring('file_testing.rb')
  end

  def test_load_files
    @class_loader.collect_file_names

    assert_equal ['file_testing.rb', 'file_testing_b.rb'], @class_loader.loaded_files
  end

end
