module Smoney
  class Kyc < Entity::Base
    PATH = "kyc"

    collection do
      def upload(files = [])
        ascii_files = files.map do |file|
          file[:name] = file[:name].force_encoding "ASCII-8BIT"
          file[:filename] = file[:filename].force_encoding "ASCII-8BIT"
          file
        end
        response = client(_url).multipart ascii_files
        if ('400'..'599').include? response.code
          raise Exception.new(response.to_s + response.body)
        else
          entity_class.from_data response.from_json
        end
      end
    end

    key :id

    value    :id
    datetime :created_at, map_to: "RequestDate"
    enum     :status, options: { incomplete: 0, in_progress: 1, rejected: 2, accepted: 3 }
    list     :vouchers, map_to: "VoucherCopies"
  end
end
