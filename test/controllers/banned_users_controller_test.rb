require 'test_helper'

class BannedUsersControllerTest < ActionController::TestCase
  setup do
    @banned_user = banned_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banned_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banned_user" do
    assert_difference('BannedUser.count') do
      post :create, banned_user: { email: @banned_user.email }
    end

    assert_redirected_to banned_user_path(assigns(:banned_user))
  end

  test "should show banned_user" do
    get :show, id: @banned_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @banned_user
    assert_response :success
  end

  test "should update banned_user" do
    patch :update, id: @banned_user, banned_user: { email: @banned_user.email }
    assert_redirected_to banned_user_path(assigns(:banned_user))
  end

  test "should destroy banned_user" do
    assert_difference('BannedUser.count', -1) do
      delete :destroy, id: @banned_user
    end

    assert_redirected_to banned_users_path
  end
end
