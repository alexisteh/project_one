class Food < ActiveRecord::Base 
    has_many :food_preferences
    has_many :tigers, through: :food_preferences

    has_many :zoofoods 
    has_many :zoos, through: :zoofoods 


    def self.buy_food 
        choices = self.all.map{|food| food.name + " for $#{food.price}"}
        food_choice = $prompt.select("Which food will you feed your tiger today?".colorize(:cyan), choices).split(" ")
        food_choice.pop(2)
        food_choice = food_choice.join(" ") 
        price = self.all.find_by(name: food_choice).price  
    
        if Zoo.last.money >= price 
            puts "You just bought #{food_choice}!".colorize(:green) 
            Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.all.find_by(name: food_choice).id) #add food to zoo through joiner class
            resulting_money = Zoo.last.money - price #update money after buying food 
            Zoo.last.update_attribute(:money, resulting_money)
            Interface.game_run_method 
        else 
            puts "You do not have enough money to buy this food product!".colorize(:red)
            Interface.game_run_method
        end 
    end 
    
    def check_stats 
        current_money = Zoo.last.money 
        current_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}.map(&:name).join(", ") 
        dead_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == false}.map(&:name).join(", ")
        sold_tigers = Tiger.all.select{|tiger| tiger.bought == false && tiger.zoo_id == Zoo.last.id && tiger.alive == nil}.map(&:name).join(", ")
        unique_foods = Zoo.last.foods.map(&:name).uniq 
        current_food_supply = unique_foods.map do |food_name| 
            food_name + ": " + Zoo.last.foods.map(&:name).count(food_name).to_s 
        end.join(", ")
        rows = [] 
        rows << ['Current Funds', current_money]
        rows << ['Your Tigers', current_tigers] 
        rows << ['Dead Tigers', dead_tigers]
        rows << ['Your Food Supply', current_food_supply]
        zoo_stats_table = Terminal::Table.new :title => "Your Zoo Stats", :rows => rows
        zoo_stats_table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}
        puts zoo_stats_table 
    end 
    
    # Interface.opening_message 
    def check_tigers_over_time
        existing_tigers = Tiger.all.select{|t| t.bought == true && t.zoo_id == Zoo.last.id && t.alive == true}
        if existing_tigers.length == 0 
            return 
        end 
    
        starved_tigers = [] 
        hungry_tigers = [] 
        dead_tigers = [] 
    
        existing_tigers.each do |tiger_object|
            if tiger_object.time_last_fed == nil 
                time_considered = tiger_object.time_born 
            else time_considered = tiger_object.time_last_fed 
            end 
    
            if Time.now - time_considered > 240.0 
                resulting_health = tiger_object.health - 20 
                tiger_object.update_attribute(:health, resulting_health)
                starved_tigers << tiger_object 
            elsif Time.now - time_considered > 80.0
                hungry_tigers << tiger_object  
            end 
            
            if tiger_object.health <= 0 
                tiger_object.update_attribute(:health, 0) 
                tiger_object.update_attribute(:alive, false)
                dead_tigers << tiger_object  
                hungry_tigers.delete(tiger_object) 
                starved_tigers.delete(tiger_object) 
            elsif tiger_object.health >= 200 
                tiger_object.update_attribute(:health, 200)
            end 
        end 
        
        if starved_tigers != []  
            puts "Tigers are starving: #{starved_tigers.map(&:name).join(", ")}.".colorize(:red) 
        end 
        if hungry_tigers != []  
            puts "Tigers are hungry: #{hungry_tigers.map(&:name).join(", ")}.".colorize(:red)
        end 
        if dead_tigers != []  
            puts "Tigers have died: #{dead_tigers.map(&:name).join(", ")}.".colorize(:red) 
        end 
    end 

end 