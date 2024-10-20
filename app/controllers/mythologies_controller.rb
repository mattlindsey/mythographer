class MythologiesController < ApplicationController
  before_action :set_mythology, only: [:edit, :update]

  def index
    @mythologies = Mythology.all
  end

  def new
    @mythology = Mythology.new
  end

  def create
    @mythology = Mythology.new(mythology_params)
    if @mythology.save
      redirect_to mythologies_path, notice: 'Mythology was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @mythology.update(mythology_params)
      redirect_to mythologies_path, notice: 'Mythology was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_mythology
    @mythology = Mythology.find(params[:id])
  end

  def mythology_params
    params.require(:mythology).permit(:name, :description)
  end
end
