require_relative "account_ref"
require_relative "sub_account"
require_relative "company"
require_relative "profile"
require_relative "bank_account"
require_relative "card_payment"
require_relative "history"
require_relative "kyc"
require_relative "payment"
require_relative "quote"
require_relative "transfer"
require_relative "bank_transfer"
require_relative "bank_transfer_reference"
require_relative "cheque"
require_relative "cheque_reference"
require_relative "limits"

module Smoney
  class InvalidUser < StandardError ; end
  class User < Entity::Base
    PATH = "users"

    collection

    def self._url(params = nil)
      if params.kind_of? Hash || params.nil?
        "#{Smoney.url}/#{PATH}?#{URI.encode_www_form params}"
      else
        "#{Smoney.url}/#{PATH}/#{params}"
      end
    end

    key :application_id

    value    :id
    value    :type
    value    :application_id, map_to: "AppUserId"
    enum     :role, options: { client: 0, known_client: 1, extended_client: 2 }
    object   :profile
    object   :company
    value    :amount
    list     :sub_accounts
    list     :bank_accounts
    list     :cards, map_to: "CBCards"
    enum     :status, options: { unconfirmed: 0, ok: 1, frozen: 2, on_the_fly: 3, closing: 4, closed: 5 }
    resource :bank_account
    resource :sub_account, class_name: SubAccountCollection
    resource :card_payments
    resource :history
    resource :kyc
    resource :payments
    resource :quotes
    resource :transfers
    resource :bank_transfer_references
    resource :bank_transfers
    resource :cheque_references
    resource :cheques

    def limits
      @limits ||= Limits.new(_url).get
    end
  end
end


