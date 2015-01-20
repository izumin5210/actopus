class TimetableForm
  include ActiveModel::Model

  attr_reader :term, :count
  attr_accessor :name, :started_on, :ended_on, :timetable_xml

  validates :name, presence: true
  validates :started_on, presence: true
  validates :ended_on, presence: true
  validates :timetable_xml, presence: true
  validates_with StartAndEndDateValidator

  def initialize(attrs = {})
    attrs.each do |attr, value|
      public_send("#{attr}=", value) if respond_to?("#{attr}=")
    end
  end

  def save
    ActiveRecord::Base.transaction do
      @term = Term.create!(name: @name, started_on: @started_on, ended_on: @ended_on,
          xml_filename: @timetable_xml.original_filename)
      @count = lecture_transaction
    end
    true
  rescue
    errors.add(:base, 'XMLファイルが不正なフォーマットです')
    false
  end

  private

  def lecture_transaction
    # TODO: 発行されるクエリ数が多すぎるのでバルクインサート等の対策を検討
    klasses, periods = Klass.all, Period.all
    lecturers, wday_periods = [], []
    count = { lecture: 0, lecturer: 0 }
    LectureMapper.parse(@timetable_xml.read).each do |mapper|
      lecture = create_lecture(mapper, klasses)
      map_periods_onto_lecture(mapper, lecture, periods, wday_periods)
      count[:lecturer] += map_lecturers_onto_lecture(mapper, lecture, lecturers)
      count[:lecture] += 1
    end
    count
  end

  def create_lecture(mapper, klasses)
    mapper.to_record.tap do |lecture|
      lecture.klass = klasses.find do |k|
          (k.grade == mapper.grade) &&
            (k.department.name == mapper.department) &&
            (mapper.course.blank? || k.course.try(:name) == mapper.course)
        end
      lecture.term = @term
      lecture.save!
    end
  end

  def map_periods_onto_lecture(mapper, lecture, periods, wday_periods)
    mapper.period_params.each do |params|
      wday_period = wday_periods.find { |wp| wp.is?(params) }
      if wday_period.blank?
        period = periods.find { |p| p.is?(params) }
        wday_period = WdayPeriod.create(period: period, wday: params[:wday])
        wday_periods << wday_period
      end
      lecture.schedulings.create!(wday_period: wday_period)
    end
  end

  def map_lecturers_onto_lecture(mapper, lecture, lecturers)
    mapper.lecturer_params.inject(0) do |count, params|
      lecturer = lecturers.find { |l| l.name == params[:name] }
      if lecturer.blank?
        lecturer = Lecturer.create!(name: params[:name])
        lecturers << lecturer
        count += 1
      end
      lecture.lecturers << lecturer
      count
    end
  end
end
