require_relative "address"

module Smoney
  class Profile < Entity::Base
    PATH = ""

    collection

    enum      :gender, options: { male: 0, female: 1 }
    value     :first_name
    value     :last_name
    date      :birthdate
    value     :phone, map_to: "PhoneNumber"
    value     :email
    value     :nickname, map_to: "Alias"
    object    :address

    def civility
      male? ? "Monsieur" : "Madame"
    end
  end
end
