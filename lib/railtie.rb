if defined? Rails
module Smoney
  class Railtie < Rails::Railtie
    config.smoney = ActiveSupport::OrderedOptions.new
  end
end
