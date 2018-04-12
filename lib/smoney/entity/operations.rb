module Smoney
  module Entity
    module Operations
      extend ActiveSupport::Concern

      def post
        self.class.from_data((client(_url).post to_json).from_json)
      end

      def put
        self.class.from_data((client(_url).put to_json).from_json)
      end

      def delete
        client(_url).delete
        self
      end

      class_methods do
        def get(id = nil)
          if id
            from_data client(_url(id)).get.from_json
          else
            client(_url).get.from_json.map { |data| from_data(data) }
          end
        end

        def query(parameters = {})
          query_url = _url + "?" +  URI.encode_www_form(parameters)
          client(query_url).query.from_json.map { |data| from_data(data) }
        end
      end
    end
  end
end
