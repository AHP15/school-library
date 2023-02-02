require_relative './person'

class Teacher < Person
  def initialize(age, specialization, name = 'Unknown')
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_s
    "[Teacher]: ID: #{@id} name: #{@name}, age: #{@age}, specialization: #{@specialization}"
  end
end
