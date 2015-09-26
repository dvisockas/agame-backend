class EstatesController < ApplicationController

  def index
    estates = Estate.all
  end

end