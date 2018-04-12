module Smoney
  class Fee < Entity::Base
    PATH = ""

    collection

    value :amount
    value :vat
    value :amount_with_vat
    enum  :status, options: { pending: 0, succeeded: 1, cancelled: 2, failed: 3, expired: 4, returned: 5 }
  end
end
