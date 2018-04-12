require_relative "account_ref"
require_relative "fee"

module Smoney
  class Payment < Entity::Base
    PATH = "payments"

    collection

    key :id

    value    :id
    datetime :created_at, map_to: "PaymentDate"
    value    :amount
    value    :message
    object   :fee
    object   :beneficiary, class_name: Smoney::AccountRef
    object   :sender, class_name: Smoney::AccountRef
  end
end
