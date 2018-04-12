require_relative "account_ref"
require_relative "bank_account"

module Smoney
  class BankTransferReference < Entity::Base
    PATH = "payins/banktransfers/references"

    collection

    key :id

    value  :id
    object :beneficiary, class_name: Smoney::AccountRef
    value  :is_mine
    value  :reference
    object :bank_account
  end
end
