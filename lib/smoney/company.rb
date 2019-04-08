module Smoney
  class Company < Entity::Base
    PATH = ""

    collection false

    value :name
    value :siret
    value :naf
  end
end
