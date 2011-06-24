require 'test_helper'

class PhoneTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_type" do
    assert_difference('PhoneType.count') do
      post :create, :phone_type => { }
    end

    assert_redirected_to phone_type_path(assigns(:phone_type))
  end

  test "should show phone_type" do
    get :show, :id => phone_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => phone_types(:one).to_param
    assert_response :success
  end

  test "should update phone_type" do
    put :update, :id => phone_types(:one).to_param, :phone_type => { }
    assert_redirected_to phone_type_path(assigns(:phone_type))
  end

  test "should destroy phone_type" do
    assert_difference('PhoneType.count', -1) do
      delete :destroy, :id => phone_types(:one).to_param
    end

    assert_redirected_to phone_types_path
  end
end
