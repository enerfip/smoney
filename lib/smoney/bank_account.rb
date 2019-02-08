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

    def upload(rib)
      response = client("#{_url}/rib/attachments").multipart [rib]
      if ('400'..'599').include? response.code
        raise Exception.new(response.to_s + response.body)
      end
    end
  end
end


