require 'test_helper'

class FieldingPostStatsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => FieldingPostStat.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    FieldingPostStat.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    FieldingPostStat.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to fielding_post_stat_url(assigns(:fielding_post_stat))
  end

  def test_edit
    get :edit, :id => FieldingPostStat.first
    assert_template 'edit'
  end

  def test_update_invalid
    FieldingPostStat.any_instance.stubs(:valid?).returns(false)
    put :update, :id => FieldingPostStat.first
    assert_template 'edit'
  end

  def test_update_valid
    FieldingPostStat.any_instance.stubs(:valid?).returns(true)
    put :update, :id => FieldingPostStat.first
    assert_redirected_to fielding_post_stat_url(assigns(:fielding_post_stat))
  end

  def test_destroy
    fielding_post_stat = FieldingPostStat.first
    delete :destroy, :id => fielding_post_stat
    assert_redirected_to fielding_post_stats_url
    assert !FieldingPostStat.exists?(fielding_post_stat.id)
  end
end
