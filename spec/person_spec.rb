require_relative './helper_spec'

describe Person do
  before :each do
    @person = Person.new(25, 'test person', true)
  end

  it 'initialize instance' do
    expect(@person).to be_an_instance_of(Person)
  end

  it 'initialize properties' do
    expect(@person).to have_attributes(
      age: 25,
      name: 'test person',
      rentals: []
    )
  end

  it 'can use service' do
    expect(@person.can_use_services?).to eq(true)
  end

  it 'give correct name' do
    expect(@person.correct_name).to eq('test person')
  end
end

describe Nameable do
  before :all do
    @nameable = Nameable.new
  end

  context 'Nameable class' do
    it 'Initialize instance' do
      expect(@nameable).to be_an_instance_of(Nameable)
    end

    it 'Throw and error' do
      expect { @nameable.correct_name }.to raise_error(NotImplementedError)
    end
  end
end

describe Decorator do
  before :all do
    @person = Person.new(25, 'test person', true)
    @decorator = Decorator.new(@person)
  end

  context 'Decorator class' do
    it 'Initialize instance' do
      expect(@decorator).to be_an_instance_of(Decorator)
    end

    it 'Throw an error' do
      expect(@decorator.correct_name).to eq('test person')
    end
  end
end

describe CapitalizeDecorator do
  before :all do
    @person = Person.new(15, 'person', false)
    @capitalizer = CapitalizeDecorator.new(@person)
  end

  context 'Capitalize class' do
    it('should be an instance of CapitalizeDecorator') do
      expect(@capitalizer).to be_an_instance_of(CapitalizeDecorator)
    end

    it('Should capitalize person name') do
      expect(@capitalizer.correct_name).to eq('Person')
    end
  end
end

describe TrimmerDecorator do
  before :all do
    @person = Person.new(15, 'Alexandarion', false)
    @trimmer = TrimmerDecorator.new(@person)
  end

  context 'Capitalize class' do
    it('should be an instance of TrimmerDecorator') do
      expect(@trimmer).to be_an_instance_of(TrimmerDecorator)
    end

    it('Should trim person name') do
      expect(@trimmer.correct_name).to eq('Alexandari')
    end
  end
end
