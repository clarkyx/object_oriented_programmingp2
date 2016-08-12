class Person
  def initialize(name)
    @name = name
  end

  def greetings
    puts "Hello my name is #{@name}"
  end
end

class Student < Person
  def learn
    puts "I get it!"
  end
end

class Instructor < Person
  def teach
    puts "Everything in Ruby is an Object"
  end
end

chris = Instructor.new("Chris")
chris.greetings
cristina = Student.new("Cristina")
cristina.greetings
chris.teach
cristina.learn

=begin
  object cristina does not have method
  teach since Student class does not
  inherit method teach from class Instructor
=end

#cristina.teach
