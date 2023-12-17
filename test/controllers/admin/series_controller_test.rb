require "test_helper"

class Admin::SeriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_series_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_series_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_series_show_url
    assert_response :success
  end
end
