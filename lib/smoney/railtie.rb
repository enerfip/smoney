module Smoney
  class Railtie < Rails::Railtie
    config.smoney_client = ActiveSupport::OrderedOptions.new
  end
end
