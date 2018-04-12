require_relative "account_ref"
require_relative "bank_account"
module Smoney
  class ChequeReference < Entity::Base
    PATH = "payins/cheques/references"

    collection

    key :id

    value  :id
    object :beneficiary, class_name: Smoney::AccountRef
    value  :is_mine
    value  :reference
    object :bank_account
  end
end
