class Api::KlassesController < Api::BaseController
  include Garage::RestfulActions

  def require_resources
    @resources = Klass.all
  end

  def require_resource
    @resource = Klass.find(params[:id])
  end
end
