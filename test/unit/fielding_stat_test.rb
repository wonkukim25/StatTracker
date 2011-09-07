require 'test_helper'

class FieldingStatTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FieldingStat.new.valid?
  end
end
