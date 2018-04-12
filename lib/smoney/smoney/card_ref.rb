module Smoney
  class CardRef < Entity::Base
    PATH = ""

    collection

    value :id
    value :href
  end
end
