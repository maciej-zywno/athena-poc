class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = policy_scope(Game).page(params[:page])
  end

  def show
    @game = Game.find(params[:id])
    authorize @game, :show?
  end

  def new
    @game = current_user.games.build
    authorize @game
  end

  def create
    @game = Game.new(game_params.merge(doctor_id: current_user.id))
    authorize @game

    if @game.save
      redirect_to games_path(@game), success: 'Game was created successfully'
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit!
  end

end
