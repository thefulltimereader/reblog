class Example_user
  attr_accessor :name, :email # gives us getter/setter

  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end

  #exercises ch 4
  def shuffle_str(str)
    str.split('').to_a.shuffle.join
  end

end
