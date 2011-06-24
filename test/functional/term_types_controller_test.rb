require 'test_helper'

class TermTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:term_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create term_type" do
    assert_difference('TermType.count') do
      post :create, :term_type => { }
    end

    assert_redirected_to term_type_path(assigns(:term_type))
  end

  test "should show term_type" do
    get :show, :id => term_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => term_types(:one).to_param
    assert_response :success
  end

  test "should update term_type" do
    put :update, :id => term_types(:one).to_param, :term_type => { }
    assert_redirected_to term_type_path(assigns(:term_type))
  end

  test "should destroy term_type" do
    assert_difference('TermType.count', -1) do
      delete :destroy, :id => term_types(:one).to_param
    end

    assert_redirected_to term_types_path
  end
end
