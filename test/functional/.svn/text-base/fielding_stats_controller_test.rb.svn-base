require 'test_helper'

class FieldingStatsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => FieldingStat.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    FieldingStat.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    FieldingStat.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to fielding_stat_url(assigns(:fielding_stat))
  end

  def test_edit
    get :edit, :id => FieldingStat.first
    assert_template 'edit'
  end

  def test_update_invalid
    FieldingStat.any_instance.stubs(:valid?).returns(false)
    put :update, :id => FieldingStat.first
    assert_template 'edit'
  end

  def test_update_valid
    FieldingStat.any_instance.stubs(:valid?).returns(true)
    put :update, :id => FieldingStat.first
    assert_redirected_to fielding_stat_url(assigns(:fielding_stat))
  end

  def test_destroy
    fielding_stat = FieldingStat.first
    delete :destroy, :id => fielding_stat
    assert_redirected_to fielding_stats_url
    assert !FieldingStat.exists?(fielding_stat.id)
  end
end
