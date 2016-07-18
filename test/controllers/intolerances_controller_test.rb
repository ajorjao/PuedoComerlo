require 'test_helper'

class IntolerancesControllerTest < ActionController::TestCase
  setup do
    @intolerance = intolerances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:intolerances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intolerance" do
    assert_difference('Intolerance.count') do
      post :create, intolerance: { key_component: @intolerance.key_component, major_symptom: @intolerance.major_symptom, medium_symptom: @intolerance.medium_symptom, minor_symptom: @intolerance.minor_symptom, name: @intolerance.name }
    end

    assert_redirected_to intolerance_path(assigns(:intolerance))
  end

  test "should show intolerance" do
    get :show, id: @intolerance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @intolerance
    assert_response :success
  end

  test "should update intolerance" do
    patch :update, id: @intolerance, intolerance: { key_component: @intolerance.key_component, major_symptom: @intolerance.major_symptom, medium_symptom: @intolerance.medium_symptom, minor_symptom: @intolerance.minor_symptom, name: @intolerance.name }
    assert_redirected_to intolerance_path(assigns(:intolerance))
  end

  test "should destroy intolerance" do
    assert_difference('Intolerance.count', -1) do
      delete :destroy, id: @intolerance
    end

    assert_redirected_to intolerances_path
  end
end
