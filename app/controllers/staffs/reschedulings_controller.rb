class Staffs::ReschedulingsController < Staffs::BaseController
  def new
  end

  def create
    @form = ReschedulingForm.new(rescheduling_form_params)
    if @form.save
      redirect_to timetable_staffs_klass_path(@form.rescheduling.lecture.klass_id),
        notice: "#{@form.before_date} #{@form.lecture.name}を変更しました"
    else
      redirect_to new_staffs_rescheduling_path, alert: '時間割変更の作成に失敗しました'
    end
  end

  private

  def rescheduling_form_params
    params.require(:rescheduling_form).permit(
      :lecture_id, :category, :before_period_id, :before_date)
  end
end
