require 'test_helper'

class DivisionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Division.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Division.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Division.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to division_url(assigns(:division))
  end

  def test_edit
    get :edit, :id => Division.first
    assert_template 'edit'
  end

  def test_update_invalid
    Division.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Division.first
    assert_template 'edit'
  end

  def test_update_valid
    Division.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Division.first
    assert_redirected_to division_url(assigns(:division))
  end

  def test_destroy
    division = Division.first
    delete :destroy, :id => division
    assert_redirected_to divisions_url
    assert !Division.exists?(division.id)
  end
end
