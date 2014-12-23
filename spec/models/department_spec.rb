# == Schema Information
#
# Table name: departments
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  abbreviation_name :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_departments_on_abbreviation_name  (abbreviation_name) UNIQUE
#  index_departments_on_name               (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Department, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
