class Staffs::StaffsController < Staffs::BaseController
  def index
    @staffs = Staff.all
    @staff = Staff.new
  end

  def create
    # TODO: 仮登録の機能を実装
  end

  private
  
    def staff_params
      params.require(:staff).permit(:email)
    end
end
