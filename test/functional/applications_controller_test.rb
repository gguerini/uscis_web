require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  setup do
    @application = applications(:one)
    login_as users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application" do
    new_app_number = "MSC1390803620"
    assert_difference('Application.count') do
      post :create, application: { number: new_app_number }
    end

    @new_application = Application.where(number: new_app_number).first
    assert_redirected_to application_path(@new_application)
  end

  test "should show application" do
    get :show, id: @application
    assert_response :success
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete :destroy, id: @application
    end

    assert_redirected_to applications_path
  end
end
