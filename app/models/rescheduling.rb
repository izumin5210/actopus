# == Schema Information
#
# Table name: reschedulings
#
#  id                    :integer          not null, primary key
#  lecture_id            :integer
#  before_date_period_id :integer
#  after_date_period_id  :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  category              :integer
#  period_time_id        :integer
#  scheduled_on          :date
#
# Indexes
#
#  index_reschedulings_on_period_time_id  (period_time_id)
#  index_reschedulings_on_scheduled_on    (scheduled_on)
#

class Rescheduling < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :before_date_period, class_name: 'DatePeriod'
  belongs_to :after_date_period, class_name: 'DatePeriod'
  belongs_to :period_time

  validates :lecture_id, presence: true
  validates :category, presence: true

  delegate :klass, :lecturers, to: :lecture

  enum category: Settings.rescheduling.category

  scope :available, -> { after(Date.today) }

  by_star_field :scheduled_on

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
