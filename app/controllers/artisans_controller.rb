class ArtisansController < ApplicationController
  def create
    @artisan = Artisan.create(artisan_params)

    if @artisan.save
      render turbo_stream: [
        turbo_stream.replace("artisan", partial: "artisan", locals: { artisan: @artisan }),
        turbo_stream.replace("new_artisan", partial: "form", locals: { artisan: @artisan })
      ]
    else
      render turbo_stream: [
        turbo_stream.replace("new_artisan", partial: "form", locals: { artisan: @artisan }),
        turbo_stream.replace("artisan", partial: "artisan", locals: { artisan: nil }),
      ]
    end
  end

  def show
    @new_artisan = Artisan.new
  end

  private

  def artisan_params
    params.require(:artisan).permit(:siret)
  end
end
