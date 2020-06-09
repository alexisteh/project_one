class CreateTigers < ActiveRecord::Migration[5.2]
  def change
    create_table :tigers do |t|
      t.string :name 
      t.integer :price 
      t.string :breed 
      t.integer :health 
      t.datetime :time_born  
      t.boolean :alive?, default: :true 
      t.boolean :bought?, default: :false 
      t.integer :zoo_id 
    end 
  end
end
