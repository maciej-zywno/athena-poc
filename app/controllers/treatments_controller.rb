class TreatmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @treatments = policy_scope(Treatment).page(params[:page])
  end

  def show
    @treatment = Treatment.find(params[:id])
  end
end
