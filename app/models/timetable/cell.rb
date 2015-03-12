module Timetable
  class Cell
    include ActiveModel::Model

    attr_accessor :lecture, :period, :taken_on, :rescheduling
    define_model_callbacks :initialize, only: :after
    after_initialize :load_rescheduling

    validates :lecture, presence: true
    validates :period, presence: true
    validates :taken_on, presence: true

    delegate :start_time, :end_time, to: :period
    delegate :category, to: :rescheduling, prefix: true, allow_nil: true

    def initialize(*args)
      run_callbacks(:initialize) { super(*args) }
    end

    def load_rescheduling
      self.rescheduling = lecture
        .reschedulings.cancel.find_by(taken_on: taken_on, period_id: period.id)
    end
  end
end
