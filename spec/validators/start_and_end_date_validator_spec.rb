require 'rails_helper'

describe StartAndEndDateValidator, type: :validator do
  let(:attribute_names) { [:started_on, :ended_on] }
  let(:started_on) { Date.new(2014, 10, 1) }

  describe '#validate' do
    context 'when started_on is earlier than ended_on' do
      let(:ended_on) { Date.new(2015, 2, 28) }
      it { is_expected.to be_valid }
    end

    context 'when started_on is later than ended_on' do
      let(:ended_on) { Date.new(2014, 2, 28) }
      it { is_expected.to_not be_valid }
    end
  end
end
