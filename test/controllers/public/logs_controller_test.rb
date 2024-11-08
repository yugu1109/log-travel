require "test_helper"

class Public::LogsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_logs_new_url
    assert_response :success
  end

  test "should get index" do
    get public_logs_index_url
    assert_response :success
  end

  test "should get show" do
    get public_logs_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_logs_edit_url
    assert_response :success
  end
end
