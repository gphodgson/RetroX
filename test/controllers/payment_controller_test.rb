require 'test_helper'

class PaymentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get payment_create_url
    assert_response :success
  end

  test "should get success" do
    get payment_success_url
    assert_response :success
  end

  test "should get cancel" do
    get payment_cancel_url
    assert_response :success
  end

end
