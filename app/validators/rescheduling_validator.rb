class ReschedulingValidator < ActiveModel::Validator
  def validate(record)
    if Rescheduling.categories.keys.include?(record.category)
      send("validate_#{record.category}", record)
    end
  end

  private

  def validate_cancel(record)
    validate_presence_of_before_date_period(record)
  end

  def validate_addition(record)
    validate_presence_of_after_date_period(record)
  end

  def validate_change(record)
    validate_presence_of_before_date_period(record)
    validate_presence_of_after_date_period(record)
  end

  def validate_presence_of_before_date_period(record)
    if record.before_date_period.blank?
      record.errors.add(:before_date_period, :empty)
    end
  end

  def validate_presence_of_after_date_period(record)
    if record.after_date_period.blank?
      record.errors.add(:after_date_period, :empty)
    end
  end
end
