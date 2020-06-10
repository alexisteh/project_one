#zoos are individual gameplay sessions 

if Zoo.find_by(name: "blank_zoo", zookeeper_id: nil) 
    blank_zoo = Zoo.find_by(name: "blank_zoo", zookeeper_id: nil)  
else blank_zoo = Zoo.create(name: "blank_zoo", zookeeper_id: nil) 
end 

#seed blank, tigers, buyable tigers

Tiger.delete_all 

t1 = Tiger.create(name: "Fluffy", price: 500, breed: "Indian", health: 200, time_born: nil, alive: true, bought: false)
t2 = Tiger.create(name: "Rowdy", price: 200, breed: "Siberian", health: 200, time_born: nil, alive: true, bought: false)
t3 = Tiger.create(name: "Chunky", price: 350, breed: "Siberian", health: 200, time_born: nil, alive: true, bought: false)
t4 = Tiger.create(name: "Darlene", price: 250, breed: "Asian", health: 200, time_born: nil, alive: true, bought: false)
t5 = Tiger.create(name: "Christopher", price: 1000, breed: "Indonesian", health: 200, time_born: nil, alive: true, bought: false)
t6 = Tiger.create(name: "Kurt", price: 750, breed: "Indonesian", health: 200, time_born: nil, alive: true, bought: false)
t7 = Tiger.create(name: "Bon Scott", price: 100, breed: "Bengal", health: 200, time_born: nil, alive: true, bought: false)

t1.update_attribute(:zoo_id, blank_zoo.id)
t2.update_attribute(:zoo_id, blank_zoo.id)
t3.update_attribute(:zoo_id, blank_zoo.id)
t4.update_attribute(:zoo_id, blank_zoo.id)
t5.update_attribute(:zoo_id, blank_zoo.id)
t6.update_attribute(:zoo_id, blank_zoo.id)
t7.update_attribute(:zoo_id, blank_zoo.id)

#foods available  
f1 = Food.create(name: "Walmart Meats", price: 50 )
f2 = Food.create(name: "Organic Chicken", price: 200)
f3 = Food.create(name: "Steak & Kidney Pie", price: 300)
f4 = Food.create(name: "Human Flesh", price: 750)
f5 = Food.create(name: "Beef", price: 400)

#tiger1 foodprefs in food-tiger joiner pairs 
t1p1 = FoodPreference.create(tiger_id: t1.id ,food_id: f1.id)
t1p2 = FoodPreference.create(tiger_id: t1.id ,food_id: f4.id)
t1p3 = FoodPreference.create(tiger_id: t1.id ,food_id: f5.id)
#tiger2 foodprefs 
t2p1 = FoodPreference.create(tiger_id: t2.id ,food_id: f2.id)
t2p2 = FoodPreference.create(tiger_id: t2.id ,food_id: f3.id)
#tiger3 foodprefs 
t3p1 = FoodPreference.create(tiger_id: t2.id ,food_id: f2.id)
t3p2 = FoodPreference.create(tiger_id: t2.id ,food_id: f3.id)
t3p3 = FoodPreference.create(tiger_id: t2.id ,food_id: f4.id)
t3p4 = FoodPreference.create(tiger_id: t2.id ,food_id: f5.id)
#tiger4 foodprefs 
t3p1 = FoodPreference.create(tiger_id: t2.id ,food_id: f1.id)
t3p2 = FoodPreference.create(tiger_id: t2.id ,food_id: f2.id)
t3p3 = FoodPreference.create(tiger_id: t2.id ,food_id: f5.id)
#tiger5 foodprefs 
t3p1 = FoodPreference.create(tiger_id: t2.id ,food_id: f3.id)
t3p2 = FoodPreference.create(tiger_id: t2.id ,food_id: f4.id)
t3p3 = FoodPreference.create(tiger_id: t2.id ,food_id: f5.id)
#tiger6 foodprefs 
t3p1 = FoodPreference.create(tiger_id: t2.id ,food_id: f2.id)
t3p2 = FoodPreference.create(tiger_id: t2.id ,food_id: f5.id)
t3p3 = FoodPreference.create(tiger_id: t2.id ,food_id: f3.id)
#tiger7 foodprefs 
t3p1 = FoodPreference.create(tiger_id: t2.id ,food_id: f1.id)
t3p2 = FoodPreference.create(tiger_id: t2.id ,food_id: f2.id)
t3p3 = FoodPreference.create(tiger_id: t2.id ,food_id: f3.id)
t3p4 = FoodPreference.create(tiger_id: t2.id ,food_id: f4.id)



# t.string :name 
# t.integer :price 
# t.string :breed 
# t.integer :health 
# t.datetime :time_born  
# t.boolean :alive?, default: :true 
# t.integer :zoo_id 