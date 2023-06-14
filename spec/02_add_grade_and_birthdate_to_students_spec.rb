require_relative '../db/migrate/20230614092253_create_students.rb'
require_relative '../db/migrate/20230614093333_add_grade_and_birthdate_to_students.rb'

describe AddGradeAndBirthdateToStudents do
  before do
    sql = "DROP TABLE IF EXISTS students"
    ActiveRecord::Base.connection.execute(sql)

    # Manually runs the migrations
    CreateStudents.new.change
    AddGradeAndBirthdateToStudents.new.change
    
    Student.reset_column_information
  end

  it 'has a grade' do
    student = Student.create(name: "Steven", grade: 12, birthdate: "April 5th")
    expect(Student.where(grade: 12).first).to eq(student)
  end

  it 'has a string birthdate' do
    student = Student.create(name: "Steven", grade: 12, birthdate: "April 5th")
    expect(Student.where(birthdate: "April 5th").first).to eq(student)
  end
end
