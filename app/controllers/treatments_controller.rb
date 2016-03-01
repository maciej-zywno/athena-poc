class TreatmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @treatments = current_user.treatments
  end

  def show
    @treatment = Treatment.find(params[:id])
  end
end
