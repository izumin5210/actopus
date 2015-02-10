module KlassesDisplayable
  extend ActiveSupport::Concern
  include TimetableDisplayable

  def index
    @klasses = Klass.includes(:department).all
  end

  private

  def set_klass
    @klass = Klass.friendly.find(params[:id])
  end

  def set_lectures
    set_klass
    @lectures = @klass.lectures.includes(:lecturers, wday_periods: [:period])
  end
end
