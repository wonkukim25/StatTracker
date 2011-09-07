require 'test_helper'

class PitchingStatTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PitchingStat.new.valid?
  end
end
