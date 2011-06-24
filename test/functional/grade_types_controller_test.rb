require 'test_helper'

class GradeTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grade_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grade_type" do
    assert_difference('GradeType.count') do
      post :create, :grade_type => { }
    end

    assert_redirected_to grade_type_path(assigns(:grade_type))
  end

  test "should show grade_type" do
    get :show, :id => grade_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => grade_types(:one).to_param
    assert_response :success
  end

  test "should update grade_type" do
    put :update, :id => grade_types(:one).to_param, :grade_type => { }
    assert_redirected_to grade_type_path(assigns(:grade_type))
  end

  test "should destroy grade_type" do
    assert_difference('GradeType.count', -1) do
      delete :destroy, :id => grade_types(:one).to_param
    end

    assert_redirected_to grade_types_path
  end
end
