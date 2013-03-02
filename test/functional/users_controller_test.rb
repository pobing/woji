require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { avatat_id: @user.avatat_id, email: @user.email, hashed_password: @user.hashed_password, login: @user.login, name: @user.name, nick_name: @user.nick_name, phone: @user.phone, salt: @user.salt, sex: @user.sex }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { avatat_id: @user.avatat_id, email: @user.email, hashed_password: @user.hashed_password, login: @user.login, name: @user.name, nick_name: @user.nick_name, phone: @user.phone, salt: @user.salt, sex: @user.sex }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
