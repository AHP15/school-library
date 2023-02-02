require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './client'
require_relative './rental'

class App
  def initialize()
    @books = []
    @people = []
    @rentals = {}
  end

  def list_books
    @books
  end

  def list_people
    @people
  end

  def list_rentals(id)
    @rentals[:id]
  end

  def create_person(person)
    new_person = nil
    if person[:type] == 'student'
      new_person = Student.new(person[:age], person[:name], person[:parent_permission])
    else
      new_person = Teacher.new(person[:age], person[:specialization], person[:name])
    end

    @people.push(new_person)
  end

  def create_book(book)
    @books.push(Book.new(book[:title], book[:author]))
  end

  def create_rental(date, book, person)
    id = person.instance_variable_get(:@id)
    if @rentals[:id]
      @rentals[:id].push(Rental.new(date, book, person))
    else
      @rentals[:id] = [Rental.new(date, book, person)]
    end
  end

  def run
    while true
      client = Client.new()

      case client.option
      when '1'
        puts list_books()
      when '2'
        puts list_people()
      when '3'
        person = client.get_person_info()
        create_person(person)
        puts 'Person created successfully'
      when '4'
        book = client.get_book_info()
        create_book(book)
        puts 'Book created successfully'
      when '5'
        rental = client.get_rental_info(@books, @people)
        create_rental(rental[:date], rental[:book], rental[:person])
        puts 'Rental created successfully'
      when '6'
        id = client.get_person_id()
        puts 'Rentals:'
        puts list_rentals(id)
      when '7'
        puts 'Thank you for using this app!'
        break
      else
        puts 'Invalid number!'
      end
    end
  end
end
