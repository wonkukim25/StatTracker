require 'test_helper'

class PitchingPostStatsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => PitchingPostStat.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    PitchingPostStat.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    PitchingPostStat.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to pitching_post_stat_url(assigns(:pitching_post_stat))
  end

  def test_edit
    get :edit, :id => PitchingPostStat.first
    assert_template 'edit'
  end

  def test_update_invalid
    PitchingPostStat.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PitchingPostStat.first
    assert_template 'edit'
  end

  def test_update_valid
    PitchingPostStat.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PitchingPostStat.first
    assert_redirected_to pitching_post_stat_url(assigns(:pitching_post_stat))
  end

  def test_destroy
    pitching_post_stat = PitchingPostStat.first
    delete :destroy, :id => pitching_post_stat
    assert_redirected_to pitching_post_stats_url
    assert !PitchingPostStat.exists?(pitching_post_stat.id)
  end
end
