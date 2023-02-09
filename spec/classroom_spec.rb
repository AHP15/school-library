require_relative './helper_spec'

describe Classroom do
  before :all do
    @classroom = Classroom.new('math')
  end

  context 'Classroom class' do
    it 'initialize instance' do
      expect(@classroom).to be_an_instance_of(Classroom)
    end

    it 'Add new student' do
      # Arrange
      length = @classroom.students.length

      # Act
      student = Student.new(20, 'test student', true)
      @classroom.add_student(student)

      # Assertion
      expect(@classroom.students.length).to eq(length + 1)
    end
  end
end
