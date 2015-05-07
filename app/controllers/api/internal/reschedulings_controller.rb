class Api::Internal::ReschedulingsController < Api::BaseController
  include Garage::RestfulActions

  def require_resources
    @resources = Rescheduling.all
  end

  def create_resource
    @resources.create(rescheduling_params)
  end

  private

  def rescheduling_params
    params.permit(:lecture_id, :period_time_id, :category, :scheduled_on)
  end
end
