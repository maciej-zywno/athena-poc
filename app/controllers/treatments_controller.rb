class PracticesController < ApplicationController
  before_action :authenticate_user!

  def index
    @treatment_collection = current_user.treatments
  end

  def show
    @treatment = Treatment.find(params[:id])
  end

end
