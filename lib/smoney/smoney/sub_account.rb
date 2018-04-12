module Smoney
  class SubAccount < Entity::Base
    PATH = "subaccounts"

    collection

    value :id
    value :application_id, map_to: "AppAccountId"
    value :name, map_to: "DisplayName"
    value :amount
    value :default, map_to: "IsDefault"
    datetime :created_at, map_to: "CreationDate"
  end
end
