class Artisan < ApplicationRecord
  validates :siret, length: { is: 14,
                              message: "Le champs doit comporter 14 chiffres pour un Siret" }
  validate :entreprise_diffusible, if: :check_siret

  def entreprise_diffusible
    artisan = ArtisanContact.get(siret: self.siret)

    error_message = "L’identification de l’établissement immatriculé est valide mais ses données ne peuvent être diffusées publiquement."
    errors.add(:base, error_message) if artisan == "L'entreprise n'est pas diffusable"
  end

  def check_siret
    self.siret.present? && self.siret.length == 14
  end
end
