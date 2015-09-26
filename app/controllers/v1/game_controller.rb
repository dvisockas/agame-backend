module V1

  class GameController < ApplicationController
    def index
      @players = Player.near [params[:latitude], params[:longitude]], params[:distance], units: :km
      @estates = Estate.near [params[:latitude], params[:longitude]], params[:distance], units: :km
      @game = { players: @players, estates: @estates }
      render json: @game, serializer: GameSerializer
    end
  end

end