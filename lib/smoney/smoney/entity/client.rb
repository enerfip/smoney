module Smoney
  module Entity
    module Client
      extend ActiveSupport::Concern
      included do
        delegate :client, to: :class
      end
      class_methods do
        def client(url)
          Smoney::Http::Client.new(url, _headers)
        end
      end
    end
  end
end
