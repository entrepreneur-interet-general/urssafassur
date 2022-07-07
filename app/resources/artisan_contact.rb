require 'csv'

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

    # Gestion du nom de l'entreprise
    entrepreneur_individuel = company["etablissement"]["uniteLegale"]["categorieJuridiqueUniteLegale"] == "1000"

    name = if entrepreneur_individuel
      company["etablissement"]["uniteLegale"]["sexeUniteLegale"] + ". " +
      company["etablissement"]["uniteLegale"]["prenom1UniteLegale"] + " " +
      company["etablissement"]["uniteLegale"]["nomUniteLegale"]
    else
      company["etablissement"]["uniteLegale"]["denominationUniteLegale"]
    end

    adresse = company["etablissement"]["adresseEtablissement"]["numeroVoieEtablissement"] + " " +
              company["etablissement"]["adresseEtablissement"]["typeVoieEtablissement"] + " " +
              company["etablissement"]["adresseEtablissement"]["libelleVoieEtablissement"] + ", " +
              company["etablissement"]["adresseEtablissement"]["codePostalEtablissement"] + " " +
              company["etablissement"]["adresseEtablissement"]["libelleCommuneEtablissement"]

    etat = company["etablissement"]["uniteLegale"]["etatAdministratifUniteLegale"] == "A" ? "Actif" : "Cessée"

    ArtisanContact.new(
      name: name,
      activite: humanize_activity(company["etablissement"]["uniteLegale"]["activitePrincipaleUniteLegale"]),
      adresse: adresse.titleize,
      etat: etat,
      categorie: company["etablissement"]["uniteLegale"]["categorieEntreprise"],
      date_creation: to_date(company["etablissement"]["dateCreationEtablissement"]),
      date_verification: to_date(company["etablissement"]["dateDernierTraitementEtablissement"])
    )
  end

  def self.to_date(date)
    Date.parse(date).strftime("%d/%m/%Y")
  end

  def self.humanize_activity(activite)
    file = File.join(File.dirname(__FILE__), "naf2008-liste-n4-classes.csv")
    hash = CSV.read(file).to_h

    libelle = hash[activite.gsub(/[A-Z]/, '')]

    activite + " " + libelle
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
