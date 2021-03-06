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
#  code           :string
#
# Indexes
#
#  index_lectures_on_code      (code)
#  index_lectures_on_klass_id  (klass_id)
#  index_lectures_on_term_id   (term_id)
#

require 'rails_helper'

RSpec.describe Lecture, type: :model do
  let(:lecture) { Lecture.new }
  subject { lecture }

  describe 'associations' do
    it { is_expected.to belong_to(:klass) }
    it { is_expected.to belong_to(:term).class_name('AcademicTerm') }
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

  describe 'delegations' do
    it { is_expected.to delegate_method(:grade).to(:klass) }
    it { is_expected.to delegate_method(:department).to(:klass) }
    it { is_expected.to delegate_method(:course).to(:klass) }
    it { is_expected.to delegate_method(:name).to(:department).with_prefix }
    it { is_expected.to delegate_method(:name).to(:course).with_prefix }
  end

  describe 'enums' do
    it do
      is_expected.to(define_enum_for(:special_target)
        .with(Settings.lecture.special_target.keys))
    end
  end

  describe '.current_term' do
    create_term_and_freeze_time
    subject { Lecture.current_term }

    let!(:lectures) { create_list(:lecture, 5, term: term) }
    let(:started_on) { term.started_on }
    let(:ended_on) { term.ended_on }

    let(:prev_term) do
      create(:academic_term,
        started_on: started_on.prev_year, ended_on: ended_on.prev_year,
        xml_filename: "#{started_on.prev_year}.xml")
    end

    let(:next_term) do
      create(:academic_term,
        started_on: started_on.next_year, ended_on: ended_on.next_year,
        xml_filename: "#{started_on.next_year}.xml")
    end

    it { is_expected.to match_array(lectures) }
    it { expect(subject.size).to eq 5 }
  end
end
