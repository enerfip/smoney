require_relative "attachment"
require_relative "fee"

module Smoney
  class History < Entity::Base
    PATH = "historyitems"

    collection do
      def _url(id = nil, sub_account = nil, params = {})
        sub_append = sub_account.present? ? "/subaccounts/#{sub_account}" : ""
        [if id
          @base_url + sub_append + "/" + entity_class::PATH + "/" + id.to_s
        else
          @base_url + sub_append + "/" + entity_class::PATH
        end,
        params.empty? ? nil : params.to_query
        ].compact.join("?")
      end

      def get(id = nil, sub_account: nil, params: {})
        if id
          entity_class.from_data client(_url(id, sub_account, params)).get.from_json
        else
          client(_url(nil, sub_account, params)).get.from_json.compact.map { |data| entity_class.from_data(data) }
        end
      end
    end

    key :id

    value    :id
    value    :account
    datetime :created_at, map_to: "OperationDate"
    value    :amount
    value    :label
    object   :attachment
    value    :is_new
    enum     :type, options: { payment: 0, money_in: 1, money_out: 2, e_commerce_payment: 3, e_commerce_card_payment: 4, distributor_payment: 5, refund: 6, regulation: 7 }
    enum     :direction, options: { none: 0, in: 1, out: 2 }
    enum     :status, options: { pending: 0, succeeded: 1, cancelled: 2, failed: 3, expired: 4, refunded: 5 }
    object   :fee
  end
end
