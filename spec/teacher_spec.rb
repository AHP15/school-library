require_relative './helper_spec'

describe Teacher do
  before :all do
    @teacher = Teacher.new(35, 'English', 'Donald')
  end

  context 'Teacher class tests' do
    it('Should be an instance of the teacher class') do
      expect(@teacher).to be_an_instance_of(Teacher)
    end

    it('Should return teacher specialization') do
      expect(@teacher.specialization).to eq('English')
    end

    it('Should be truthy') do
      expect(@teacher.can_use_services?).to be true
    end
  end
end
