class GodsController < ApplicationController
  before_action :set_mythology, only: [:index]

  def index
    if params[:mythology_id]
      @gods = God.where(mythology_id: params[:mythology_id])
    else
      @gods = God.all
    end
  end

  private

  def set_mythology
    @mythology = Mythology.find(params[:mythology_id]) if params[:mythology_id]
  end
end
