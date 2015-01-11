class Staffs::StaffsController < Staffs::BaseController
  def index
    @staffs = Staff.all
  end
end
