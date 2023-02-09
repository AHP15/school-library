require_relative './helper_spec'

describe Student do
  before :all do
    @student = Student.new(18, 'Roland', true)
  end

  context 'Student class' do
    it('Should be and instance of the Student class') do
      expect(@student).to be_an_instance_of(Student)
    end

    it('Should display method message') do
      expect(@student.play_hooky).to eq('¯(ツ)/¯')
    end
  end
end
