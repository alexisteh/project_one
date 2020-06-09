class Zoo < ActiveRecord::Base 
    belongs_to :zookeeper 

    has_many :tigers 

    has_many :zoofoods 
    has_many :foods, through: :zoofoods
end 