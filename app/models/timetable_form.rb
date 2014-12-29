class TimetableForm
  include ActiveModel::Model

  attr_reader :name, :start_on, :end_on, :timetable_xml

  def initialize(*args)
    args.each do |attr, value|
      public_send("#{attr}=", value) if respond_to?("#{attr}=")
    end
  end

  def save
  end
end
