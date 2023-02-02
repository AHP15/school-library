class Client
  attr_reader :option

  def initialize()
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

  def person_info()
    number = validate_input(
      'Do you wants to create a student (1) or a teacher (2)? [input the number]: ',
      ->(input) do %w[1 2].include?(input) end
    )
    age = validate_input('Age: ', ->(input) do (input.to_i.is_a? Integer) && input.to_i != 0 end)
    name = validate_input('Name: ')
    person_info = { age: age, name: name }
    if number == '1'
      message = 'Has parent permission? [Y/N]: '
      parent_permission = validate_input(message, ->(input) do input.upcase == 'Y' || input.upcase == 'N' end)
      person_info[:type] = 'student'
      person_info[:parent_permission] = parent_permission.upcase == 'Y'
    else
      person_info[:specialization] = validate_input('specialization: ')
      person_info[:type] = 'teacher'
    end
    person_info
  end

  def book_info()
    title = validate_input('Title: ')
    author = validate_input('Author: ')
    {
      title: title,
      author: author
    }
  end

  def rental_info(books, people)
    message = "Select a book from the following list by number:\n"
    books.each do |book|
      message += book.to_s
      message += "\n"
    end
    index = validate_input(message, ->(input) do input.to_i >= 0 && input.to_i < books.length end)
    book = books[index.to_i]
    message = "Select a book from the following list by number (not id):\n"
    people.each do |person|
      message += person.to_s
      message += "\n"
    end
    index = validate_input(message, ->(input) do input.to_i >= 0 && input.to_i < people.length end)
    person = people[index.to_i]
    date = validate_input('Date: ')
    { person: person, book: book, date: date }
  end

  def person_id()
    message = 'ID of person: '
    validate_input(message, ->(input) do input.to_i.is_a? Integer end)
  end
end
