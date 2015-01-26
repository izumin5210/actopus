# == Schema Information
#
# Table name: academic_terms
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  xml_filename :string           not null
#  started_on   :date             not null
#  ended_on     :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_academic_terms_on_ended_on                 (ended_on)
#  index_academic_terms_on_started_on               (started_on)
#  index_academic_terms_on_started_on_and_ended_on  (started_on,ended_on) UNIQUE
#  index_academic_terms_on_xml_filename             (xml_filename) UNIQUE
#

require 'rails_helper'

RSpec.describe AcademicTerm, type: :model do
  let(:term) { create(:term) }
  subject { term }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:xml_filename) }
    it { is_expected.to validate_presence_of(:started_on) }
    it { is_expected.to validate_presence_of(:ended_on) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:lectures) }
  end
end
