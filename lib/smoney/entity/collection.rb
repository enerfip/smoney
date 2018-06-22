require "uri"
require_relative "client"
require_relative "post_error"

module Smoney
  module Entity
    class Collection
      include Entity::Client
      delegate :client, :entity_class, to: :class
      def self.entity_class
        self.name.sub("Collection", "").constantize
      end

      def initialize(url)
        @base_url = url
        @url = url + "/" + entity_class::PATH
      end

      def self._headers
        Smoney::headers.merge entity_class._headers
      end

      def _url(id = nil)
        if !id.blank?
          @url + "/" + id.to_s
        else
          @url
        end
      end

      def get(id = nil)
        if id
          entity_class.from_data(client(_url(id)).get.from_json).tap do |entity|
            entity.base_url = @base_url
          end
        else
          client(_url).get.from_json.map { |data|
            entity_class.from_data(data).tap do |ba|
              ba.base_url = @base_url
            end
          }
        end
      end

      def put(object)
        entity_class.from_data client(_url(object._key)).put(object.to_json).from_json
      end

      def post(object)
        entity_class.from_data client(_url).post(object.to_json).from_json
      end

      def post!(object)
        post(object).tap do |response_object|
          raise Smoney::Entity::PostError.new(response_object) if response_object.error?
        end
      end

      def delete(object)
        client(_url(object._key)).delete
      end

      def self.query(parameters = {})
        query_url = _url + "?" +  URI.encode_www_form(parameters)
        client(query_url).query.from_json.map { |data| entity_class.from_data(data) }
      end
    end
  end
end
