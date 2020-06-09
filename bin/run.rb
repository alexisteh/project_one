require_relative '../config/environment.rb'

$prompt = TTY::Prompt.new 

def opening_message 
    input = $prompt.yes?("Do you want to own tigers?")
    if input == true 
        pick_character_and_zoo
    else 
        puts "You were eaten by a tiger!"
        return 
    end 
end 

def pick_character_and_zoo
    choices = ["Joe Exotic", "Carole Baskin", "Doc Bhagaven Antle"]
    char_name = $prompt.select("Pick your character!", choices)
    if char_name == "Joe Exotic"
        start_money = 1200 
    elsif char_name == "Carole Baskin"
        start_money = 800 
    else start_money = 1000
    end 
    zookeeper_object = Zookeeper.create(name: char_name, alive?: true)  
    puts "Welcome," + char_name +" !" 

    zoo_name = $prompt.ask("Now, name your zoo:")
    Zoo.create(name: zoo_name, money: start_money, zookeeper_id: zookeeper_object.id)
    puts "You, #{Zookeeper.last.name}, are in charge of #{zoo_name} with starting funds of $#{start_money}!"
end 
 

def game_run_method 
    current_money = Zoo.last.money 
    current_tigers = Tiger.all.select{|tiger| tiger.zoo_id == Zoo.last.id}  
    
end 

def buy_tigers 
    choices = Tiger.all.select{|tiger| tiger.bought? == false}.map(&:name)  
    tiger_chosen = $prompt.select("Pick your tiger!", choices) 
    
    if Zoo.last.money >= Tiger.find_by(name: tiger_chosen).price 
        Tiger.find_by(name: tiger_chosen).update_attribute(:bought?, true) 
        new_tiger = Tiger.find_by(name: tiger_chosen).dup 
        new_tiger.save 
        new_tiger.update_attribute(:zoo_id, Zoo.last.id) 
        puts "Congrats, #{Zookeeper.last.name}! You just bought #{tiger_chosen}!"
        resulting_money = Zoo.last.money - Tiger.find_by(name: tiger_chosen).price
        Zoo.last.update_attribute(:money, resulting_money) 
    else 
        puts "You do not have enough money to buy this tiger!"
    end 
end 

Zookeeper.create(name: "Bob", alive?: true)
Zoo.create(name: "zoo1" , money: 1000, zookeeper_id: Zookeeper.last.id)

buy_tigers 
    
def buy_foods 
    choices = Food.all.each{ |food| food }
    food_choice = $prompt.select("Which food will you feed your tiger today?", choices)

    case food_choice 
    when "Walmart Meats"
    
    when "Organic Chicken" 
        
    when "Steak & Kidney Pie"
        
    when "Human Flesh"

    when "Beef"
    
    end 
        
    
end 

# turn_choices = ["feed tiger", "sell tiger", "showcase a tiger", "buy food"]
# turn_choice = $prompt.select("Options:", turn_choices)

# pick_character_and_zoo
