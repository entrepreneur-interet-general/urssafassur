class ArtisansController < ApplicationController
  def create
    @artisan = Artisan.create(artisan_params)

    if @artisan.save
      update_artisan_with_sirene_api(siret: artisan_params[:siret])

      render turbo_stream: [
        turbo_stream.replace("artisan", partial: "artisan", locals: { artisan: @artisan }),
        turbo_stream.replace("new_artisan", partial: "form", locals: { artisan: @artisan })
      ]
    else
      render turbo_stream: [
        turbo_stream.replace("artisan", partial: "artisan", locals: { artisan: nil }),
        turbo_stream.replace("new_artisan", partial: "form", locals: { artisan: @artisan }),
      ]
    end
  end

  def show
    @new_artisan = Artisan.new
  end

  private

  def update_artisan_with_sirene_api(siret:)
    find_artisan = ArtisanContact.get(siret: siret)

    @artisan.update(
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
