module V1

  class EstateTypesController < ApplicationController
    def index
      @estate_types = EstateType.all
      render json: @estate_types
    end

    def show
      @estate_type = EstateType.find params[:id]
      render json: @estate_type
    end

    def create
      @estate = EstateType.create estate_type_params
      render json: @estate_type
    end

  private

    def estate_params
      params.require(:estate_type).permit :name, :kind
    end
  end

end