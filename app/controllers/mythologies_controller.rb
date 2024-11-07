class MythologiesController < ApplicationController
  def index
    @mythologies = Mythology.all
  end

  def new
    @mythology = Mythology.new
  end

  def create
    @mythology = Mythology.new(mythology_params)
    if @mythology.save
      flash[:notice] = "Mythology was successfully created."
      redirect_to mythologies_path
    else
      render :new
    end
  end

  private

  def mythology_params
    params.require(:mythology).permit(:name, :description)
  end
end
