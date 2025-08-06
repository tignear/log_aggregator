require "test_helper"

class Api::V1::LogsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_logs_create_url
    assert_response :success
  end
end
