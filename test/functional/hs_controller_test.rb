require 'test_helper'

class HsControllerTest < ActionController::TestCase
  setup do
    @h = hs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create h" do
    assert_difference('H.count') do
      post :create, h: { name: @h.name }
    end

    assert_redirected_to h_path(assigns(:h))
  end

  test "should show h" do
    get :show, id: @h
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @h
    assert_response :success
  end

  test "should update h" do
    put :update, id: @h, h: { name: @h.name }
    assert_redirected_to h_path(assigns(:h))
  end

  test "should destroy h" do
    assert_difference('H.count', -1) do
      delete :destroy, id: @h
    end

    assert_redirected_to hs_path
  end
end
