class CreateZoofoods < ActiveRecord::Migration[5.2]
  def change
    create_table :zoofoods do |t|
      t.integer :zoo_id 
      t.integer :food_id 
    end 
  end
end
