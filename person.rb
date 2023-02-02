require_relative './rental'

class Nameable
  def correct_name
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class Decorator < Nameable
  attr_accessor :nameable

  def initialize(nameable)
    super
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    @nameable.correct_name.slice(0, 10)
  end
end

class Person < Nameable
  def initialize(age, name, parent_permission)
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  attr_accessor :id, :name, :age, :rentals

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rentals(date, book)
    new_rental = Rental.new(date, book, self)
    @rentals.push(new_rental)
  end

  private

  def of_age?
    @age >= 18
  end
end
