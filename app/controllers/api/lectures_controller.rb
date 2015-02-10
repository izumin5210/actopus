class Api::LecturesController < Api::BaseController
  include Garage::RestfulActions
  include Garage::NoAuthentication

  def require_resources
    @resources = Lecture.includes(
        { klass: [:department, :course] }, { wday_periods: [:period] },
        :lecturers
      ).current_term
  end

  def require_resource
    @resource = Lecture.find(params[:id])
  end
end
