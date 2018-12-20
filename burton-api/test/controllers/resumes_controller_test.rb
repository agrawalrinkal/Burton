require 'test_helper'

class ResumesControllerTest < ActionController::TestCase
  setup do
    @resume = resumes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resumes)
  end

  test "should create resume" do
    assert_difference('Resume.count') do
      post :create, resume: {  }
    end

    assert_response 201
  end

  test "should show resume" do
    get :show, id: @resume
    assert_response :success
  end

  test "should update resume" do
    put :update, id: @resume, resume: {  }
    assert_response 204
  end

  test "should destroy resume" do
    assert_difference('Resume.count', -1) do
      delete :destroy, id: @resume
    end

    assert_response 204
  end
end
