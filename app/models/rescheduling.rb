# == Schema Information
#
# Table name: reschedulings
#
#  id                    :integer          not null, primary key
#  lecture_id            :integer
#  before_date_period_id :integer
#  after_date_period_id  :integer
#  category              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Rescheduling < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :before_date_period, class_name: 'DatePeriod'
  belongs_to :after_date_period, class_name: 'DatePeriod'

  validates :lecture_id, presence: true
  validates :category, presence: true
  validates_with ReschedulingValidator

  delegate :klass, :lecturers, to: :lecture

  enum category: Settings.rescheduling.category

  scope :join_before_date_period, -> do
    before = before_date_period_arel_table
    joins(
      arel_table.join(before, Arel::Nodes::OuterJoin)
        .on(before[:id].eq arel_table[:before_date_period_id]).join_sources
    )
  end

  scope :join_after_date_period, -> do
    after = after_date_period_arel_table
    joins(
      arel_table.join(after, Arel::Nodes::OuterJoin)
        .on(after[:id].eq arel_table[:after_date_period_id]).join_sources
    )
  end

  scope :available, -> do
    after = after_date_period_arel_table
    cond1 = after[:taken_on].gteq(Date.today)
    cond2 = after[:taken_on].eq(nil)
    cond3 = before_date_period_arel_table[:taken_on].gteq(Date.today)
    join_before_date_period.join_after_date_period
      .where(cond1.or(cond2.and cond3))
  end

  scope :on, -> (date_period) do
    cond1 = before_date_period_arel_table[:taken_on].eq(date_period.taken_on)
    cond2 = after_date_period_arel_table[:taken_on].eq(date_period.taken_on)
    join_before_date_period.join_after_date_period.where(cond1.or cond2)
  end

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

  def self.before_date_period_arel_table
    DatePeriod.arel_table.alias('before_date_period')
  end

  def self.after_date_period_arel_table
    DatePeriod.arel_table.alias('after_date_period')
  end
end
