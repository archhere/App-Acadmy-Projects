# PHASE 2
def convert_to_int(str)
    begin
      result = Integer(str)
    rescue ArgumentError => e
      puts "Can't accept a word"
      puts "Error was: invalid value for Integer(): #{str}"
    ensure
      result ||= nil
    end
    puts result
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class CoffeeError < StandardError
  def message
    puts "I don't mind coffee, but I still want fruit."
  end
end

class NonFruitError < StandardError
  def message
    puts "That's not a fruit!"
  end
end

def reaction(maybe_fruit)

  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise NonFruitError
  end
end

def feed_me_a_fruit

  puts "Hello, I am a friendly monster. :)"
  begin
  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit)
  rescue CoffeeError => e
  e.message
    retry
  rescue NonFruitError => e
    e.message
  end

end

class NameError < StandardError
  def message
    puts "Please enter a valid name."
  end
end

class FavError < StandardError
  def message
    puts "Please enter a favorite pastime."
  end
end

class AgeError < StandardError
  def message
    puts "Can't be best friends for less than 5 years."
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    raise NameError if @name.empty?
    @yrs_known = yrs_known
    raise AgeError if @yrs_known < 5
    @fav_pastime = fav_pastime
    raise FavError if @fav_pastime.empty?
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
