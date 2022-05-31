class ArtisansController < ApplicationController
  def show
    @artisan = Artisan.find(params[:siret]) if params[:siret]
  end
end
