require 'test_helper'

class CatagoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get catagories_show_url
    assert_response :success
  end

end
