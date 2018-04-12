require 'test_helper'

class SmoneyTest < Minitest::Test
  def test_module_exists
    assert_kind_of Module, Smoney
  end
end
