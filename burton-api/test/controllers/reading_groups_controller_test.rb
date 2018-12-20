require 'test_helper'

class ReadingGroupsControllerTest < ActionController::TestCase
  setup do
    @reading_group = reading_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reading_groups)
  end

  test "should create reading_group" do
    assert_difference('ReadingGroup.count') do
      post :create, reading_group: {  }
    end

    assert_response 201
  end

  test "should show reading_group" do
    get :show, id: @reading_group
    assert_response :success
  end

  test "should update reading_group" do
    put :update, id: @reading_group, reading_group: {  }
    assert_response 204
  end

  test "should destroy reading_group" do
    assert_difference('ReadingGroup.count', -1) do
      delete :destroy, id: @reading_group
    end

    assert_response 204
  end
end
