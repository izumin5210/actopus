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
end
