require 'test_helper'

class PersonTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:person_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person_type" do
    assert_difference('PersonType.count') do
      post :create, :person_type => { }
    end

    assert_redirected_to person_type_path(assigns(:person_type))
  end

  test "should show person_type" do
    get :show, :id => person_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => person_types(:one).to_param
    assert_response :success
  end

  test "should update person_type" do
    put :update, :id => person_types(:one).to_param, :person_type => { }
    assert_redirected_to person_type_path(assigns(:person_type))
  end

  test "should destroy person_type" do
    assert_difference('PersonType.count', -1) do
      delete :destroy, :id => person_types(:one).to_param
    end

    assert_redirected_to person_types_path
  end
end
