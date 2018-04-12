require "uri"
require_relative "client"
require_relative "operations"
require_relative "attributes"

module Smoney
  module Entity
    class Base
      include Entity::Client
      include Entity::Operations
      include Entity::Attributes
      attr_accessor :base_url

      def self.collection has_collection = true, &block
        return unless has_collection
        collection = Class.new(Collection, &block)
        Smoney.const_set("#{name.split("::").last}Collection", collection)
      end

      def self._headers
        Smoney.headers.merge(@headers || {})
      end

      def self._url(id = nil)
        "#{ Smoney.url}/#{ name.constantize::PATH }#{ '/' + id.to_s if id }"
      end

      def initialize(attributes = {})
        @data = {}
        self.base_url = nil
        attributes.each do |name, value|
          send "#{ name }=".to_sym, value
        end
      end

      def _headers
        Smoney.headers.merge(@headers || {})
      end

      def _url
        "#{ Smoney::url }/#{ self.class::PATH }#{ '/' + _key.to_s if _key }"
      end

      def self.from_data(hash = {})
        new.tap do |obj|
          obj.data = hash
        end
      end

      def to_json
        hash = @data
        objects.map do |variable|
          object = instance_variable_get("@" + variable.to_s)
          hash[map_attribute variable.to_sym] = JSON.parse object.to_json if object
        end
        hash.to_json
      end

      def data
        @data || {}
      end

      def data=(hash = {})
        @data = hash
      end
    end
  end
end
