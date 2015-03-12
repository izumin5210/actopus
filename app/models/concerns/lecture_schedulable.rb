module LectureSchedulable
  extend ActiveSupport::Concern

  def reschedulings(range)
    fail ArgumentError, 'argument "range" is not present.' if range.blank?
    ids = lectures.current_term.pluck(:id)
    Rescheduling.where(lecture_id: ids).where(taken_on: range)
  end
end
