class Staffs::HomeController < Staffs::BaseController
  def home
    @reschedulings = Rescheduling.available.includes(
        lecture: [:lecturers, :klass],
        before_date_period: [:period],
        after_date_period: [:period]
      )
  end
end
