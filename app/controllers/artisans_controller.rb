class ArtisansController < ApplicationController
  def create
    # @artisan = Artisan.new(artisan_params)
    # new_artisan = Artisan.new(artisan_params)
    artisan_to_check = Artisan.new(artisan_params)

    if artisan_to_check.valid?
      artisan_to_display = create_artisan_with_sirene_api(siret: artisan_params[:siret])
   
      render turbo_stream: [
        turbo_stream.replace("display_artisan", partial: "artisan", locals: { artisan: artisan_to_display }),
        turbo_stream.replace("new_artisan", partial: "artisan_form", locals: { artisan: Artisan.new })
      ]
    else
      render turbo_stream: [
        turbo_stream.remove("display_artisan", partial: "artisan", locals: { artisan: nil }),
        turbo_stream.replace("new_artisan", partial: "artisan_form", locals: { artisan: artisan_to_display }),
      ]
    end
  end

  def show
    @new_artisan = Artisan.new
  end

  private

  def create_artisan_with_sirene_api(siret:)
    find_artisan = ArtisanContact.get(siret: siret)

    Artisan.create(
      name: find_artisan.name,
      activite: find_artisan.activite,
      adresse: find_artisan.adresse,
      etat: find_artisan.etat,
      categorie: find_artisan.categorie,
      date_creation: find_artisan.date_creation,
      date_verification: find_artisan.date_verification
    )
  end

  def artisan_params
    params.require(:artisan).permit(:id, :siret, :name, :activite, :adresse, :etat, :categorie, :date_creation, :date_verification)
  end
end
