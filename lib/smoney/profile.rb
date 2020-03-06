require_relative "address"

module Smoney
  class Profile < Entity::Base
    PATH = ""
    CSP_CODES = {
      agriculteur_petite_exploitation: 11,
      agriculteur_moyenne_exploitation: 12,
      agriculteur_grande_exploitation: 13,
      artisan: 21,
      commercant: 22,
      chef_pme: 23,
      profession_liberale: 31,
      cadre_fonction_publique: 33,
      professeur: 34,
      information_arts_et_spectacles: 35,
      cadre_entreprise: 37,
      ingenieur: 38,
      instituteur: 42,
      sante_social: 43,
      religieux: 44,
      intermediaire_fonction_publique: 45,
      intermediaire_entreprise: 46,
      technicien: 47,
      contremaitre: 48,
      employe_fonction_publique: 52,
      policier_militaire: 53,
      employe_administratif_entreprise: 54,
      employe_commerce: 55,
      service_direct_particulier: 56,
      ouvrier_qualifie_industriel: 62,
      ouvrier_qualifie_artisanal: 63,
      chauffeur: 64,
      manutention_transport: 65,
      ouvrier_non_qualifie_industriel: 67,
      ouvrier_non_qualifie_artisanal: 68,
      ouvrier_agricole: 69,
      ancien_agriculteur_exploitant: 71,
      ancien_artisan_commercant_chef_entreprise: 72,
      ancien_cadre: 74,
      ancien_profession_intermediaire: 75,
      ancien_employe: 77,
      ancien_ouvrier: 78,
      chomeur_nayant_pas_travaille: 81,
      militaire_contingent: 83,
      eleve_etudiant: 84,
      sans_activite_moins_de_60: 85,
      sans_activite_plus_de_60: 86
    }

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
    enum      :csp_code, map_to: "CSPCode", options: CSP_CODES
    object    :address
  end
end
