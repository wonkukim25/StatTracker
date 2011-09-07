require 'test_helper'

class PitchingStatsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => PitchingStat.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    PitchingStat.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    PitchingStat.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to pitching_stat_url(assigns(:pitching_stat))
  end

  def test_edit
    get :edit, :id => PitchingStat.first
    assert_template 'edit'
  end

  def test_update_invalid
    PitchingStat.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PitchingStat.first
    assert_template 'edit'
  end

  def test_update_valid
    PitchingStat.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PitchingStat.first
    assert_redirected_to pitching_stat_url(assigns(:pitching_stat))
  end

  def test_destroy
    pitching_stat = PitchingStat.first
    delete :destroy, :id => pitching_stat
    assert_redirected_to pitching_stats_url
    assert !PitchingStat.exists?(pitching_stat.id)
  end
end
