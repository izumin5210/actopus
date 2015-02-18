class Staffs::ReschedulingsController < Staffs::BaseController
  def new
  end

  def create
    @rescheduling = Rescheduling.new(rescheduling_params)
    if @rescheduling.save
      redirect_to new_staffs_rescheduling_path,
        notice: "#{@rescheduling.taken_on} #{@rescheduling.lecture.name}を変更しました"
    else
      redirect_to new_staffs_rescheduling_path, alert: '時間割変更の作成に失敗しました'
    end
  end

  private

  def rescheduling_params
    params.require(:rescheduling).permit(
      :category, :taken_on, :lecture_id, :period_id)
  end
end
