require 'test_helper'

class Smoney::EntityTest < Minitest::Test
  def test_to_json_removes_unwanted_fields
    address = Smoney::Address.from_data "unwanted" => "field", "street" => "21 Jump St", "zip_code" => "12345", "city" => "NY", "country" => "US"
    assert_equal(address.to_json, "{\"street\":\"21 Jump St\",\"zip_code\":\"12345\",\"city\":\"NY\",\"country\":\"US\"}")
  end
end
