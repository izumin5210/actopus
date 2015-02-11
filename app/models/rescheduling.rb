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

  scope :available, -> do
    before = DatePeriod.arel_table.alias('before_date_period')
    after = DatePeriod.arel_table.alias('after_date_period')
    join_on_before =
      arel_table.create_on(before[:id].eq arel_table[:before_date_period_id])
    join_on_after =
      arel_table.create_on(after[:id].eq arel_table[:after_date_period_id])
    join_before =
      arel_table.create_join(before, join_on_before, Arel::Nodes::OuterJoin)
    join_after =
      arel_table.create_join(after, join_on_after, Arel::Nodes::OuterJoin)
    cond1 = after[:taken_on].gteq(Date.today)
    cond2 = after[:taken_on].eq(nil)
    cond3 = before[:taken_on].gteq(Date.today)
    joins(join_before, join_after).where(cond1.or(cond2.and cond3))
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
end
