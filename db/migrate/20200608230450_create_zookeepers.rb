class CreateZookeepers < ActiveRecord::Migration[5.2]
  def change
    create_table :zookeepers do |t|
      t.string :name 
      t.boolean :alive 
    end 
  end
end
