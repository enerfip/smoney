require_relative "address"

module Smoney
  class Profile < Entity::Base
    PATH = ""

    collection

    enum      :civility, options: { male: 0, female: 1 }
    value     :first_name
    value     :last_name
    date      :birthdate
    value     :birthcity, map_to: "Birthcity"
    value     :birthcountry, map_to: "BirthCountry"
    value     :phone, map_to: "PhoneNumber"
    value     :email
    value     :nickname, map_to: "Alias"
    object    :address
  end
end
