require 'test_helper'

class BattingPostStatsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => BattingPostStat.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    BattingPostStat.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    BattingPostStat.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to batting_post_stat_url(assigns(:batting_post_stat))
  end

  def test_edit
    get :edit, :id => BattingPostStat.first
    assert_template 'edit'
  end

  def test_update_invalid
    BattingPostStat.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BattingPostStat.first
    assert_template 'edit'
  end

  def test_update_valid
    BattingPostStat.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BattingPostStat.first
    assert_redirected_to batting_post_stat_url(assigns(:batting_post_stat))
  end

  def test_destroy
    batting_post_stat = BattingPostStat.first
    delete :destroy, :id => batting_post_stat
    assert_redirected_to batting_post_stats_url
    assert !BattingPostStat.exists?(batting_post_stat.id)
  end
end
