# == Schema Information
#
# Table name: date_periods
#
#  id         :integer          not null, primary key
#  period_id  :integer
#  date_on    :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DatePeriod, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
