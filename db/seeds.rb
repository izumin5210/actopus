# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rake::Task['db:migrate:reset'].invoke

puts 'Create staff...'
staff = FactoryGirl.create(:staff)
puts "# => #{staff.email}, password"

puts 'Create term...'
FactoryGirl.create(:term)

%w(department course period).each do |seed|
  Rake::Task["db:seed:#{seed}"].invoke
end

puts 'Create lecturers...'
lecturer_params = {
  G: ['善塔 正志', '仁木 夏実'],
  M: ['加藤 隆弘', '國峰 寛司'],
  E: ['大向 雅人', '佐村 敏治'],
  C: ['石丸 和宏', '江口 忠臣'],
  A: ['大塚 毅彦', '坂戸 省三']
}

lecturer_params.each do |dept_abbr, lecturer_names|
  department = Department.find_by(abbreviation_name: dept_abbr)
  lecturer_names.each do |lecturer_name|
    Lecturer.create(name: lecturer_name, department: department)
  end
end

['石田 祐', '境田 彰芳', '堤 保雄', '神田 佳一', '田坂 誠一'].each do |name|
  Lecturer.create(name: name)
end
