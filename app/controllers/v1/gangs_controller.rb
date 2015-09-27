module V1

  class GangsController < ApplicationController
    def index
      @gangs = Gang.all
      render json: @gangs
    end

    def show
      @gang = Gang.find params[:id]
      render json: @gang
    end

    def create
      @gang = Gang.create gang_params
      render json: @gang
    end

    def update
      @gang = Gang.find params[:id]
      @gang.update gang_params
      render json: @gang
    end

  private

    def gang_params
      params.require(:gang).permit :name
    end
  end

end