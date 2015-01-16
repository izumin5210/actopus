class ReschedulingForm
  include ActiveModel::Model

  attr_accessor :rescheduling, :category, :lecture_id,
    :before_period_id, :before_date, :after_period_id, :after_date

  delegate :lecture, to: :rescheduling
  delegate :klass, to: :lecture

  validates :category, presence: true

  def save
    ActiveRecord::Base.transaction do
      before_dp_params = { period_id: before_period_id, taken_on: before_date }
      before_date_period = DatePeriod.find_or_create_by(before_dp_params)
      after_dp_params = { period_id: after_period_id, taken_on: after_date }
      after_date_period = DatePeriod.find_or_create_by(after_dp_params)
      self.rescheduling = Rescheduling.create!(
        category: category, lecture_id: lecture_id,
        before_date_period: before_date_period,
        after_date_period: after_date_period)
      true
    end
  rescue
    false
  end
end
