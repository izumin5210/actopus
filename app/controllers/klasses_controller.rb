class KlassesController < ApplicationController
  def index
    @klasses = Klass.includes(:department).all
  end
end
