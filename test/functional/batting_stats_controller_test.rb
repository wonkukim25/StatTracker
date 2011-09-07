require 'test_helper'

class BattingStatsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => BattingStat.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    BattingStat.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    BattingStat.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to batting_stat_url(assigns(:batting_stat))
  end

  def test_edit
    get :edit, :id => BattingStat.first
    assert_template 'edit'
  end

  def test_update_invalid
    BattingStat.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BattingStat.first
    assert_template 'edit'
  end

  def test_update_valid
    BattingStat.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BattingStat.first
    assert_redirected_to batting_stat_url(assigns(:batting_stat))
  end

  def test_destroy
    batting_stat = BattingStat.first
    delete :destroy, :id => batting_stat
    assert_redirected_to batting_stats_url
    assert !BattingStat.exists?(batting_stat.id)
  end
end
