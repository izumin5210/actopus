class ReschedulingForm
  include ActiveModel::Model

  attr_accessor :rescheduling, :category,
    :before_lecture_id, :before_period_id, :before_date,
    :after_lecture_id, :after_period_id, :after_date

  delegate :lecture, to: :rescheduling
  delegate :klass, to: :lecture

  validates :category, presence: true

  def save
    ActiveRecord::Base.transaction do
      before_dp_params = { period_id: before_period_id, taken_on: before_date }
      before_dp = DatePeriod.find_or_create_by!(before_dp_params)
      self.rescheduling = Rescheduling.create!(
        category: category,
        before_date_period_id: before_dp.id, lecture_id: before_lecture_id)
      true
    end
  rescue
    false
  end
end
