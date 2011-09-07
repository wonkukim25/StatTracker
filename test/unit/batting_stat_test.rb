require 'test_helper'

class BattingStatTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert BattingStat.new.valid?
  end
end
