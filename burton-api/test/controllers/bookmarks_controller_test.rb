require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  setup do
    @bookmark = bookmarks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmarks)
  end

  test "should create bookmark" do
    assert_difference('Bookmark.count') do
      post :create, bookmark: { ref: @bookmark.ref, snippet: @bookmark.snippet }
    end

    assert_response 201
  end

  test "should show bookmark" do
    get :show, id: @bookmark
    assert_response :success
  end

  test "should update bookmark" do
    put :update, id: @bookmark, bookmark: { ref: @bookmark.ref, snippet: @bookmark.snippet }
    assert_response 204
  end

  test "should destroy bookmark" do
    assert_difference('Bookmark.count', -1) do
      delete :destroy, id: @bookmark
    end

    assert_response 204
  end
end
