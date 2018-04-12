require_relative "account_ref"
require_relative "bank_account"

module Smoney
  class Cheque < Entity::Base
    PATH = "/payins/cheques"

    collection

    key :id

    value    :id
    datetime :payment_date
    value    :amount
    enum     :status, options: { pending: 0, succeeded: 1, cancelled: 2, failed: 3, expired: 4, refunded: 5, received: 6 }
    object   :beneficiary, class_name: Smoney::AccountRef
    value    :is_mine
    value    :reference
    object   :bank_account
  end
end
