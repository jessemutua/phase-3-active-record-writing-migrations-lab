require_relative '../db/migrate/20230614092253_create_students.rb'
require_relative '../db/migrate/20230614093333_add_grade_and_birthdate_to_students.rb'
require_relative '../db/migrate/20230614093653_change_datatype_for_birthdate.rb'

describe ChangeDatatypeForBirthdate do
  before do
    sql = "DROP TABLE IF EXISTS students"
    ActiveRecord::Base.connection.execute(sql)

    # Manually runs the migration
    CreateStudents.new.change
    AddGradeAndBirthdateToStudents.new.change
    ChangeDatatypeForBirthdate.new.change

    Student.reset_column_information
  end

  it 'has a birthday as a datetime datatype' do
    student = Student.create(name: "Steven", birthdate: DateTime.new(2000, 1, 1))
    expect(Student.where(birthdate: DateTime.new(2000, 1, 1)).first).to eq(student)
  end
end
