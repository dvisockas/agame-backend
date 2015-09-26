module V1

  class GameController < ApplicationController
    def index
      @players = Player.near [params[:latitude], params[:longitude]], 1, units: :km
      @estates = Estate.near [params[:latitude], params[:longitude]], 1, units: :km
      @game = { players: @players, estates: @estates }
      render json: @game
    end
  end

end