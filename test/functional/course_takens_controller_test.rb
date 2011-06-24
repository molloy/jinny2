require 'test_helper'

class CourseTakensControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_takens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_taken" do
    assert_difference('CourseTaken.count') do
      post :create, :course_taken => { }
    end

    assert_redirected_to course_taken_path(assigns(:course_taken))
  end

  test "should show course_taken" do
    get :show, :id => course_takens(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => course_takens(:one).to_param
    assert_response :success
  end

  test "should update course_taken" do
    put :update, :id => course_takens(:one).to_param, :course_taken => { }
    assert_redirected_to course_taken_path(assigns(:course_taken))
  end

  test "should destroy course_taken" do
    assert_difference('CourseTaken.count', -1) do
      delete :destroy, :id => course_takens(:one).to_param
    end

    assert_redirected_to course_takens_path
  end
end
