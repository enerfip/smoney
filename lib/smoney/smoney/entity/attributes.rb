module Smoney
  module Entity
    module Attributes
      extend ActiveSupport::Concern

      def map_attribute(name)
        self.class.attributes[name.to_sym]
      end

      def objects
        self.class.types.select { |_, v| v == "object" }.keys
      end

      def _key
        public_send self.class.instance_variable_get(:@key)
      end

      class_methods do
        def key(name)
          @key = name
        end

        def value(name, map_to: nil, type: "value", options: {})
          map_to ||= name.to_s.camelize
          attributes[name.to_sym] = map_to
          types[name.to_sym] = type

          __send__("define_#{type}_methods", name, map_to, options)
        end

        def datetime(name, map_to: nil)
          value(name, map_to: map_to, type: "datetime")
        end

        def date(name, map_to: nil)
          value(name, map_to: map_to, type: "date")
        end

        def object(name, map_to: nil, class_name: nil)
          value(name, map_to: map_to, type: "object", options: { class_name: class_name })
        end

        def enum(name, map_to: nil, options: nil)
          value(name, map_to: map_to, type: "enum", options: options)
        end

        def list(name, map_to: nil)
          value(name, map_to: map_to, type: "list")
        end

        def resource(name, map_to: nil, class_name: nil)
          value(name, map_to: map_to, type: "resource", options: { class_name: class_name })
        end

        def attributes
          @attributes ||= {}
        end

        def types
          @types ||= {}
        end

        private

        def define_value_methods(name, map_to, _)
          define_method(:"#{name}") do
            @data[map_to.to_s]
          end

          define_method(:"#{name}=") do |value|
            @data[map_to.to_s] = value
          end
        end

        def define_list_methods(name, map_to, _)
          define_method(:"#{name}") do
            @data[map_to.to_s]
          end
        end

        def define_datetime_methods(name, map_to, _)
          define_method(:"#{name}") do
            DateTime.parse @data[map_to.to_s] if @data[map_to.to_s]
          end

          define_method(:"#{name}=") do |value|
            @data[map_to.to_s] = value
          end
        end

        def define_date_methods(name, map_to, _)
          define_method(:"#{name}") do
            DateTime.parse(@data[map_to.to_s]).to_date if @data[map_to.to_s]
          end

          define_method(:"#{name}=") do |value|
            @data[map_to.to_s] = value
          end
        end

        def define_object_methods(name, map_to, class_name: nil)
          class_name = class_name || "Smoney::#{name.to_s.camelize}".constantize
          define_method(:"#{name}") do
            instance_variable_get("@#{name}") || instance_variable_set("@#{name}", class_name.from_data(@data[map_to.to_s]))
          end
          define_method(:"#{name}=") do |value|
            instance_variable_set("@#{name}", value)
          end
        end

        def define_resource_methods(name, _, class_name: nil)
          class_name = class_name || "Smoney::#{name.to_s.singularize.camelize}Collection".constantize
          define_method(:"#{name}") do
            instance_variable_get("@#{name}") || instance_variable_set("@#{name}", class_name.new(_url))
          end
          define_method(:"#{name}=") do |val|
            instance_variable_set("@#{name}", val)
          end
        end

        def define_enum_methods(name, map_to, options = nil)
          define_method(:"#{name}") do
            @data[map_to.to_s]
          end

          define_method(:"#{name}=") do |value|
            raise "Invalid option #{value} was passed to #{name}=. Valid options are: #{options.values.join(", ")}" if value && !options.values.include?(value)
            @data[map_to.to_s] = value
          end
          options.each do |key, _|
            define_method(:"#{key}?") do
              options[@data[map_to.to_s]] == key
            end
          end
        end
      end
    end
  end
end
