require 'rails_helper'

describe StartAndEndDateValidator, type: :validator do
  let(:attribute_names) { [:start_on, :end_on] }
  let(:start_on) { Date.new(2014, 10, 1) }

  describe '#validate' do
    context 'when start_on is earlier than end_on' do
      let(:end_on) { Date.new(2015, 2, 28) }
      it { is_expected.to be_valid }
    end

    context 'when start_on is later than end_on' do
      let(:end_on) { Date.new(2014, 2, 28) }
      it { is_expected.to_not be_valid }
    end
  end
end
