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
#

require 'rails_helper'

RSpec.describe Lecture, type: :model do
  let(:lecture) { create(:lecture) }
  subject { lecture }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:grade) }
    it { is_expected.to validate_presence_of(:department_id) }
    it { is_expected.to validate_presence_of(:term_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:department) }
    it { is_expected.to belong_to(:course) }
    it { is_expected.to belong_to(:term) }
    it { is_expected.to have_many(:lecturings) }
    it { is_expected.to have_many(:lecturers).through(:lecturings) }
    it { is_expected.to have_many(:held_lectures) }
    it { is_expected.to have_many(:periods).through(:held_lectures) }
  end
end
