require_relative './helper_spec.rb'

describe Book do
  before :each do
    @book = Book.new('Test title', 'Test author')
  end

  context 'Book class' do
    it 'initialize instance' do
      expect(@book).to be_an_instance_of(Book)
    end

    it 'initialize two properties' do
      expect(@book).to have_attributes(title: 'Test title', author: 'Test author')
    end

    it 'Adds a rental' do
      # Arrange
      length = @book.rentals.length

      # Act
      @book.add_rental('2023/02/09', 'test person')

      # Assertion
      expect(@book.rentals.length).to eq(length + 1)
    end
  end
end
