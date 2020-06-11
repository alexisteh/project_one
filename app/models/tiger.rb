class Tiger < ActiveRecord::Base 
    belongs_to :zoo 

    has_many :food_preferences 
    has_many :foods, through: :food_preferences 


    def self.available_tigers 
        #helper method to give array of living, bought, tigers in zoo (for sell_tiger, showcase_tiger)
        self.all.select{|tiger| (tiger.bought == true) && (tiger.zoo_id == Zoo.last.id) && (tiger.alive == true)}
    end 

    def self.tigers_alive_in_zoo? 
        #helper method to check if there are living tigers in the zoo (for sell_tiger, showcase_tiger)
        if self.available_tigers.length == 0 
            puts "You have no tigers!".colorize(:red)
            Interface.game_run_method
        else 
            return 
        end 
    end 

    def self.tiger_allowed(tiger_object)
        #helper method to give condition if blank tiger has been bought before (for buy_tiger)
        already_bought_tigers = Tiger.all.select{|tiger| tiger.time_born != nil && tiger.zoo_id == Zoo.last.id}   
        if already_bought_tigers.find{|tiger| tiger.name == tiger_object.name} 
            return false 
        end 
        return true 
    end 

    def self.buy_tiger 
        #method for user to pick blank tiger instance to buy 
        all_choices = self.all.select{|tiger| tiger.time_born == nil && self.tiger_allowed(tiger)}.map{|t| t.name + " (#{t.breed}) for $#{t.price}" } 
        choices = all_choices.sample(6) 
        choices << "[Go Back]" 
        tiger_chosen = $prompt.select("Pick your tiger!".colorize(:cyan) , choices) 

        if tiger_chosen == "[Go Back]"
            Interface.game_run_method 
        end 

        new_tiger = tiger_chosen.split(" ")  
        new_tiger.pop(3)  
        tiger_object = self.find_by(name: new_tiger.join(" "), time_born: nil) 

        tiger_object.buy #run buy on blank tiger instance to duplicate into current zoo  
    end 

    def buy 
        #method to duplicate blank tiger instance into current zoo 
        if Zoo.last.money >= self.price  
            new_tiger = self.dup 
            new_tiger.save 
            new_tiger.update_attribute(:bought, true) 
            new_tiger.update_attribute(:time_born, Time.now) #set time born to new tiger 
            new_tiger.update_attribute(:zoo_id, Zoo.last.id) #set current zoo_id to new tiger 
            resulting_money = Zoo.last.money - self.price  
            Zoo.last.update_attribute(:money, resulting_money) #updates zoo's money 
            puts "Congrats, #{Zookeeper.last.name}! You just bought #{self.name}!".colorize(:green) 
            Interface.game_run_method 
        else 
            puts "You do not have enough money to buy this tiger!".colorize(:red)
            Interface.game_run_method
        end 
    end 


    def self.sell_tiger 
        #method for user to pick living tiger in zoo to sell 
        self.tigers_alive_in_zoo? 
        choices = self.available_tigers.map{|tiger| tiger.name + " (bought for #{tiger.price})"} 
        choices << "[Go Back]" 
        tiger_chosen = $prompt.select("Pick a tiger to sell!".colorize(:cyan), choices).split(" ")

        if tiger_chosen == ["[Go", "Back]"] 
            Interface.game_run_method 
        end 

        tiger_chosen.pop(3)
        tiger_object = self.all.find_by(name: tiger_chosen.join(" "), bought: true, zoo_id: Zoo.last.id, alive: true)
        tiger_object.sell #passes right tiger to tiger#sell 
    end 

    def sell 
        #method for user to sell living tiger in zoo 
        price = self.price 
        health = self.health 

        if health >= 50 
            sell_price = (price*((1+(health/200))*(1+0.5*(rand)))).to_i #gives random factor in sell price 
            resulting_money = Zoo.last.money + sell_price  
            Zoo.last.update_attribute(:money, resulting_money)
            Zoo.last.save 
            self.update_attribute(:bought, false) 
            self.update_attribute(:alive, nil) 
            puts "You just sold #{self.name} for #{sell_price}! Say goodbye to your tiger!".colorize(:red)
            Interface.game_run_method 
        elsif health <= 50
            puts "This Tiger is too sick too sell!".colorize(:red) 
            Interface.game_run_method
        end 
    end 


    def self.showcase_tiger 
        #method for user to pick which tiger in zoo to showcase 
        self.tigers_alive_in_zoo?
        tiger_choices = self.available_tigers.map(&:name)  
        tiger_chosen = $prompt.select("Pick a tiger to showcase at your local mall!".colorize(:cyan), tiger_choices) 
        tiger_object = self.all.find_by(name: tiger_chosen, zoo_id: Zoo.last.id, bought: true, alive: true)

        input = $prompt.yes?("Are you sure you want to submit this tiger to torture?".colorize(:cyan))
        if input == true 
            if tiger_object.health >= 30  
            tiger_object.showcase 
            else
                puts "This tiger is really sick! You can't showcase #{tiger_chosen}!".colorize(:red) 
                Interface.game_run_method  
            end 
        else 
            puts "You are very kind!".colorize(:green)
            Interface.game_run_method
        end
    end 

    def showcase 
        #method for user to showcase tiger in zoo 
        health = self.health.to_f 
        price = self.price.to_f 
        money_made = (price*2*(0.5+(health/400.0))*(0.75 + 0.25*(rand))).to_i  #provides randomness in money made
        resulting_money = Zoo.last.money + money_made 
        Zoo.last.update_attribute(:money, resulting_money)  
        updated_health = (health - (60*(0.75 + 0.25*(rand))) ).to_i  #provides randomness in health lost by tiger 
        self.update_attribute(:health, updated_health) 
        if updated_health <= 0 
            puts "You made #{money_made}, but #{self.name} was hurt so badly it died!".colorize(:red)
        else puts "You made #{money_made}, but #{self.name} is traumatized! #{self.name}'s health went down to #{updated_health}.".colorize(:red)
        end 
        Interface.game_run_method 
    end 

    def self.feed_tiger 
        #method for choosing tiger and food 
        available_foods = Zoo.last.foods 
        if self.available_tigers.length == 0 || available_foods.length == 0 
            if self.available_tigers.length == 0 && available_foods.length == 0 
                puts "You have no tigers and no food!".colorize(:red)
            elsif available_foods.length == 0 
                puts "You don't have any food supplies!".colorize(:red)
            else
                puts "You don't have any tigers to feed!".colorize(:red)
            end 
            Interface.game_run_method
        else 
            tiger_choices = self.available_tigers.map(&:name)
            tiger_choices << "[Go Back]"
            tiger_chosen = $prompt.select("Choose a Tiger to feed!".colorize(:cyan), tiger_choices)
            
            if tiger_chosen == "[Go Back]" 
                Interface.game_run_method
            end 
            food_choices = available_foods.map(&:name).uniq 
            food_chosen = $prompt.select("What do you want to feed your tiger?".colorize(:cyan), food_choices) 
            food_object = Food.all.find_by(name: food_chosen) 
            tiger_object = self.all.find_by(name: tiger_chosen, zoo_id: Zoo.last.id, bought: true, alive: true)
            tiger_object.feed(food_object) 
        end 
    end 

    def feed(food_object)
        #method for feeding tiger with food 
        self.update_attribute(:time_last_fed, Time.now) 
        zoofood_object = Zoofood.all.find_by(zoo_id: Zoo.last.id, food_id: food_object.id)
        zoofood_object.update_attribute(:zoo_id, nil) #remove used-up food from zoo inventory 
        puts "Chomp chomp chomp!".colorize(:green)
        
        #determine whether the tiger prefers the given food or not 
        tied_blank_tiger = self.class.all.find_by(name: self.name, alive: true, time_born: nil)  
        
        if FoodPreference.find_by(food_id: food_object.id, tiger_id: tied_blank_tiger.id) 
            change = 50 
            puts "Your tiger #{self.name} is very happy!".colorize(:green)
            color_pref = :green 
        elsif food_object.name == "Walmart Meats" 
            change = -40 
            puts "Your Tiger is ill! Don't feed him Walmart Meat next time!".colorize(:red)
            color_pref = :red 
        else 
            change = 5 
            puts "Your tiger #{self.name} doesn't really enjoy that food!".colorize(:yellow)
            color_pref = :yellow 
        end

        if self.health + change >= 200 
            updated_health = 200 
        elsif self.health + change <= 0 
            updated_health = 0 
        else updated_health = self.health + change  
        end 
        self.update_attribute(:health, updated_health) 
        puts "Your tiger's new health is now #{updated_health}.".colorize(color_pref)
        if updated_health == 0 
            puts "Your tiger #{self.name} died of food poisoning!".colorize(:red) 
        end 
        Interface.game_run_method 
    end 

end 