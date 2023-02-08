require_relative './models/student'
require_relative './models/teacher'
require_relative './models/book'
require_relative './models/rental'

class Client
  attr_reader :option

  def initialize
    options = [
      'List all books',
      'List all people',
      'Create a person',
      'Create a book',
      'Create a rental',
      'List all rentals for a given person id',
      'Exit'
    ]
    puts 'Please shoose an option by entring a number:'

    options.each_with_index do |option, i|
      puts "#{i + 1} - #{option}"
    end

    @option = gets.chomp
  end

  def validate_input(message, validation = ->(input) do input != '' end)
    loop do
      print message
      input = gets.chomp
      return input if validation.call(input)
    end
  end

  def person_info
    number = validate_input(
      'Do you wants to create a student (1) or a teacher (2)? [input the number]: ',
      ->(input) do %w[1 2].include?(input) end
    )
    age = validate_input('Age: ', ->(input) do (input.to_i.is_a? Integer) && input.to_i != 0 end)
    name = validate_input('Name: ')

    if number == '1'
      parent_permission = student_info
      Student.new(age, name, parent_permission.upcase == 'Y')
    else
      specialization = teacher_info
      Teacher.new(age, specialization, name)
    end
  end

  def student_info
    message = 'Has parent permission? [Y/N]: '
    validate_input(message, ->(input) do input.upcase == 'Y' || input.upcase == 'N' end)
  end

  def teacher_info
    validate_input('specialization: ')
  end

  def book_info
    title = validate_input('Title: ')
    author = validate_input('Author: ')
    Book.new(title, author)
  end

  def rental_info(books, people)
    message = "Select a book from the following list by number:\n"
    books.each_with_index do |book, i|
      message += "#{i}) Title: #{book['title']}, Author: #{book['author']}\n"
    end
    index = validate_input(message, ->(input) do input.to_i >= 0 && input.to_i < books.length end)
    book = books[index.to_i]
    message = "Select a person from the following list by number (not id):\n"
    people.each_with_index do |person, i|
      info = "ID: #{person['id']} name: #{person['name']}, age: #{person['age']}"
      message += if person['parent_permission']
                   "#{i}) [Student]: #{info}, has permission: #{person['parent_permission']}\n"
                 else
                   "[Teacher]: #{info}, specialization: #{person['specialization']}"
                 end
    end
    index = validate_input(message, ->(input) do input.to_i >= 0 && input.to_i < people.length end)
    person = people[index.to_i]
    date = validate_input('Date: ')

    rental = Rental.new(date, book, person)
    { id: person['id'], rental: rental }
  end

  def person_id()
    message = 'ID of person: '
    validate_input(message, ->(input) do input.to_i.is_a? Integer end)
  end
end
