require_relative './helper_spec'

describe Rental do
  before :all do
    @book = Book.new('Book', 'Author')
    @person = Person.new(23, 'Joy', true)
    @rental = Rental.new('2023/02/05', @book, @person)
  end

  context 'Rental class test' do
    it('Should be an instance of the Rental class') do
      expect(@rental).to be_an_instance_of(Rental)
    end

    it('should return person name') do
      expect(@person.name).to eq('Joy')
    end

    it('should be an instance') do
      expect(@book).to be_an_instance_of(Book)
    end
  end
end
