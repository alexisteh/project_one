#zoos are individual gameplay sessions 

if Zoo.find_by(name: "blank_zoo", zookeeper_id: nil) 
    blank_zoo = Zoo.find_by(name: "blank_zoo", zookeeper_id: nil, money: nil)  
else blank_zoo = Zoo.create(name: "blank_zoo", zookeeper_id: nil, money: nil) 
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
t8 = Tiger.create(name: "Mr. Sandman", price: 300, breed: "Indian", health: 200, time_born: nil, alive: true, bought: false)
t9 = Tiger.create(name: "Arthur Pendragon", price: 100, breed: "Bengal", health: 200, time_born: nil, alive: true, bought: false)
t10 = Tiger.create(name: "Belial", price: 100, breed: "Siberian", health: 200, time_born: nil, alive: true, bought: false)
t11 = Tiger.create(name: "Francis", price: 500, breed: "Indian", health: 200, time_born: nil, alive: true, bought: false)
t12 = Tiger.create(name: "Ian", price: 500, breed: "Asian", health: 200, time_born: nil, alive: true, bought: false)
t13 = Tiger.create(name: "Fergie", price: 250, breed: "Bengal", health: 200, time_born: nil, alive: true, bought: false)
t14 = Tiger.create(name: "Jason", price: 1000, breed: "Asian", health: 200, time_born: nil, alive: true, bought: false)
t15 = Tiger.create(name: "Floyd", price: 10000, breed: "Pink", health: 200, time_born: nil, alive: true, bought: false)

t1.update_attribute(:zoo_id, blank_zoo.id)
t2.update_attribute(:zoo_id, blank_zoo.id)
t3.update_attribute(:zoo_id, blank_zoo.id)
t4.update_attribute(:zoo_id, blank_zoo.id)
t5.update_attribute(:zoo_id, blank_zoo.id)
t6.update_attribute(:zoo_id, blank_zoo.id)
t7.update_attribute(:zoo_id, blank_zoo.id)
t8.update_attribute(:zoo_id, blank_zoo.id)
t9.update_attribute(:zoo_id, blank_zoo.id)
t10.update_attribute(:zoo_id, blank_zoo.id)
t11.update_attribute(:zoo_id, blank_zoo.id)
t12.update_attribute(:zoo_id, blank_zoo.id)
t13.update_attribute(:zoo_id, blank_zoo.id)
t14.update_attribute(:zoo_id, blank_zoo.id)
t15.update_attribute(:zoo_id, blank_zoo.id)


#foods available  
Food.delete_all 

f1 = Food.create(name: "Walmart Meats", price: 50)
f2 = Food.create(name: "Organic Chicken", price: 100)
f3 = Food.create(name: "Steak & Kidney Pie", price: 200)
f4 = Food.create(name: "Human Flesh", price: 750)
f5 = Food.create(name: "Beef", price: 200)

FoodPreference.delete_all 

#tiger1 foodprefs in food-tiger joiner pairs 
t1p1 = FoodPreference.create(tiger_id: t1.id ,food_id: f1.id)
t1p2 = FoodPreference.create(tiger_id: t1.id ,food_id: f4.id)
t1p3 = FoodPreference.create(tiger_id: t1.id ,food_id: f5.id)
#tiger2 foodprefs 
t2p1 = FoodPreference.create(tiger_id: t2.id ,food_id: f2.id)
t2p2 = FoodPreference.create(tiger_id: t2.id ,food_id: f3.id)
#tiger3 foodprefs 
t3p1 = FoodPreference.create(tiger_id: t3.id ,food_id: f2.id)
t3p2 = FoodPreference.create(tiger_id: t3.id ,food_id: f3.id)
t3p3 = FoodPreference.create(tiger_id: t3.id ,food_id: f4.id)
t3p4 = FoodPreference.create(tiger_id: t3.id ,food_id: f5.id)
#tiger4 foodprefs 
t4p1 = FoodPreference.create(tiger_id: t4.id ,food_id: f1.id)
t4p2 = FoodPreference.create(tiger_id: t4.id ,food_id: f2.id)
t4p3 = FoodPreference.create(tiger_id: t4.id ,food_id: f5.id)
#tiger5 foodprefs 
t5p1 = FoodPreference.create(tiger_id: t5.id ,food_id: f3.id)
t5p2 = FoodPreference.create(tiger_id: t5.id ,food_id: f4.id)
t5p3 = FoodPreference.create(tiger_id: t5.id ,food_id: f5.id)
#tiger6 foodprefs 
t6p1 = FoodPreference.create(tiger_id: t6.id ,food_id: f2.id)
t6p2 = FoodPreference.create(tiger_id: t6.id ,food_id: f5.id)
t6p3 = FoodPreference.create(tiger_id: t6.id ,food_id: f3.id)
#tiger7 foodprefs 
t7p1 = FoodPreference.create(tiger_id: t7.id ,food_id: f1.id)
t7p2 = FoodPreference.create(tiger_id: t7.id ,food_id: f2.id)
#tiger8 foodprefs
t8p3 = FoodPreference.create(tiger_id: t8.id ,food_id: f5.id)
t8p4 = FoodPreference.create(tiger_id: t8.id ,food_id: f4.id)
# tiger9 foodprefs
t9p3 = FoodPreference.create(tiger_id: t9.id ,food_id: f3.id)
t9p4 = FoodPreference.create(tiger_id: t9.id ,food_id: f4.id)
# tiger10 foodprefs
t10p1 = FoodPreference.create(tiger_id: t10.id ,food_id: f1.id)
# tiger11 foodprefs
t11p1 = FoodPreference.create(tiger_id: t11.id ,food_id: f3.id)
# tiger12 foodprefs
t12p1 = FoodPreference.create(tiger_id: t12.id ,food_id: f1.id)
t12p4 = FoodPreference.create(tiger_id: t12.id ,food_id: f4.id)
# tiger13 foodprefs
t13p1 = FoodPreference.create(tiger_id: t13.id ,food_id: f1.id)
t13p4 = FoodPreference.create(tiger_id: t13.id ,food_id: f4.id)
t13p4 = FoodPreference.create(tiger_id: t13.id ,food_id: f2.id)
# tiger14 foodprefs
t14p1 = FoodPreference.create(tiger_id: t14.id ,food_id: f1.id)
t14p4 = FoodPreference.create(tiger_id: t14.id ,food_id: f4.id)
# tiger 15 foodprefs
t15p1 = FoodPreference.create(tiger_id: t15.id ,food_id: f3.id)
t15p4 = FoodPreference.create(tiger_id: t13.id ,food_id: f5.id)

# t.string :name 
# t.integer :price 
# t.string :breed 
# t.integer :health 
# t.datetime :time_born  
# t.boolean :alive?, default: :true 
# t.integer :zoo_id 