class StartAndEndDateValidator < ActiveModel::Validator
  def validate(record)
    if record.end_on < record.start_on
      record.errors.add(:end_on, :greater_than, count: record.start_on)
    end
  end
end
