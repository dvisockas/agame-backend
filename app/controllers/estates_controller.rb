class EstatesController < ApplicationController

  def index
    @estates = Estate.all

    render json: @estates
  end

  def create
    @estate = Estate.create estate_params

    render json: @estate
  end

private

  def estate_params
    params.require(:estate).permit! :player_id, :latitude, :longitude
  end

end