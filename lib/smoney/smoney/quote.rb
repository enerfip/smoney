require_relative "fee"
require_relative "account_ref"
require_relative "bank_account"

module Smoney
  class Quote < Entity::Base
    PATH = "moneyouts/oneshot/quotes"

    collection

    key :id

    value    :id
    object   :account_id, class_name: Smoney::AccountRef
    object   :bank_account
    value    :amount
    object   :fee
    datetime :created_at, map_to: "OperationDate"
  end
end
