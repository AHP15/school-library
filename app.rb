require 'fileutils'
require 'json'

require_relative './models/student'
require_relative './models/teacher'
require_relative './models/book'
require_relative './models/rental'
require_relative './client'

class App
  def initialize
    @books = data('storage', 'books.json') || []
    @people = data('storage', 'people.json') || []
    @rentals = data('storage', 'rentals.json') || {}
  end

  def data(directory, filename)
    FileUtils.mkdir_p(directory)
    file_path = "./#{directory}/#{filename}"
    File.exist?(file_path) && JSON.parse(File.read(file_path))
  end

  def store_data
    File.write('./storage/books.json', JSON.pretty_generate(@books))
    File.write('./storage/people.json', JSON.pretty_generate(@people))
    File.write('./storage/rentals.json', JSON.pretty_generate(@rentals))
  end

  def list_books
    @books.map do |book|
      "Title: #{book['title']}, Author: #{book['author']}"
    end
  end

  def list_people
    @people.map do |person|
      info = "ID: #{person['id']} name: #{person['name']}, age: #{person['age']}"
      if person['parent_permission']
        "[Student]: #{info}, has permission: #{person['parent_permission']}"
      else
        "[Teacher]: #{info}, specialization: #{person['specialization']}"
      end
    end
  end

  def list_rentals(id)
    @rentals[id].map do |rental|
      "Date: #{rental['date']}, Book: #{rental['book']['title']}, By: #{rental['person']['name']}"
    end
  end

  def instance_to_hash(instance)
    hash = {}
    instance.instance_variables.each do |var|
      key = var.to_s.delete('@').to_sym
      hash[key.to_s] = instance.instance_variable_get(var)
    end
    hash
  end

  def create_student(student)
    @people << instance_to_hash(student)
  end

  def create_teacher(teacher)
    @people << instance_to_hash(teacher)
  end

  def create_person(person)
    if person.respond_to?(:specialization)
      create_teacher(person)
    else
      create_student(person)
    end
    puts 'Person created successfully!'
  end

  def create_book(book)
    @books << instance_to_hash(book)
    puts 'Book created successfully!'
  end

  def create_rental(id, rental)
    if @rentals[id]
      @rentals[id] << instance_to_hash(rental)
    else
      @rentals[id] = [instance_to_hash(rental)]
    end
    puts 'Rental created successfully!'
  end

  def list_data(option)
    case option
    when '1'
      puts list_books
    when '2'
      puts list_people
    end
  end
end
