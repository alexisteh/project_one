require_relative '../config/environment.rb'
require 'pry'

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
    choices = ["Joe Exotic", "Carole Baskin", "Doc Bhagaven Antle", "Jeff Lowe"]
    char_name = $prompt.select("Pick your character!", choices)
    if char_name == "Joe Exotic" 
        start_money = 1200 
    elsif char_name == "Carole Baskin"
        start_money = 800 
    elsif char_name == "Doc Bhagaven Antle"
        start_money = 1500
    else start_money = 1000 
    end 
    zookeeper_object = Zookeeper.create(name: char_name, alive: true)  
    puts "Welcome," + char_name +" !" 

    zoo_name = $prompt.ask("Now, name your zoo:")
    Zoo.create(name: zoo_name, money: start_money, zookeeper_id: zookeeper_object.id)
    puts "You, #{Zookeeper.last.name}, are in charge of #{zoo_name} with starting funds of $#{start_money}!"
end 
 

def game_run_method 
    current_money = Zoo.last.money 
    current_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}.map(&:name)  

    check_health

    current_food_supply = Zoofood.all.select{|zoo_food| zoo_food.zoo_id == Zoo.last.id} 
end 

def check_health 
    #determine who has not been fed for long enough => die
    #determine who has died (zero, negative health)
    #random illness! a tiger dies 
end 


def buy_tiger 
    #pick from unbought tigers to buy from. in each session, rake::seed clears all non-blank_zoo tigers. 
    choices = Tiger.all.select{|tiger| tiger.bought == false}.map(&:name) 
    tiger_chosen = $prompt.select("Pick your tiger!", choices) 
    tiger_object = Tiger.find_by(name: tiger_chosen)
    
    if Zoo.last.money >= tiger_object.price  
        tiger_object.update_attribute(:bought, true)  #same tiger cannot be bought again 
        new_tiger = tiger_object.dup  #tiger instance duplicated to current zo
        new_tiger.save 
        new_tiger.update_attribute(:time_born, Time.now) #set time born to new tiger 
        new_tiger.update_attribute(:zoo_id, Zoo.last.id) #set current zoo_id to new tiger 
        resulting_money = Zoo.last.money - tiger_object.price  #updates zoo's money 
        Zoo.last.update_attribute(:money, resulting_money)
        puts "Congrats, #{Zookeeper.last.name}! You just bought #{tiger_chosen}!"
        game_run_method 
    else 
        puts "You do not have enough money to buy this tiger!"
        game_run_method
    end 
end 

def buy_food 
    choices = Food.all.map{|food| food.name + " for $#{food.price}"}
    food_choice = $prompt.select("Which food will you feed your tiger today?", choices).split(" ")
    food_choice.pop(2)
    food_choice = food_choice.join(" ") 
    price = Food.all.find_by(name: food_choice).price  

    if Zoo.last.money >= price 
        puts "You just bought #{food_choice}!" 
        Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.all.find_by(name: food_choice).id) #add food to zoo through joiner class
        resulting_money = Zoo.last.money - price #update money after buying food 
        Zoo.last.update_attribute(:money, resulting_money)
        game_run_method
    else 
        puts "You do not have enough money to buy this food product!"
        game_run_method
    end 
end 


def sell_tiger 
    available_tigers = Tiger.all.select{|tiger| (tiger.bought == true) && (tiger.zoo_id == Zoo.last.id) && (tiger.alive == true)}
    choices = available_tigers.map{|tiger| tiger.name + " (bought for #{tiger.price})"} 
    tiger_chosen = $prompt.select("Pick a tiger to sell!", choices).split(" ")
    tiger_chosen.pop(3)
    tiger_object = Tiger.all.find_by(name: tiger_chosen.join(" ") )
    price = tiger_object.price 
    health = tiger_object.health 

    if health >= 50
        sell_price = (price*((1+(health/200))*(1+0.5*(rand)))).to_i 
        resulting_money = Zoo.last.money + sell_price  
        Zoo.last.update_attribute(:money, resulting_money)
        tiger_object.destroy!
        puts "You just sold #{tiger_object.name} for #{sell_price}! Say goodbye to your tiger!"
        game_run_method 
    elsif health <= 50
        puts "This Tiger is too sick too sell!"
        game_run_method
    end 
end 

sell_tiger

def showcase_tiger 
    choices = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}.map(&:name)  
    tiger_chosen = $prompt.select("Pick a tiger to showcase at your local mall!", choices) 
    health = Tiger.all.find_by(name: tiger_chosen).health 
    price = Tiger.all.find_by(name: tiger_chosen).price 

    input = $prompt.yes?("Are you sure you want to submit this tiger to torture?")
    if input == true
        updated_health = Tiger.all.find_by(name: tiger_chosen).health - 20  
        Tiger.all.find_by(name: tiger_chosen).update_attribute(:health, updated_health) 
        money_made = price*2*(0.5+(health/400)).to_i
        resulting_money = Zoo.last.money + money_made 
        Zoo.last.update_attribute(:money, resulting_money)
        puts "#{tiger_chosen} is hurt! #{tiger_chosen}'s health went down to #{updated_health}."
        game_run_method
    else 
        puts "You are very kind!"
        game_run_method
    end
end 


def feed_tiger 
    choices = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}.map(&:name)
    choose_tiger = $prompt.select("Choose a Tiger to feed!", choices)
    food_available = Zoofood.all.select{|zoo| zoo.id == Zoo.last.id}.map(&:name) 
    food_choices = food_available.uniq 
    choose_food = $prompt.select("What do you want to feed your tiger?", food_choices)  

    tiger_object = Tiger.all.find_by(name: choose_tiger) 
    food_object = Food.all.find_by(name: choose_food) 
    zoofood_object = Zoofood.all.find_by(zoo_id: Zoo.last.id, food_id: food_object.id)
    zoofood_object.update_attribute(:zoo.id, nil) 

    # Determine whether the tiger prefers the given food or not 
    
    if FoodPreference.find_by(food_id: food_object.id, tiger_id: tiger_object.id) 
        change = 20    
        puts "Your #{choose_tiger} is very happy!" 
    elsif choose_food == "Walmart Meats"
        change = -20 
        puts "Your Tiger is ill! Don't feed him Walmart Meat next time!"
    else 
        change = 5
        puts "Your #{choose_tiger} doesn't really enjoy that food!" 
    end

    updated_health = Tiger.all.find_by(name: choose_tiger).health + change  
    Tiger.all.find_by(name: choose_tiger).update_attribute(:health, updated_health)
    puts "Your tiger's new health is #{updated_health}."
    game_run_method 

end 





# turn_choices = ["feed tiger", "sell tiger", "showcase a tiger", "buy food"]
# turn_choice = $prompt.select("Options:", turn_choices)
