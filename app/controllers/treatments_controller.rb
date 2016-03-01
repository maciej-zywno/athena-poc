class TreatmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @treatments = policy_scope(Treatment)
  end

  def show
    @treatment = Treatment.find(params[:id])
  end
end
