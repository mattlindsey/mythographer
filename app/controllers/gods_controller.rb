class GodsController < ApplicationController
  def index
    @gods = God.all
  end
end
