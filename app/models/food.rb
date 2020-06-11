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
    
    

end 