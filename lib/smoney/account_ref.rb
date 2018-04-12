module Smoney
  class AccountRef < Entity::Base
    PATH = ""

    collection

    value :id
    value :application_id, map_to: "AppAccountId"
    value :name,           map_to: "DisplayName"
    value :href
  end
end
