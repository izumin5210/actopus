class Api::KlassesController < Api::BaseController
  include Garage::RestfulActions
  include PublicApi

  def require_resources
    @resources = Klass.includes(:department, :course).all
  end

  def require_resource
    @resource = Klass.friendly.find(params[:id])
  end

  def timetable
    require_resource
    @resources = Timetable.create_from_klass(@resource)
    respond_with @resources
  end
end
