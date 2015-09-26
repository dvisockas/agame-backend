module V1

  class PlayersController < ApplicationController
    def index
      @players = Player.near [params[:latitude], params[:longitude]], params[:distance], units: :km
      render json: @players
    end

    def show
      @player = Player.find params[:id]
      render json: @player
    end

    def create
      @player = Player.find_or_create_by(name: player_params[:name]).update player_params
      render json: @player
    end

    def update
      @player = Player.find params[:id]
      @player.update player_params
      render json: @player
    end

  private

    def player_params
      params.require(:player).permit :name, :latitude, :longitude
    end
  end

end