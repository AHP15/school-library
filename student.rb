require_relative './person'

class Student < Person
  attr_reader :classroom

  def initialize(age, name = 'Unknown', parent_permission = true)
    super(age, name, parent_permission)
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def to_s
    "[Student]: ID: #{@id} name: #{@name}, age: #{@age}, has permission: #{@parent_permission}"
  end
end
