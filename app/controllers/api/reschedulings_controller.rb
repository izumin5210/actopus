class Api::ReschedulingsController < Api::BaseController
  include Garage::RestfulActions
  include PublicApi

  def require_resources
    @resources = Rescheduling.available.includes(
      lecture: [
        { klass: [:department, :course] },
        { periods: [:period_time] },
        :lecturers
      ],
      before_date_period: [:period_time],
      after_date_period: [:period_time]
    )
  end
end
