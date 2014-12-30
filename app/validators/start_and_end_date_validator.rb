class StartAndEndDateValidator < ActiveModel::Validator
  def validate(record)
    if date_present?(record) && (record.end_on < record.start_on)
      record.errors.add(:end_on, :greater_than, count: record.start_on)
    end
  end

  def date_present?(record)
    record.start_on.present? && record.end_on.present?
  end
end
