require './lib/app_server/request'
require 'minitest/autorun'

class TestRequest < MiniTest::Test

  def setup
    @request = Request.new
  end

  def test_that_request_parser_returns_method
    match = @request.parse('GET /index.html HTTP/1.1')
    assert_equal match[:method], 'GET'
    assert_equal match[:resource], '/index.html'
  end

  def test_that_request_parser_ignores_body
    match = @request.parse("GET /index.html HTTP/1.1\n Accept: This and that\n Body: GET /index2.html HTTP/1.90")
    assert_equal match[:method], 'GET'
    assert_equal match[:resource], '/index.html'
  end

  def test_split_body
    expected_string = "this is the body"
    actual_string = "GET / HTTP/1.1\r\nUser-Agent: curl/7.37.1\r\nHost: localhost:2345\r\nAccept: */*\r\n\r\nthis is the body"
    assert_equal expected_string, @request.split_body(actual_string)
  end

  def test_split_body_without_a_body
    expected_string = ""
    actual_string = "GET / HTTP/1.1\r\nUser-Agent: curl/7.37.1\r\nHost: localhost:2345\r\n\r\n"
    assert_equal expected_string, @request.split_body(actual_string)
  end

end
