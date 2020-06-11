class Tiger < ActiveRecord::Base 
    belongs_to :zoo 

    has_many :food_preferences 
    has_many :foods, through: :food_preferences 


    #helper method for buy_tiger, checks if blank tiger has been bought before 
    def self.tiger_allowed(tiger_object)
        already_bought_tigers = Tiger.all.select{|tiger| tiger.time_born != nil && tiger.zoo_id == Zoo.last.id}   
        if already_bought_tigers.find{|tiger| tiger.name == tiger_object.name} 
            return false 
        end 
        return true 
    end 

    def self.buy_tiger 
        all_choices = self.all.select{|tiger| tiger.time_born == nil && self.tiger_allowed(tiger)}.map{|t| t.name + " (#{t.breed}) for $#{t.price}" } 
        choices = all_choices.sample(6) 
        choices << "[Go Back]" 
        tiger_chosen = $prompt.select("Pick your tiger!".colorize(:cyan) , choices) 
        if tiger_chosen == "[Go Back]"
            Interface.game_run_method 
        end 

        new_tiger = tiger_chosen.split(" ") 
        new_tiger.pop(3)  
        tiger_object = self.find_by(name: new_tiger.join(" ")) 

        if Zoo.last.money >= tiger_object.price  
            new_tiger = tiger_object.dup  #tiger instance duplicated to current zo
            new_tiger.save 
            new_tiger.update_attribute(:bought, true) 
            new_tiger.update_attribute(:time_born, Time.now) #set time born to new tiger 
            new_tiger.update_attribute(:zoo_id, Zoo.last.id) #set current zoo_id to new tiger 
            resulting_money = Zoo.last.money - tiger_object.price  #updates zoo's money 
            Zoo.last.update_attribute(:money, resulting_money)
            puts "Congrats, #{Zookeeper.last.name}! You just bought #{tiger_chosen}!".colorize(:green) 
            Interface.game_run_method 
        else 
            puts "You do not have enough money to buy this tiger!".colorize(:red)
            Interface.game_run_method
        end 
    end 


    def self.sell_tiger 
        available_tigers = self.all.select{|tiger| (tiger.bought == true) && (tiger.zoo_id == Zoo.last.id) && (tiger.alive == true)}
        if available_tigers.length == 0 
            puts "You have no tigers!".colorize(:red)
            Interface.game_run_method
        else 
            choices = available_tigers.map{|tiger| tiger.name + " (bought for #{tiger.price})"} 
            choices << "[Go Back]"
            tiger_chosen = $prompt.select("Pick a tiger to sell!".colorize(:cyan), choices).split(" ")

            if tiger_chosen == ["[Go", "Back]"]
                Interface.game_run_method 
            end 

            tiger_chosen.pop(3)
            tiger_object = self.all.find_by(name: tiger_chosen.join(" "), bought: true, zoo_id: Zoo.last.id, alive: true)
            price = tiger_object.price 
            health = tiger_object.health 

            if health >= 50
                sell_price = (price*((1+(health/200))*(1+0.5*(rand)))).to_i 
                resulting_money = Zoo.last.money + sell_price  
                Zoo.last.update_attribute(:money, resulting_money)
                Zoo.last.save 
                tiger_object.update_attribute(:bought, false) 
                tiger_object.update_attribute(:alive, nil) 
                puts "You just sold #{tiger_chosen.join(" ")} for #{sell_price}! Say goodbye to your tiger!".colorize(:red)
                Interface.game_run_method 
            elsif health <= 50
                puts "This Tiger is too sick too sell!".colorize(:red) 
                Interface.game_run_method
            end 
        end 
    end 


    def self.showcase_tiger 
        available_tigers = self.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}
        
        if available_tigers.length == 0
            puts "You have no tigers!".colorize(:red)
            Interface.game_run_method
        else 
            tiger_choices = available_tigers.map(&:name)  
            tiger_chosen = $prompt.select("Pick a tiger to showcase at your local mall!".colorize(:cyan), tiger_choices) 
            tiger_object = self.all.find_by(name: tiger_chosen, zoo_id: Zoo.last.id, bought: true, alive: true)
            health = tiger_object.health.to_f 
            price = tiger_object.price.to_f 

            input = $prompt.yes?("Are you sure you want to submit this tiger to torture?".colorize(:cyan))
            if input == true
                money_made = (price*2*(0.5+(health/400.0))).to_i  
                resulting_money = Zoo.last.money + money_made 
                Zoo.last.update_attribute(:money, resulting_money) 
                updated_health = health - 50  
                tiger_object.update_attribute(:health, updated_health)  
                if updated_health <= 0 
                    puts "You made #{money_made}, but #{tiger_chosen} is hurt so badly it died!".colorize(:red)
                else puts "You made #{money_made}, but #{tiger_chosen} is traumatized! #{tiger_chosen}'s health went down to #{updated_health}.".colorize(:red)
                end 
                Interface.game_run_method 
            else 
                puts "You are very kind!".colorize(:green)
                Interface.game_run_method
            end
        end
    end 

    def self.feed_tiger 
        available_tigers = self.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}
        available_foods = Zoo.last.foods 
        if available_tigers.length == 0 || available_foods.length == 0 
            if available_tigers.length == 0 && available_foods.length == 0 
                puts "You have no tigers and no food!".colorize(:red)
            elsif available_foods.length == 0 
                puts "You don't have any food supplies!".colorize(:red)
            else
                puts "You don't have any tigers to feed!".colorize(:red)
            end 
            Interface.game_run_method
        else 
            tiger_choices = available_tigers.map(&:name)
            tiger_choices << "[Go Back]"
            
            tiger_chosen = $prompt.select("Choose a Tiger to feed!".colorize(:cyan), tiger_choices)
            
            if tiger_chosen == "[Go Back]" 
                Interface.game_run_method
            end 
            
            food_choices = available_foods.map(&:name).uniq 
            food_chosen = $prompt.select("What do you want to feed your tiger?".colorize(:cyan), food_choices)  
            tiger_object = self.all.find_by(name: tiger_chosen, zoo_id: Zoo.last.id, bought: true, alive: true) 
            tiger_object.update_attribute(:time_last_fed, Time.now) 
            food_object = Food.all.find_by(name: food_chosen) 
            zoofood_object = Zoofood.all.find_by(zoo_id: Zoo.last.id, food_id: food_object.id)
            zoofood_object.update_attribute(:zoo_id, nil) 
            puts "Chomp chomp chomp!".colorize(:green)
            
            # Determine whether the tiger prefers the given food or not 
            
            tied_blank_tiger = self.all.find_by(name: tiger_chosen, alive: true, time_born: nil)  
    
            if FoodPreference.find_by(food_id: food_object.id, tiger_id: tied_blank_tiger.id) 
                change = 50 
                puts "Your tiger #{tiger_chosen} is very happy!".colorize(:green)
                color_pref = :green 
            elsif food_chosen == "Walmart Meats"
                change = -40 
                puts "Your Tiger is ill! Don't feed him Walmart Meat next time!".colorize(:red)
                color_pref = :red 
            else 
                change = 5 
                puts "Your #{tiger_chosen} doesn't really enjoy that food!".colorize(:yellow)
                color_pref = :yellow 
            end
    
            if tiger_object.health + change >= 200 
                updated_health = 200 
            else updated_health = tiger_object.health + change  
            end 
            tiger_object.update_attribute(:health, updated_health)
            puts "Your tiger's new health is now #{updated_health}.".colorize(color_pref)
            Interface.game_run_method 
        end 
    end 
end 
