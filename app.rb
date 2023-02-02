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

  def show_list(option)
    puts list_books if option == '1'
    puts list_people if option == '2'
  end

  def run
    loop do
      client = Client.new
      option = client.option
      show_list(option)
      third_option(client) if option == '3'
      fourth_option(client) if option == '4'
      fifth_option(client) if option == '5'
      six_option(client) if option == '6'
      break if option == '7'
    end
    puts 'Thank you for using this app!'
  end
end
