class Staffs::SessionsController < Staffs::BaseController
  def after_sign_in_path_for(resource)
    staffs_home_path
  end
end
