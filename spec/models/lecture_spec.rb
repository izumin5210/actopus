# == Schema Information
#
# Table name: lectures
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  term_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  klass_id       :integer
#  special_target :integer
#
# Indexes
#
#  index_lectures_on_klass_id  (klass_id)
#  index_lectures_on_term_id   (term_id)
#

require 'rails_helper'

RSpec.describe Lecture, type: :model do
  let(:lecture) { build(:lecture) }
  subject { lecture }

  describe 'associations' do
    it { is_expected.to belong_to(:klass) }
    it { is_expected.to belong_to(:term) }
    it { is_expected.to have_many(:lecturings) }
    it { is_expected.to have_many(:lecturers).through(:lecturings) }
    it { is_expected.to have_many(:schedulings) }
    it { is_expected.to have_many(:wday_periods).through(:schedulings) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:klass_id) }
    it { is_expected.to validate_presence_of(:term_id) }
  end
end
