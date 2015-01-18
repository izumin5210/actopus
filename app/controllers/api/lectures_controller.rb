class Api::LecturesController < Api::BaseController
  include Garage::RestfulActions

  def require_resources
    @resources = Lecture.all
  end

  def require_resource
    @resource = Lecture.find(params[:id])
  end
end
