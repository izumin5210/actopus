require 'rails_helper'

RSpec.describe LectureSchedulable, type: :model do
  let(:dummy_class) do
    Class.new do
      include LectureSchedulable
      def lectures; end
    end
  end

  let(:record) { dummy_class.new }

  describe '#reschedulings' do
    let(:date) { Date.new(2015, 1, 21) }
    let(:range) { nil }
    let(:term) { create(:academic_term) }
    let(:klass) { create(:klass, :with_department) }
    let(:lectures) { create_list(:lecture, 3, term: term, klass: klass) }
    let!(:reschedulings) do
      [
        create(:rescheduling, :cancel,
               lecture: lectures[0], taken_on: date + 2.day),
        create(:rescheduling, :addition,
               lecture: lectures[1], taken_on: date - 1.day),
        create(:rescheduling, :addition,
               lecture: lectures[2], taken_on: date - 1.day),
        create(:rescheduling, :cancel,
               lecture: lectures[0], taken_on: date + 1.week)
      ]
    end
    subject { record.reschedulings(range) }

    before do
      Timecop.freeze(date)
      allow(record).to(
        receive_message_chain(:lectures, :current_term, :pluck)
          .with(:id).and_return(lectures[0, 2].map(&:id))
      )
    end
    after { Timecop.return }

    context 'without range' do
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with 20150119..20150124 as range' do
      let(:range) { date.beginning_of_week..date.end_of_week }
      it 'has 2 rescheduling objects' do
        expect(subject.size).to eq 2
      end

      it 'all rescheduings within the range' do
        be_within_range = -> (r) { range.cover?(r.taken_on) }
        expect(subject).to all(satisfy(&be_within_range))
      end
    end
  end
end
