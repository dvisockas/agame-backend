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
      @player = Player.find attack_params[:player_id]
      @victim = Player.find attack_params[:victim_id]
      @player.attack! @victim
      render json: @player
    end

    def join_gang
      @player = Player.find params[:id]
      @gang = Gang.find gang_params[:id]
      @player.join_gang! @gang
      render json: @player
    end

  private
  
    def gang_params
      params.require(:gang).permit :id
    end

    def attack_params
      params.require(:attack).permit :victim_id
    end

    def player_params
      params.require(:player).permit :name, :latitude, :longitude
    end
  end

end