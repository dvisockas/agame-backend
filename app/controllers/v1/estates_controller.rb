module V1

  class EstatesController < ApplicationController
    def index
      @estates = Estate.near [params[:latitude], params[:longitude]], 10, units: :km
      
      if stale?(@estates)
        render json: @estates
      end
    end

    def show
      @estate = Estate.find params[:id]
      render json: @estate
    end

    def update
      @estate = Estate.find params[:id]
      @estate.process estate_params
      render json: @estate
    end

    def estate_types
      @estate = Estate.find params[:id]
      render json: @estate.available_estates, each_serializer: EstateTypeSerializer, estate: @estate
    end

  private

    def estate_params
      params.require(:estate).permit :player_id, :estate_type_id
    end
  end

end