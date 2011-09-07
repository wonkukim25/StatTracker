require 'test_helper'

class BattingPostStatTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert BattingPostStat.new.valid?
  end
end
