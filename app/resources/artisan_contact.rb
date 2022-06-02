class ArtisanContact
  def self.get(siret:)
    response = ApiSirene.get(
      url: "https://api.insee.fr/entreprises/sirene/V3/siret/#{siret}", 
      access_token: ApiSirene.generate_token(Rails.application.credentials.insee_sirene_v3[:consumer_key],
                                            Rails.application.credentials.insee_sirene_v3[:consumer_secret])
    )

    # Gestion des entreprises non diffusibles
    return "L'entreprise n'est pas diffusable" if response.body.include? "non diffusable"

    company = JSON.parse response.body

    adresse = company["etablissement"]["adresseEtablissement"]["numeroVoieEtablissement"] + " " +
              company["etablissement"]["adresseEtablissement"]["typeVoieEtablissement"] + " " +
              company["etablissement"]["adresseEtablissement"]["libelleVoieEtablissement"] + ", " +
              company["etablissement"]["adresseEtablissement"]["codePostalEtablissement"] + " " +
              company["etablissement"]["adresseEtablissement"]["libelleCommuneEtablissement"]

    etat = company["etablissement"]["uniteLegale"]["etatAdministratifUniteLegale"] == "A" ? "Actif" : "Cessée"

    ArtisanContact.new(
      name: company["etablissement"]["uniteLegale"]["denominationUniteLegale"],
      activite: company["etablissement"]["uniteLegale"]["activitePrincipaleUniteLegale"],
      adresse: adresse,
      etat: etat,
      categorie: company["etablissement"]["uniteLegale"]["categorieEntreprise"],
      date_creation: company["etablissement"]["dateCreationEtablissement"],
      date_verification: company["etablissement"]["dateDernierTraitementEtablissement"]
    )
  end

  def initialize(name:, activite:, adresse:, etat:, categorie:, date_creation:, date_verification:)
    @name = name
    @activite = activite
    @adresse = adresse
    @etat = etat
    @categorie = categorie
    @date_creation = date_creation
    @date_verification = date_verification
  end

  attr_accessor :name,
                :activite,
                :adresse,
                :etat,
                :categorie,
                :date_creation,
                :date_verification
end
