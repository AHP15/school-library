require_relative './person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age, specialization, name)
    super(age, name, true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
