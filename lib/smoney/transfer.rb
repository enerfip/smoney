require_relative "fee"
require_relative "account_ref"
require_relative "bank_account"

module Smoney
  class Transfer < Entity::Base
    PATH = "moneyouts/oneshot"

    collection do
      def get(id = nil)
        url = @url.gsub '/oneshot', "#{ '/' + id.to_s if id }"
        if id
          self.class.entity_class.from_data client(url).get.from_json
        else
          client(url).get.from_json.map { |data| entity_class.from_data(data) }
        end
      end
    end

    key :id

    value    :id
    object   :account_id, class_name: Smoney::AccountRef
    object   :bank_account
    value    :amount
    value    :message
    value    :motif
    object   :fee
    datetime :created_at, map_to: "OperationDate"
  end
end
