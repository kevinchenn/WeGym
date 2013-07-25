require 'test_helper'

class GymsControllerTest < ActionController::TestCase
  setup do
    @gym = gyms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gyms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gym" do
    assert_difference('Gym.count') do
      post :create, gym: { email: @gym.email, gym: @gym.gym, owner: @gym.owner, password_hash: @gym.password_hash, period: @gym.period, plan: @gym.plan, price: @gym.price, wepay_access_token: @gym.wepay_access_token, wepay_account_id: @gym.wepay_account_id }
    end

    assert_redirected_to gym_path(assigns(:gym))
  end

  test "should show gym" do
    get :show, id: @gym
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gym
    assert_response :success
  end

  test "should update gym" do
    put :update, id: @gym, gym: { email: @gym.email, gym: @gym.gym, owner: @gym.owner, password_hash: @gym.password_hash, period: @gym.period, plan: @gym.plan, price: @gym.price, wepay_access_token: @gym.wepay_access_token, wepay_account_id: @gym.wepay_account_id }
    assert_redirected_to gym_path(assigns(:gym))
  end

  test "should destroy gym" do
    assert_difference('Gym.count', -1) do
      delete :destroy, id: @gym
    end

    assert_redirected_to gyms_path
  end
end
