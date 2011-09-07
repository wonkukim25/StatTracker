require 'test_helper'

class FranchiseTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Franchise.new.valid?
  end
end
