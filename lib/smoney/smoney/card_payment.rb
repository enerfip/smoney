require_relative "account_ref"

module Smoney
  class CardPayment < Entity::Base
    PATH = "payins/cardpayments"

    collection

    @headers = { "Accept" => "application/vnd.s-money.v2+json", "Content-Type" => "application/vnd.s-money.v2+json" }

    key :order_id

    value    :id
    value    :order_id
    datetime :created_at, map_to: "PaymentDate"
    value    :amount
    value    :fee
    enum     :status, options: { waiting: 0, complete: 1, refunded: 2, failed: 3, waiting_for_kyc: 4 }
    object   :beneficiary, class_name: Smoney::AccountRef
    value    :error_code
    value    :return_url, map_to: "UrlReturn"
    value    :cards
    enum     :type, options: { payment: 0, refund: 1 }
    value    :href
    value    :is_mine
  end
end
