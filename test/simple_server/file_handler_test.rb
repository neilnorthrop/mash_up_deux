require './lib/app_server/file_handler.rb'
require 'minitest/autorun'

class FileHandlerTest < MiniTest::Test

  def setup
    @file_handler = FileHandler.new("", "")
  end

  def test_get_content_type
    assert_equal 'text/html', @file_handler.get_content_type('./public/index.html')
    assert_equal 'application/octet-stream', @file_handler.get_content_type('./public/index')
  end

  def test_handle_file_found
    file_handle = FileHandler.new("index.html", "")
    file_handle.path = './test/simple_server/test.html'
    file_handle.handle_file
    assert_equal '200/OK', file_handle.response_code
  end

  def test_handle_file_not_found
    file_handle = FileHandler.new("index.html", "")
    file_handle.path = './test/hello.html'
    file_handle.handle_file
    assert_equal '404/Not Found', file_handle.response_code
  end

  def test_requested_file_joins_a_resource
    assert_equal './lib/app_server/app/tic_tac_toe/public/index.html', @file_handler.clean_path('/index.html')
  end

  def test_requested_file_keeps_directories
    assert_equal './lib/app_server/app/tic_tac_toe/public/hello/index.html', @file_handler.clean_path('/../../../hello/index.html')
  end

  def test_requested_file_removes_change_directories
    assert_equal './lib/app_server/app/tic_tac_toe/public/index.html', @file_handler.clean_path('/../../hello/../index.html')
  end

end
