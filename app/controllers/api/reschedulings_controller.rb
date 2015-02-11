class Api::ReschedulingsController < Api::BaseController
  include Garage::RestfulActions
  include Garage::NoAuthentication

  def require_resources
    @resources = Rescheduling.available.includes(
        lecture: [
          { klass: [:department, :course] },
          { wday_periods: [:period] },
          :lecturers
        ],
        before_date_period: [:period],
        after_date_period: [:period]
      )
  end
end
