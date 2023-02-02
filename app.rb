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

  def list_rentals(_id)
    @rentals[:id]
  end

  def create_person(person)
    new_person = if person[:type] == 'student'
                   Student.new(person[:age], person[:name], person[:parent_permission])
                 else
                   Teacher.new(person[:age], person[:specialization], person[:name])
                 end

    @people.push(new_person)
  end

  def create_book(book)
    @books.push(Book.new(book[:title], book[:author]))
  end

  def create_rental(date, book, person)
    if @rentals[person.instance_variable_get(:@id)]
      @rentals[:id].push(Rental.new(date, book, person))
    else
      @rentals[:id] = [Rental.new(date, book, person)]
    end
  end

  def third_option(client)
    person = client.person_info
    create_person(person)
    puts 'Person created successfully'
  end

  def fourth_option(client)
    book = client.book_info
    create_book(book)
    puts 'Book created successfully'
  end

  def fifth_option(client)
    rental = client.rental_info(@books, @people)
    create_rental(rental[:date], rental[:book], rental[:person])
    puts 'Rental created successfully'
  end

  def six_option(client)
    id = client.person_id
    puts 'Rentals:'
    puts list_rentals(id)
  end

  def run
    loop do
      client = Client.new
      case client.option
      when '1'
        puts list_books
      when '2'
        puts list_people
      when '3'
        third_option(client)
      when '4'
        fourth_option(client)
      when '5'
        fifth_option(client)
      when '6'
        six_option(client)
      when '7'
        break
      end
    end
    puts 'Thank you for using this app!'
  end
end
