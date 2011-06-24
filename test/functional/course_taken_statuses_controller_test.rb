require 'test_helper'

class CourseTakenStatusesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_taken_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_taken_status" do
    assert_difference('CourseTakenStatus.count') do
      post :create, :course_taken_status => { }
    end

    assert_redirected_to course_taken_status_path(assigns(:course_taken_status))
  end

  test "should show course_taken_status" do
    get :show, :id => course_taken_statuses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => course_taken_statuses(:one).to_param
    assert_response :success
  end

  test "should update course_taken_status" do
    put :update, :id => course_taken_statuses(:one).to_param, :course_taken_status => { }
    assert_redirected_to course_taken_status_path(assigns(:course_taken_status))
  end

  test "should destroy course_taken_status" do
    assert_difference('CourseTakenStatus.count', -1) do
      delete :destroy, :id => course_taken_statuses(:one).to_param
    end

    assert_redirected_to course_taken_statuses_path
  end
end
