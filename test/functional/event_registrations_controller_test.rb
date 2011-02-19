require 'test_helper'

class EventRegistrationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_registration" do
    assert_difference('EventRegistration.count') do
      post :create, :event_registration => { }
    end

    assert_redirected_to event_registration_path(assigns(:event_registration))
  end

  test "should show event_registration" do
    get :show, :id => event_registrations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => event_registrations(:one).to_param
    assert_response :success
  end

  test "should update event_registration" do
    put :update, :id => event_registrations(:one).to_param, :event_registration => { }
    assert_redirected_to event_registration_path(assigns(:event_registration))
  end

  test "should destroy event_registration" do
    assert_difference('EventRegistration.count', -1) do
      delete :destroy, :id => event_registrations(:one).to_param
    end

    assert_redirected_to event_registrations_path
  end
end
