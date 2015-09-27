module V1

  class PlayersController < ApplicationController
    def index
      @players = Player.near [params[:latitude], params[:longitude]], params[:distance], units: :km
      render json: @players
    end

    def show
      @player = Player.find params[:id]
      render json: @player, serializer: PlayerShowSerializer
    end

    def create
      @player = Player.find_or_create_by(name: player_params[:name])
      @player.update player_params
      render json: @player
    end

    def update
      @player = Player.find params[:id]
      @player.update player_params
      render json: @player
    end

    def attack!
      @winner = Player.find attack_params[:winner_id]
      @loser = Player.find attack_params[:loser_id]
      @loser.get_rekt_by! @winner
      render json: { winner: @winner, loser: @loser }, each_serializer: PlayerSerializer
    end

    def refuse_challenge
      @player = Player.find params[:id]
      @player.cowardice!
      render json: @player
    end

  private
  
    def attack_params
      params.require(:attack).permit :winner_id, :loser_id
    end

    def player_params
      params.require(:player).permit :name, :latitude, :longitude, :gang_id
    end
  end

end