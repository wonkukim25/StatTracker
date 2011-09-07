require 'test_helper'

class FranchisesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Franchise.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Franchise.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Franchise.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to franchise_url(assigns(:franchise))
  end

  def test_edit
    get :edit, :id => Franchise.first
    assert_template 'edit'
  end

  def test_update_invalid
    Franchise.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Franchise.first
    assert_template 'edit'
  end

  def test_update_valid
    Franchise.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Franchise.first
    assert_redirected_to franchise_url(assigns(:franchise))
  end

  def test_destroy
    franchise = Franchise.first
    delete :destroy, :id => franchise
    assert_redirected_to franchises_url
    assert !Franchise.exists?(franchise.id)
  end
end
