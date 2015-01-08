# == Schema Information
#
# Table name: lectures
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  grade            :integer          not null
#  overseas_student :boolean          default("f")
#  department_id    :integer          not null
#  course_id        :integer
#  term_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  klass_id         :integer
#
# Indexes
#
#  index_lectures_on_klass_id  (klass_id)
#

require 'rails_helper'

RSpec.describe Lecture, type: :model do
  let(:lecture) { build(:lecture) }
  subject { lecture }

  describe 'associations' do
    it { is_expected.to belong_to(:klass) }
    it { is_expected.to belong_to(:department) }
    it { is_expected.to belong_to(:course) }
    it { is_expected.to belong_to(:term) }
    it { is_expected.to have_many(:lecturings) }
    it { is_expected.to have_many(:lecturers).through(:lecturings) }
    it { is_expected.to have_many(:schedulings) }
    it { is_expected.to have_many(:wday_periods).through(:schedulings) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:grade) }
    it { is_expected.to validate_presence_of(:department_id) }
    it { is_expected.to validate_presence_of(:term_id) }
  end
end
