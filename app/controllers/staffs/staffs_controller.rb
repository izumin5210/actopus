class Staffs::StaffsController < Staffs::BaseController
  def index
    @staffs = Staff.all
    @staff = Staff.new
  end

  def invite
    @staff = Staff.invite!(staff_params)
    if @staff.errors.empty?
      redirect_to staffs_staffs_path, notice: '招待メールを送信しました'
    else
      render :index
    end
  end

  private

    def staff_params
      params.require(:staff).permit(:email)
    end
end
