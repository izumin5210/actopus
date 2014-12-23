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

require 'rails_helper'

RSpec.describe Period, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
