class ArtisansController < ApplicationController
  def create
    @artisan = Artisan.create(artisan_params)

    @artisan.save

    render turbo_stream: [
      turbo_stream.replace("artisan", partial: "artisan", locals: { artisan: @artisan })
    ]
  end

  def show
    @new_artisan = Artisan.new
  end

  private

  def artisan_params
    params.require(:artisan).permit(:siret)
  end
end
