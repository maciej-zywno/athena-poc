class PracticesController < ApplicationController
  def index
    @practices = Practice.all(connection: athena_connection)
  end

  def show
    @practice = Practice.find(connection: athena_connection, practiceid: params[:id])
  end
end
