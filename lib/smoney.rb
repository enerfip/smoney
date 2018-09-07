require 'railtie' if defined?(Rails)
require 'cgi'

module Smoney
  URL = "https://rest-pp.s-money.fr/api/sandbox"
  HEADERS = { "Accept" => "application/vnd.s-money.v1+json", "Content-Type" => "application/vnd.s-money.v1+json", "Authorization" => "Bearer NTs1NTswTC5kYVhGZE8u" }

  def self.configuration?
    Rails.application.config.respond_to? :smoney
  end

  def self.override_url
    Rails.application.config.smoney.url if configuration? and Rails.application.config.smoney.respond_to? :url
  end

  def self.override_headers
    Rails.application.config.smoney.headers if configuration? and Rails.application.config.smoney.respond_to? :headers
  end

  def self.url
    override_url || URL
  end

  def self.headers
    HEADERS.merge (override_headers || {})
  end
end

require "active_support"
require "active_support/core_ext/string"
Dir.glob(__dir__ + "/smoney/entity/**/*.rb").each {|file| require file }
Dir.glob(__dir__ + "/smoney/ext/**/*.rb").each {|file| require file }
Dir.glob(__dir__ + "/smoney/http/**/*.rb").each {|file| require file }
Dir.glob(__dir__ + "/smoney/*.rb").each {|file| require file }
