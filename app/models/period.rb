# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  begin_at   :string           not null
#  end_at     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_periods_on_begin_at_and_end_at  (begin_at,end_at) UNIQUE
#  index_periods_on_name                 (name) UNIQUE
#

class Period < ActiveRecord::Base
  has_many :held_lectures
  has_many :lectures, through: :held_lectures

  validates :name, presence: true, uniqueness: true
  validates :begin_at, presence: true, uniqueness: { scope: [:end_at] }
  validates :end_at, presence: true

  # TODO: 3つ以上のコマにまたがる場合の対応
  def self.find_by_time(begin_at, end_at)
    periods = []
    periods << Period.find_by(begin_at: begin_at, end_at: end_at)
    unless periods.compact!.nil?
      periods << Period.where(begin_at: begin_at).order(end_at: :asc).last
      periods << Period.where(end_at: end_at).order(begin_at: :asc).first
    end
    periods
  end
end
