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

    ArtisanContact.new(
      name: company["etablissement"]["uniteLegale"]["denominationUniteLegale"],
      ape: company["etablissement"]["uniteLegale"]["activitePrincipaleUniteLegale"]
    )
  end

  def initialize(name:, ape:)
    @name = name
    @ape = ape
  end

  attr_accessor :name,
                :ape
end
