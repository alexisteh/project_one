require_relative '../config/environment.rb'
require 'colorize'
require 'tty-prompt'
require 'pry'
require 'terminal-table'

#blank tigers before/after buying: bought = false, alive = true, time_born = nil
#living tigers in zoo: bought = true, alive = true, time_born != nil
#dead tigers in zoo: bought = true, alive = false, time_born != nil
#sold tigers: bought = false, alive = nil, time_born != nil

#things to do:
    #colorise high scores 
    #terminal table wraparound 

$prompt = TTY::Prompt.new 

def run 
    Interface.opening_message 
end 

def play_music(file)
    pid = spawn( 'afplay', file )
end 


play_music('../lib/joe-exotic.mp3')


#     input = $prompt.yes?("Do you want to own tigers?".colorize(:cyan))
#     if input == true 
#         choices = ["Start your Tiger zoo!", "View Highscores"]
#         $prompt.select("What would you like to do?".colorize(:cyan), choices) do |c| 
#             c.choice "Start your Tiger zoo!", -> {pick_character_and_zoo}
#             c.choice "View Highscores", -> {show_highscores}
#         end 
#     else 
#         puts "You were eaten by a tiger!".colorize(:red)
#         exit
#     end 
# end 

# Interface.opening_message 
# def show_highscores
#     top_games = Zoo.order(:money).last(5).reverse 
#     rows = [] 
#     top_games.each do |zoo| 
#         zookeeper_name = Zookeeper.find(zoo.zookeeper_id).name 
#         rows << [zoo.name, zookeeper_name, zoo.money] 
#     end  
#     highscores_table = Terminal::Table.new :title => "High Scores", :rows => rows
#     highscores_table.style = {:width => 200, :padding_left => 3, :border_x => "=", :border_i => "x"}
#     puts highscores_table 
#     choices = ["Play the game", "Leave the game"]
#     $prompt.select("What would you like to do next?".colorize(:cyan), choices) do |c| 
#         c.choice "Play the game", -> {pick_character_and_zoo}
#         c.choice "Leave the game", -> {exit_simple}
#     end 
# end 

# Interface.opening_message 
# def pick_character_and_zoo
#     choices = ["Joe Exotic", "Carole Baskin", "Doc Bhagaven Antle", "Jeff Lowe"]
#     char_name = $prompt.select("Pick your character!".colorize(:cyan), choices)
#     if char_name == "Joe Exotic" 
#         start_money = 1200 
#     elsif char_name == "Carole Baskin"
#         start_money = 800 
#     elsif char_name == "Doc Bhagaven Antle"
#         start_money = 1500
#     else start_money = 1000 
#     end 
#     zookeeper_object = Zookeeper.create(name: char_name, alive: true)  
#     puts "Welcome, " + char_name +" !" 

#     zoo_name = $prompt.ask("Now, name your zoo:".colorize(:cyan))
#     Zoo.create(name: zoo_name, money: start_money, zookeeper_id: zookeeper_object.id)
#     puts "You, #{Zookeeper.last.name}, are in charge of #{zoo_name} with starting funds of $#{start_money}!"
#     game_run_method
# end 

# Interface.opening_message 
# def game_run_method
#     check_tigers_over_time  
#     check_stats

#     if Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true} == [] 
#         choices =  [
#             'Buy a Tiger',
#             {name: 'Sell a Tiger', disabled: '(You do not have a tiger to sell!)'},
#             {name: 'Feed a Tiger', disabled: '(You do not have a tiger to feed!)'},
#             {name: 'Showcase a Tiger', disabled: '(You do not have a tiger to showcase!)'},
#             'Buy Food',
#             'Check on Tigers',
#             'Exit Game'
#             ]
#     else 
#         choices = [
#         'Buy a Tiger',
#         'Sell a Tiger', 
#         'Feed a Tiger',
#         'Showcase a Tiger', 
#         'Buy Food',
#         'Check on Tigers',
#         'Exit Game'
#         ] 
#     end 

#     choice = $prompt.select("What would you like to do?".colorize(:cyan) , choices) 
#     if choice == "Buy a Tiger" 
#         Tiger.buy_tiger 
#     elsif choice == "Sell a Tiger"
#         Tiger.sell_tiger 
#     elsif choice == "Feed a Tiger"
#         Tiger.feed_tiger 
#     elsif choice == "Showcase a Tiger"
#         Tiger.showcase_tiger
#     elsif choice == "Buy Food"
#         Food.buy_food
#     elsif choice == "Check on Tigers"
#         check_health  
#     elsif choice == 'Exit Game'
#         exit_game
#     end  
# end 

# Interface.opening_message 
# def check_stats 
#     current_money = Zoo.last.money 
#     current_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}.map(&:name).join(", ") 
#     dead_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == false}.map(&:name).join(", ")
#     sold_tigers = Tiger.all.select{|tiger| tiger.bought == false && tiger.zoo_id == Zoo.last.id && tiger.alive == nil}.map(&:name).join(", ")
#     unique_foods = Zoo.last.foods.map(&:name).uniq 
#     current_food_supply = unique_foods.map do |food_name| 
#         food_name + ": " + Zoo.last.foods.map(&:name).count(food_name).to_s 
#     end.join(", ")
#     rows = [] 
#     rows << ['Current Funds', current_money]
#     rows << ['Your Tigers', current_tigers] 
#     rows << ['Dead Tigers', dead_tigers]
#     rows << ['Your Food Supply', current_food_supply]
#     zoo_stats_table = Terminal::Table.new :title => "Your Zoo Stats", :rows => rows
#     zoo_stats_table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}
#     puts zoo_stats_table 
# end 

# # Interface.opening_message 
# def check_tigers_over_time
#     existing_tigers = Tiger.all.select{|t| t.bought == true && t.zoo_id == Zoo.last.id && t.alive == true}
#     if existing_tigers.length == 0 
#         return 
#     end 

#     starved_tigers = [] 
#     hungry_tigers = [] 
#     dead_tigers = [] 

#     existing_tigers.each do |tiger_object|
#         if tiger_object.time_last_fed == nil 
#             time_considered = tiger_object.time_born 
#         else time_considered = tiger_object.time_last_fed 
#         end 

#         if Time.now - time_considered > 240.0 
#             resulting_health = tiger_object.health - 20 
#             tiger_object.update_attribute(:health, resulting_health)
#             starved_tigers << tiger_object 
#         elsif Time.now - time_considered > 80.0
#             hungry_tigers << tiger_object  
#         end 
        
#         if tiger_object.health <= 0 
#             tiger_object.update_attribute(:health, 0) 
#             tiger_object.update_attribute(:alive, false)
#             dead_tigers << tiger_object  
#             hungry_tigers.delete(tiger_object) 
#             starved_tigers.delete(tiger_object) 
#         elsif tiger_object.health >= 200 
#             tiger_object.update_attribute(:health, 200)
#         end 
#     end 
    
#     if starved_tigers != []  
#         puts "Tigers are starving: #{starved_tigers.map(&:name).join(", ")}.".colorize(:red) 
#     end 
#     if hungry_tigers != []  
#         puts "Tigers are hungry: #{hungry_tigers.map(&:name).join(", ")}.".colorize(:red)
#     end 
#     if dead_tigers != []  
#         puts "Tigers have died: #{dead_tigers.map(&:name).join(", ")}.".colorize(:red) 
#     end 
# end 

# Interface.check_health 
# def check_health 

#     existing_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id} 
    
#     if existing_tigers.length == 0  
#         puts "You do not have any existing Tigers!".colorize(:red)
#         game_run_method 
#     else 
#         rows = [] 
#         existing_tigers.each do |tiger_object| 

#             if tiger_object.time_last_fed == nil 
#                 time_considered = tiger_object.time_born 
#             else time_considered = tiger_object.time_last_fed 
#             end 

#             if tiger_object.alive == false 
#                 living_status = "dead".colorize(:red)
#                 feeding_status = "–".colorize(:red)
#             else 
#                 living_status = "alive".colorize(:green)
#                 if Time.now - time_considered > 240.0 
#                     feeding_status = "Needs to be fed!".colorize(:red)
#                 elsif Time.now - time_considered > 80.0 
#                     feeding_status = "Needs to be fed soon!".colorize(:yellow)
#                 else feeding_status = "Well-nourished!".colorize(:green)
#                 end 
#             end 
#             rows << [tiger_object.name, living_status, tiger_object.health, feeding_status]  
#         end 
#         tiger_stats_table = Terminal::Table.new :title => "Your Tiger Stats".colorize(:pink), :rows => rows 
#         tiger_stats_table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}
#         puts tiger_stats_table
#         game_run_method
#     end 
# end 
 
# #helper method for buy_tiger, checks if blank tiger has been bought before 
# def tiger_allowed(tiger_object)
#     already_bought_tigers = Tiger.all.select{|tiger| tiger.time_born != nil && tiger.zoo_id == Zoo.last.id}   
#     if already_bought_tigers.find{|tiger| tiger.name == tiger_object.name} 
#         return false 
#     end 
#     return true 
# end 

# def buy_tiger 
#     all_choices = Tiger.all.select{|tiger| tiger.time_born == nil && tiger_allowed(tiger)}.map{|t| t.name + " (#{t.breed}) for $#{t.price}" } 
#     choices = all_choices.sample(6) 
#     choices << "[Go Back]" 
#     tiger_chosen = $prompt.select("Pick your tiger!".colorize(:cyan) , choices) 
#     if tiger_chosen == "[Go Back]"
#         game_run_method 
#     end 

#     new_tiger = tiger_chosen.split(" ") 
#     new_tiger.pop(3)  
#     tiger_object = Tiger.find_by(name: new_tiger.join(" ")) 

#     if Zoo.last.money >= tiger_object.price  
#         new_tiger = tiger_object.dup  #tiger instance duplicated to current zo
#         new_tiger.save 
#         new_tiger.update_attribute(:bought, true) 
#         new_tiger.update_attribute(:time_born, Time.now) #set time born to new tiger 
#         new_tiger.update_attribute(:zoo_id, Zoo.last.id) #set current zoo_id to new tiger 
#         resulting_money = Zoo.last.money - tiger_object.price  #updates zoo's money 
#         Zoo.last.update_attribute(:money, resulting_money)
#         puts "Congrats, #{Zookeeper.last.name}! You just bought #{tiger_chosen}!".colorize(:green) 
#         game_run_method 
#     else 
#         puts "You do not have enough money to buy this tiger!".colorize(:red)
#         game_run_method
#     end 
# end 

# def buy_food 
#     choices = Food.all.map{|food| food.name + " for $#{food.price}"}
#     food_choice = $prompt.select("Which food will you feed your tiger today?".colorize(:cyan), choices).split(" ")
#     food_choice.pop(2)
#     food_choice = food_choice.join(" ") 
#     price = Food.all.find_by(name: food_choice).price  

#     if Zoo.last.money >= price 
#         puts "You just bought #{food_choice}!".colorize(:green) 
#         Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.all.find_by(name: food_choice).id) #add food to zoo through joiner class
#         resulting_money = Zoo.last.money - price #update money after buying food 
#         Zoo.last.update_attribute(:money, resulting_money)
#         game_run_method 
#     else 
#         puts "You do not have enough money to buy this food product!".colorize(:red)
#         game_run_method
#     end 
# end 

# def sell_tiger 
#     available_tigers = Tiger.all.select{|tiger| (tiger.bought == true) && (tiger.zoo_id == Zoo.last.id) && (tiger.alive == true)}
#     if available_tigers.length == 0 
#         puts "You have no tigers!".colorize(:red)
#         game_run_method
#     else 
#         choices = available_tigers.map{|tiger| tiger.name + " (bought for #{tiger.price})"} 
#         choices << "[Go Back]"
#         tiger_chosen = $prompt.select("Pick a tiger to sell!".colorize(:cyan), choices).split(" ")

#         if tiger_chosen == ["[Go", "Back]"]
#             game_run_method 
#         end 

#         tiger_chosen.pop(3)
#         tiger_object = Tiger.all.find_by(name: tiger_chosen.join(" "), bought: true, zoo_id: Zoo.last.id, alive: true)
#         price = tiger_object.price 
#         health = tiger_object.health 

#         if health >= 50
#             sell_price = (price*((1+(health/200))*(1+0.5*(rand)))).to_i 
#             resulting_money = Zoo.last.money + sell_price  
#             Zoo.last.update_attribute(:money, resulting_money)
#             Zoo.last.save 
#             tiger_object.update_attribute(:bought, false) 
#             tiger_object.update_attribute(:alive, nil) 
#             puts "You just sold #{tiger_chosen.join(" ")} for #{sell_price}! Say goodbye to your tiger!".colorize(:red)
#             game_run_method 
#         elsif health <= 50
#             puts "This Tiger is too sick too sell!".colorize(:red) 
#             game_run_method
#         end 
#     end 
# end 

# def showcase_tiger 
#     available_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}
    
#     if available_tigers.length == 0
#         puts "You have no tigers!".colorize(:red)
#         game_run_method
#     else 
#         tiger_choices = available_tigers.map(&:name)  
#         tiger_chosen = $prompt.select("Pick a tiger to showcase at your local mall!".colorize(:cyan), tiger_choices) 
#         tiger_object = Tiger.all.find_by(name: tiger_chosen, zoo_id: Zoo.last.id, bought: true, alive: true)
#         health = tiger_object.health.to_f 
#         price = tiger_object.price.to_f 

#         input = $prompt.yes?("Are you sure you want to submit this tiger to torture?".colorize(:cyan))
#         if input == true
#             money_made = (price*2*(0.5+(health/400.0))).to_i  
#             resulting_money = Zoo.last.money + money_made 
#             Zoo.last.update_attribute(:money, resulting_money) 
#             updated_health = health - 50  
#             tiger_object.update_attribute(:health, updated_health)  
#             if updated_health <= 0 
#                 puts "You made #{money_made}, but #{tiger_chosen} is hurt so badly it died!".colorize(:red)
#             else puts "You made #{money_made}, but #{tiger_chosen} is traumatized! #{tiger_chosen}'s health went down to #{updated_health}.".colorize(:red)
#             end 
#             game_run_method 
#         else 
#             puts "You are very kind!".colorize(:green)
#             game_run_method
#         end
#     end
# end 

# def feed_tiger 
#     available_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}
#     available_foods = Zoo.last.foods 
#     if available_tigers.length == 0 || available_foods.length == 0 
#         if available_tigers.length == 0 && available_foods.length == 0 
#             puts "You have no tigers and no food!".colorize(:red)
#         elsif available_foods.length == 0 
#             puts "You don't have any food supplies!".colorize(:red)
#         else
#             puts "You don't have any tigers to feed!".colorize(:red)
#         end 
#         game_run_method
#     else 
#         tiger_choices = available_tigers.map(&:name)
#         tiger_choices << "[Go Back]"
        
#         tiger_chosen = $prompt.select("Choose a Tiger to feed!".colorize(:cyan), tiger_choices)
        
#         if tiger_chosen == "[Go Back]" 
#             game_run_method
#         end 
        
#         food_choices = available_foods.map(&:name).uniq 
#         food_chosen = $prompt.select("What do you want to feed your tiger?".colorize(:cyan), food_choices)  
#         tiger_object = Tiger.all.find_by(name: tiger_chosen, zoo_id: Zoo.last.id, bought: true, alive: true) 
#         tiger_object.update_attribute(:time_last_fed, Time.now) 
#         food_object = Food.all.find_by(name: food_chosen) 
#         zoofood_object = Zoofood.all.find_by(zoo_id: Zoo.last.id, food_id: food_object.id)
#         zoofood_object.update_attribute(:zoo_id, nil) 
#         puts "Chomp chomp chomp!".colorize(:green)
        
#         # Determine whether the tiger prefers the given food or not 
        
#         tied_blank_tiger = Tiger.all.find_by(name: tiger_chosen, alive: true, time_born: nil)  

#         if FoodPreference.find_by(food_id: food_object.id, tiger_id: tied_blank_tiger.id) 
#             change = 50 
#             puts "Your tiger #{tiger_chosen} is very happy!".colorize(:green)
#             color_pref = :green 
#         elsif food_chosen == "Walmart Meats"
#             change = -40 
#             puts "Your Tiger is ill! Don't feed him Walmart Meat next time!".colorize(:red)
#             color_pref = :red 
#         else 
#             change = 5 
#             puts "Your #{tiger_chosen} doesn't really enjoy that food!".colorize(:yellow)
#             color_pref = :yellow 
#         end

#         if tiger_object.health + change >= 200 
#             updated_health = 200 
#         else updated_health = tiger_object.health + change  
#         end 
#         tiger_object.update_attribute(:health, updated_health)
#         puts "Your tiger's new health is now #{updated_health}.".colorize(color_pref)
#         game_run_method 
#     end 
# end 

# def exit_game 
#     puts "Thanks for playing Tiger King!".colorize(:yellow) 
#     puts "You made $#{Zoo.last.money} in #{Zoo.last.name}. Good job!".colorize(:light_yellow)  
#     choices = ["Play again!", "Goodbye for good!"] 
#     choice = $prompt.select("Pick an option:".colorize(:cyan), choices)
#     if choice == "Play again!"
#         pick_character_and_zoo
#     else exit
#     end 
# end 

# def exit_simple 
#     puts "Bye!".colorize(:red) 
#     exit 
# end 

# f2 = Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.find_by(name: "Organic Chicken").id) 
# f3 = Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.find_by(name: "Beef").id) 
# f3 = Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.find_by(name: "Beef").id) 
# f3 = Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.find_by(name: "Walmart Meats").id) 
# turn_choices = ["feed tiger", "sell tiger", "showcase a tiger", "buy food"]
# turn_choice = $prompt.select("Options:", turn_choices)
 