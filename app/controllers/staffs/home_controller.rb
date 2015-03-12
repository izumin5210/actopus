class Staffs::HomeController < Staffs::BaseController
  def home
    @reschedulings = Rescheduling.available.includes(
        { lecture: [:lecturers, :klass] }, :period
      )
  end
end
