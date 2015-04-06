require 'active_support/concern'

module TermHelper
  extend ActiveSupport::Concern

  included do
    def self.create_term_and_freeze_time
      let(:term) { create(:academic_term) }

      let(:today) do
        [*term.started_on..term.ended_on].tap { |r| break r[r.size / 2] }
      end

      let(:now) { today.midday }

      before { Timecop.freeze(now) }
      after { Timecop.return }
    end
  end
end
