module Smoney
  class Address < Entity::Base
    PATH = ""

    collection

    value :street
    value :zip_code
    value :city
    value :country
  end
end
