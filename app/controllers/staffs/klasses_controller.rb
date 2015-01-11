class Staffs::KlassesController < Staffs::BaseController
  def index
    @klasses = Klass.includes(:department).all
  end
end
