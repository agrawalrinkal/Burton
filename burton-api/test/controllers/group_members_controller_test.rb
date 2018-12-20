require 'test_helper'

class GroupMembersControllerTest < ActionController::TestCase
  setup do
    @group_member = group_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_members)
  end

  test "should create group_member" do
    assert_difference('GroupMember.count') do
      post :create, group_member: {  }
    end

    assert_response 201
  end

  test "should show group_member" do
    get :show, id: @group_member
    assert_response :success
  end

  test "should update group_member" do
    put :update, id: @group_member, group_member: {  }
    assert_response 204
  end

  test "should destroy group_member" do
    assert_difference('GroupMember.count', -1) do
      delete :destroy, id: @group_member
    end

    assert_response 204
  end
end
