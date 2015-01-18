class Api::LecturesController < Api::BaseController
  include Garage::RestfulActions

  def require_resources
    @resources = Lecture.includes(
        { klass: [:department, :course] }, { wday_periods: [:period] },
        :lecturers
      ).all
  end

  def require_resource
    @resource = Lecture.find(params[:id])
  end
end
