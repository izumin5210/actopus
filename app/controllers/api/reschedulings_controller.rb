class Api::ReschedulingsController < Api::BaseController
  include Garage::RestfulActions

  def require_resources
    @resources = Rescheduling.all
  end
end
