require 'test_helper'

class Admin::PeriodosControllerTest < ActionController::TestCase
  setup do
   @admin_periodo = periodos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_periodos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_periodo" do
    assert_difference('Admin::Periodo.count') do
      post :create, periodo: { inicio: @admin_periodo.inicio, termino: @admin_periodo.termino }
    end

    assert_redirected_to admin_periodo_path(assigns(:admin_periodo))
  end

  test "should show admin_periodo" do
    get :show, id: @admin_periodo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_periodo
    assert_response :success
  end

  test "should update admin_periodo" do
    patch :update, id: @admin_periodo, periodo: { inicio: @admin_periodo.inicio, termino: @admin_periodo.termino }
    assert_redirected_to admin_periodo_path(assigns(:admin_periodo))
  end

  test "should destroy admin_periodo" do
    assert_difference('Admin::Periodo.count', -1) do
      delete :destroy, id: @admin_periodo
    end

    assert_redirected_to admin_periodos_path
  end
end
