class CavesController < ApplicationController
require 'open-uri'

  def index
    @caves = Cafe.all
    @top = Cafe.order('score DESC').paginate(:page => params[:page], :per_page => 30)
  end

end
