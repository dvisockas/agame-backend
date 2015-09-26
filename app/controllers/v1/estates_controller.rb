module V1

  class EstatesController < ApplicationController
    def index
      @estates = Estate.all
      render json: @estates
    end

    def show
      @estate = Estate.find params[:id]
      render json: @estate
    end

    def update
      @estate = Estate.find params[:id]
      @estate.update estate_params
      render json: @estate
    end

  private

    def estate_params
      params.require(:estate).permit :player_id, :latitude, :longitude, :estate_type_id
    end
  end

end