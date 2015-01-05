class StartAndEndDateValidator < ActiveModel::Validator
  def validate(record)
    if date_present?(record) && (record.ended_on < record.started_on)
      record.errors.add(:ended_on, :greater_than, count: record.started_on)
    end
  end

  def date_present?(record)
    record.started_on.present? && record.ended_on.present?
  end
end
