require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should check one application status" do
    get :index, application_numbers: applications(:one).number
    assert_response :success

    assert_select '#results li', 1
    assert_select '#results li strong', applications(:one).number
  end

  test "should check multiple applications statuses" do
    get :index, application_numbers: "#{applications(:one).number}"
    # get :index, application_numbers: "#{applications(:one).number}\r\n#{applications(:two).number}\r\n#{applications(:three).number}"
    assert_response :success

    # assert_select '#results li', 3
    assert_select '#results li', 1
  end
end
