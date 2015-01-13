class Staffs::StaffsController < Staffs::BaseController
  def index
    @staffs = Staff.all
    @staff = Staff.new
  end

  def invite
    @staff = Staff.invite!(staff_params)
    if @staff.errors.empty?
      redirect_to staffs_staffs_path, notice: I18n.t('devise.invitations.send_instructions')
    else
      render :index
    end
  end

  private

    def staff_params
      params.require(:staff).permit(:email)
    end
end
