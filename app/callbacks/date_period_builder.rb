class DatePeriodBuilder
  def initialize(period_time_id_column, taken_on_column, date_period_column)
    @period_time_id_column = period_time_id_column
    @taken_on_column = taken_on_column
    @date_period_column = date_period_column
  end

  def before_validation(record)
    if should_build?(record)
      record.send(:"#{@date_period_column}=", date_period(record))
    end
  end

  private

  def should_build?(record)
    [period_time_id(record), taken_on(record)].all?(&:present?)
  end

  def period_time_id(record)
    record.send(@period_time_id_column)
  end

  def taken_on(record)
    record.send(@taken_on_column)
  end

  def date_period(record)
    DatePeriod.find_or_initialize_by(
      period_time_id: period_time_id(record), taken_on: taken_on(record))
  end
end
