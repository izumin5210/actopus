class Staffs::HomeController < Staffs::BaseController
  def home
    @reschedulings = Rescheduling.all
  end
end
