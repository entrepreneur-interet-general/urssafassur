class Artisan < ApplicationRecord
  validates :siret, length: { is: 14,
                              message: "Le champs doit comporter 14 chiffres pour un Siret" }
  validate :entreprise_diffusible

  def entreprise_diffusible
    artisan = ArtisanContact.get(siret: self.siret)

    errors.add(:base, "L'entreprise n'est pas diffusable") if artisan == "L'entreprise n'est pas diffusable"
  end
end
