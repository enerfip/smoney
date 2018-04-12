module Smoney
  class BankAccount < Entity::Base
    PATH = "bankaccounts"

    collection

    key   :id

    value :id
    value :name, map_to: "DisplayName"
    value :bic
    value :iban
    value :mine, map_to: "IsMine"

    def path
      base_url || "#{Smoney.url}"
    end

    def _url(_id = _key)
      "#{ path }/#{PATH}#{ '/' + _id.to_s if _id }"
    end
  end
end


