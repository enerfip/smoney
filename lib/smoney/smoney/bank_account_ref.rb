module Smoney
  class BankAccountRef < Entity::Base
    PATH = ""

    collection

    value :id
    value :href
  end
end
