require 'test_helper'

class FieldingPostStatTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FieldingPostStat.new.valid?
  end
end
