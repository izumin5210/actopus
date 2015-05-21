class Api::LecturesController < Api::BaseController
  include Garage::RestfulActions
  include PublicApi

  def require_resources
    @resources = Lecture.includes(
        { klass: [:department, :course] },
        { periods: [:period_time] },
        :lecturers
      ).current_term
  end

  def require_resource
    @resource = Lecture.find(params[:id])
  end
end
