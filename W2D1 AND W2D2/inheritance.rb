class Employee

  def initialize(name, title, salary, boss=nil)
    @name, @title, @salary, @boss = name, title, salary, boss
    update_boss
  end

  def bonus(multiplier)
    bonus = salary * multiplier
  end

  def update_boss
    boss.employees << self unless boss.nil?
  end

  # private
  attr_reader :salary, :name, :title, :boss
end

class Manager < Employee
  def initialize(name, title, salary, boss=nil)
    @name, @title, @salary, @boss = name, title, salary, boss
    @employees = []
    self.update_boss
  end

  def bonus(multiplier)
    result = salary
    employees.each do |employee|
      result += employee.salary
    end
    result * multiplier
  end




  # private
  attr_reader :salary, :name, :title, :boss
  attr_accessor :employees
end

if __FILE__ == $PROGRAM_NAME
  ned = Manager.new("Ned", "Founder", 1000)
  darren = Manager.new("Darren", "TA Manager", 500, ned)
  shawna = Employee.new("Shawna", "TA", 150, darren)
  # p ned.employees
  p shawna.bonus(2)
  p darren.class
  p darren.bonus(4)
  p darren.employees
  p ned.employees
  p ned.bonus(2)

end
