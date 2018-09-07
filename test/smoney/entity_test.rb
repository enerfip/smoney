require 'test_helper'

class Smoney::EntityTest < Minitest::Test
  def test_to_json_removes_unwanted_fields
    address = Smoney::Address.from_data "unwanted" => "field", "Street" => "21 Jump St", "ZipCode" => "12345", "City" => "NY", "Country" => "US"
    assert_equal(address.to_json, "{\"Street\":\"21 Jump St\",\"ZipCode\":\"12345\",\"City\":\"NY\",\"Country\":\"US\"}")

    bank_account = Smoney::BankAccount.from_data "Demands"=>nil, "Id"=>1142, "DisplayName"=>"Bank Account", "Bic"=>"XXX", "Iban"=>"FR313x", "IsMine"=>true, "Status"=>1, "Holder"=>nil
    assert_equal(bank_account.to_json, "{\"Id\":1142,\"DisplayName\":\"Bank Account\",\"Bic\":\"XXX\",\"Iban\":\"FR313x\",\"IsMine\":true}")
  end
end
