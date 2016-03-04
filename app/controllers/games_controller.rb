class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = policy_scope(Game).page(params[:page])
  end

  def show
    @game = Game.find(params[:id])
    authorize @game, :show?
  end
end
