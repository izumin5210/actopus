# == Schema Information
#
# Table name: reschedulings
#
#  id         :integer          not null, primary key
#  lecture_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  period_id  :integer
#  taken_on   :date
#
# Indexes
#
#  index_reschedulings_on_category    (category)
#  index_reschedulings_on_lecture_id  (lecture_id)
#  index_reschedulings_on_period_id   (period_id)
#  index_reschedulings_on_taken_on    (taken_on)
#

class Rescheduling < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :period

  validates :lecture_id, presence: true
  validates :period_id, presence: true
  validates :taken_on, presence: true
  validates :category, presence: true

  delegate :klass, :lecturers, to: :lecture

  enum category: Settings.rescheduling.category

  scope :available, -> { where(arel_table[:taken_on].gteq Date.today) }

  include Garage::Representer
  include Garage::Authorizable

  property :category
  property :lecture
  property :before_date_period,
           as: :before_period,
           if: -> (record, _) { record.before_date_period.present? }
  property :after_date_period,
           as: :after_period,
           if: -> (record, _) { record.after_date_period.present? }

  def self.build_permissions(perms, other, target)
    perms.permits! :read
  end

  def build_permissions(perms, other)
    perms.permits! :read
  end
end
