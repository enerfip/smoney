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
    value :status

    def validated?
      status.to_s == "1"
    end

    def refused?
      status.to_s == "3"
    end

    def waiting_validation?
      status.to_s == "2"
    end

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


