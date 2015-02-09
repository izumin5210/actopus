class ReschedulingForm
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  BEFORE_DATE_PERIOD_COLUMNS =
    %i(before_period_id before_date before_date_period)
  AFTER_DATE_PERIOD_COLUMNS =
    %i(after_period_id after_date after_date_period)

  attr_accessor :rescheduling, :category, :lecture_id,
    *BEFORE_DATE_PERIOD_COLUMNS, *AFTER_DATE_PERIOD_COLUMNS

  delegate :lecture, to: :rescheduling
  delegate :klass, to: :lecture

  validates :category, presence: true
  validates_with ReschedulingValidator

  before_validation DatePeriodBuilder.new(*BEFORE_DATE_PERIOD_COLUMNS)
  before_validation DatePeriodBuilder.new(*AFTER_DATE_PERIOD_COLUMNS)

  def save
    ActiveRecord::Base.transaction do
      fail ActiveRecord::RecordInvalid unless valid?
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
