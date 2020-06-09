Zoo.delete_all 

blank_zoo = Zoo.create(name: "default_zoo", end_money: nil, zookeeper_id: nil) 

Tiger.delete_all 

fluffy = Tiger.create(name: "Fluffy", health: 20, time_born: nil, alive?: true)
rowdy = Tiger.create(name: "Rowdy", health: 20, time_born: nil, alive?: true)
fluffy.zoo = blank_zoo
rowdy.zoo = blank_zoo

