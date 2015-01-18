class Api::ReschedulingsController < Api::BaseController
  include Garage::RestfulActions

  def require_resources
    @resources = Rescheduling.includes(
        lecture: [
          { klass: [:department, :course] }, { wday_periods: [:period] },
          :lecturers
        ],
        before_date_period: [:period], after_date_period: [:period]
      ).all
  end
end
