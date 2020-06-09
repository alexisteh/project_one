class Food < ActiveRecord::Base 
    has_many :food_preferences
    has_many :tigers, through: :food_preferences

    has_many :zoofoods 
    has_many :zoos, through: :zoofoods 

end 