class MythologiesController < ApplicationController
  def index 
    @mythologies = Mythology.all
  end

end