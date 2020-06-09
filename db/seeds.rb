
Zookeeper.delete_all 

joe_exotic = Zookeeper.create(name: "Joe Exotic", money: 1200, alive?: true)
carole_baskins = Zookeeper.create(name: "Carole Baskin", money: 800, alive?: true)
doc_antle = Zookeeper.create(name: "Doc Bhagaven Antle", money: 1000, alive?: true)

Zoo.delete_all 

default_zoo = Zoo.create(name: "default_zoo", end_money: nil, zookeeper_id: nil) 

Tiger.delete_all 

fluffy = Tiger.create(name: "Fluffy", health: 20, time_born: nil, alive?: true)
rowdy = Tiger.create(name: "Rowdy", health: 20, time_born: nil, alive?: true)
fluffy.zoo = default_zoo
rowdy.zoo = default_zoo

