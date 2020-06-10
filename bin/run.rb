require_relative '../config/environment.rb'
require 'pry'

$prompt = TTY::Prompt.new 

def opening_image 
    puts <<-'EOF'
    ---------::::------  --::--:-:`    -+sssyyys:`    :/://:-://::::/+.  `+/++++oooooo+:                  .:///////`:++/+ooo+..--:--:---  ...------`.-:-----.    ./sssyyys/`                 
    /MMMMMMMMMMMMMMMMMMN` oMNmMNNMd.  /dNdy:yyoshNNo   :NMNMMMmNMMNmNMMh   /MMMNNMNMMNNMMNo`               .mMNmNMMo -mMNNmMN/ .dMmMNNMMs .dMNmMMMMd`/MNNNNMm.  :dNdy/sysohmNo`               
    /MNNNMNMMMMMMMNMMMMN`  hMymMMM.  -MNymhsmNdhs/oMs   yMNMNNMMMNNmNNMh    dMdmmmmNmNMMMNMy                oMNdNMN`  dMmMMM/   .MNyMMMh   .MNmNmmMo  dMNNNM:  .MNymhomNmhs/+My               
    /MMMMMNMMmNMMMmMMNMN`  yMmMMmN   hMmNmMMysNNmhdMN`  sMMMMMNyyyNNhhMh    hMmddMmyhMNhNmMy`               +MmyMMm` /MNNMNs    `NNNMNNo   `MNNmddMd  hMNmNM-  yMmNmMMysmNmhdMN`              
    /MNMMo`MMMMMMh dMMMN`  +MMNNMm   mMhhmMy  oMhhmMh   sMmNdNm   dMNMMd    dNddhMy  /MMMMMM.               +MddNMN` mMmMMN.     dMNNNMo   `MmmdddMM- hMmNNM.  dMdydMh  /MhhdNm               
    +MMMMo`MMMMMMh dMMNN`  oMNMNMN   mMmNNMs  +Ms`.Nd   sMMMMMm   mMmmMd    dMmhNMy  -MMNMMM.               sMNNNMN`+MNNNMs      mMNMNMo   `MNNmddmMh dMymmM-  dMmNmMy  :My`.mm               
    +MMMM+`MMMMNMy mMNMN`  oMMMMMN   NNNNmMs  /MNsyMd   sMMNmMN   mMMMMm    hMhdhMy  :MMNMMM.               sMNdNMN`mMMNMd`      mMMMMMs   `MmmmddmNM.hMddmM:  dNNNmMy  -MNsyNm               
    +MMNM/`MMNMNMy mMMMN`  oMMMNMN`  NNNNMMs  oMNNmMy   sMmNdmN   mMMNMh    hMmNmMh  -MMdmNM-               +MNmmMN/MMMMN`       mMMMMMs   `MMNNdmdmMoyMmNmM-  dNNNMMy  +MNNmMd               
    oMMMM+`MMmNMMs NMmMm`  oMNMNMN   mMNmMMo  .sdMMMh   sMNNNMd   `:smmh    hMMmMMd  -MmNNNM:               oMMMNMMMMMMMo        mMNMmMo    MMMMMMMMMNmMNMNM:  hMNmMMs  `odNMMd               
    oMMMM/`MNmhNMs mMMMN`  +MMNMMN   NMMMMMo `   `/yo   sMMMMMh    :- -:    hMMMMMh  :MNMMMM.               oMMmMMMMMNMMo        dMMNMMo   `MMMNMNMNdNMMNMMM:  dMMMMMs `   `/yy               
    oMNy- `MMNNmMs .+hNm   +MMMMMN   NMMMMMo omo-       sMMNMMMddmNMo       hMmmMMd+omNNNMMd                oMmNNNMMNNMMm`       dMMMMMo   `MMNNNMNMNNMMNNMM:  dMMMMMs +ms:`                  
     `    `MNdddMs     -   oMMNmMm   MMMMMM+  hMMNs:    sMNMMMMNMNMMo       dMmmmmNMNNMhNm/`                sMNmNMMMNMmMM:       mMNNNMo    MMMNmysho--:mmMM-  mMMMMMo  yMMNy:`               
          .MMNmmMs         oMMNdMm  `MMMMMMo  sMMMmMNo  yMmNNMNddmNMo       hMNNNNMMNMNmMMy.                sMNNmNMMMNMMMs       mMNNmMo    MMMMMddMNNNNNNMM- `NMMMMMs  oMMMmMNs              
          .MNmNNMs         oMMMNMd   MMNNMMo  sMMMMMN.  yMNNMMd    .- /s`   hMdhmMh-:dMdNMMd                oMNNNNNNNNNmMm       mMNMMM+   `MMNMMhsMMNNMNNMM.  mMNNMMs  +MMNMMM-              
          .MNdmNMo         oMMMNMm  `MMNNNMs  oMMNNNN`  yMNNNMm    :sNMM`   dMNmMMh  :MNmdMm`               sMMMNNMMNMNNMM:      mMMMNM+   .MMMMMd.MMNNmdmMN.  mMNNNMy  +MMNMNN`              
          .MMdNMM+         +MdMNMm   MMdNmMs  oMMNmMN   yMhdNMh   dMMNMM`   dMNmNMh  /MmmmMm                sMMMMMMMNNNMMMy      dNdMNM+   .MMNMMh`mMNmNmNNN`  mMmNmMy  +MMMmNN`              
          .MNmNmM+         +MMNNMm   MMmNmMs  oMMNMMm   yMMNhMh   mMMMMM`   hMddNMy  :MNNMMm                oMMmNMMhsMNNMMN`     dMMNNM+   .MNMmMh yMdmmmNMN`  mMmNmMy  +MMNMMN               
          -MNMmmMo         +MMdmMm  `MMmNNMs  sMNMNMm   yMNmmMh   mMmMMM`   dMMNmMh  /MNMNNm`               sMMdsNm`.MNMMMM/     dMMhMMo   `MNNdMh -Ms://smN` `NMmNNMs  +MNMNMN               
          -MNNNMMo         sMNNmMd  .MMMNNMs  sMNNNMm   yMMMMNd   mMmMMM`   dNdhNMy  :MmmmNm`               oMNddMd  dMMMMMy    `mMMNmM+   `MNmMMh `Nd/:-+NN` `NMMNNMy  oMNNNMN               
          :MMdNMMo         oMMNNMd  `MNmNNMd..dMNmMNm   yMMmNMh   NMmmNM.   dMNdMMs  /MhhdMN`               sMMNMMm  +MMMMMN`    mMMmMM+   .MMmmMh  hMmmmNMm  `NNmNNNd..dMNmMNN               
          :MNNdNMo         yMMNMMN   mMNNmmNMMNmmmMMm   hMmymMNsyyMNNMMM.   dNdmNMy  /MhdmMN`               sMNmNMN` .MMNmMM/   `MMMNMMo   .MMmNMh  +MNdmNMm   dMNNmmNMMMmmmMMN               
          oMNmhNM+         hMMNNMN`  /MMNNddmhdNmMNMm   dMdNmmmmdNNdNmMM.   dNhmmMs  +MmmNMm`               yMyddNM. `NMNNNMd   .MMMNNMs   :MMmNMd  :MMmNmNN`  -NMNNmdmhdNmMNMN               
         :mMMNNMMo`       -NMNMNNMo   -smMNMNmMMMMyNd  /MNNNNNNNMNMNNNNM`  /MMNNNMm.`dMMNmNMo`             .mMNMmMMs `mMMNMMMo  oMNMMmMN- `dMMNMMM: +MmmNmNMo   .smNNMNNMMMMhmm               
         +ssooooos/       /++oooo++.     `.........`` `+ooo++++oooo+++++   ////////-.///:::::`             +ooosoooo./ooo+++++.`+++ooo++/  ://////:`///:::---      `.........``            
    EOF
end 

def opening_message 
    input = $prompt.yes?("Do you want to own tigers?")
    if input == true 
        pick_character_and_zoo
    else 
        puts "You were eaten by a tiger!"
        return 
    end 
end 

def pick_character_and_zoo
    choices = ["Joe Exotic", "Carole Baskin", "Doc Bhagaven Antle", "Jeff Lowe"]
    char_name = $prompt.select("Pick your character!", choices)
    if char_name == "Joe Exotic"
        start_money = 1200 
    elsif char_name == "Carole Baskin"
        start_money = 800 
    elsif char_name == "Doc Bhagaven Antle"
        start_money = 1500
    else start_money = 1000
    end 
    zookeeper_object = Zookeeper.create(name: char_name, alive?: true)  
    puts "Welcome," + char_name +" !" 

    zoo_name = $prompt.ask("Now, name your zoo:")
    Zoo.create(name: zoo_name, money: start_money, zookeeper_id: zookeeper_object.id)
    puts "You, #{Zookeeper.last.name}, are in charge of #{zoo_name} with starting funds of $#{start_money}!"
end 
 

def game_run_method 
    current_money = Zoo.last.money 
    current_tigers = Tiger.all.select{|tiger| tiger.bought? == true && tiger.zoo_id == Zoo.last.id && tiger.alive? == true}.map(&:name)  

    def check_health 
    end 

    current_food_supply = Zoo_food.all.select{|zoo_food| zoo_food.zoo_id == Zoo.last.id} 
end 

def check_health 
    #determine who has not been fed for long enough => die
    #determine who has died (zero, negative health)
    #random illness! a tiger dies 
end 


def buy_tiger 
    choices = Tiger.all.select{|tiger| tiger.bought? == false}.map(&:name) 
    tiger_chosen = $prompt.select("Pick your tiger!", choices) 
    
    if Zoo.last.money >= Tiger.find_by(name: tiger_chosen).price 
        Tiger.find_by(name: tiger_chosen).update_attribute(:bought?, true) 
        new_tiger = Tiger.find_by(name: tiger_chosen).dup 
        new_tiger.save 
        new_tiger.update_attribute(:zoo_id, Zoo.last.id) 
        puts "Congrats, #{Zookeeper.last.name}! You just bought #{tiger_chosen}!"
        resulting_money = Zoo.last.money - Tiger.find_by(name: tiger_chosen).price
        Zoo.last.update_attribute(:money, resulting_money)
        game_run_method
    else 
        puts "You do not have enough money to buy this tiger!"
        game_run_method
    end 
end 


def buy_food 
    choices = Food.all.map{ |food| food.name }
    food_choice = $prompt.select("Which food will you feed your tiger today?", choices)
    price = Food.all.find_by(name: food_choice).price 
    food_final = Food.all.find_by(name: food_choice)

    if Zoo.last.money >= price 
        puts "You just bought #{food_choice}!" 
        Zoofood.create(zoo_id: Zoo.last.id, food_id: food_final.id) 
        resulting_money = Zoo.last.money - price 
        Zoo.last.update_attribute(:money, resulting_money)
        game_run_method
    else 
        puts "You do not have enough money to buy this food product!"
        game_run_method
    end 
end 


def sell_tiger 
    choices = Tiger.all.select{|tiger| (tiger.bought? == true) && (tiger.zoo_id == Zoo.last.id) && (tiger.alive? == true)}.map(&:name)  
    tiger_chosen = $prompt.select("Pick a tiger to sell!", choices) 
    price = Tiger.all.find_by(name: tiger_chosen).price 
    health = Tiger.all.find_by(name: tiger_chosen).health 

    if health >= 50 
        puts "You just sold #{tiger_chosen}! Say goodbye to your tiger!"
        sell_price = (price*((1+(health/200))*(1+0.5*(rand)))).to_i 
        resulting_money = Zoo.last.money + sell_price  
        Zoo.last.update_attribute(:money, resulting_money)
        Tiger.all.find_by(name: tiger_chosen).update_attribute(:alive?, nil) 
        game_run_method 
    elsif health <= 50 
        puts "This Tiger is too sick too sell!"
        game_run_method
    end 
end 

def showcase_tiger 
    choices = Tiger.all.select{|tiger| tiger.bought? == true && tiger.zoo_id == Zoo.last.id && tiger.alive? == true}.map(&:name)  
    tiger_chosen = $prompt.select("Pick a tiger to showcase at your local mall!", choices) 
    health = Tiger.all.find_by(name: tiger_chosen).health 
    price = Tiger.all.find_by(name: tiger_chosen).price 

    input = $prompt.yes?("Are you sure you want to submit this tiger to torture?")
    if input == true
        updated_health = Tiger.all.find_by(name: tiger_chosen).health - 20  
        Tiger.all.find_by(name: tiger_chosen).update_attribute(:health, updated_health) 
        money_made = price*2*(0.5+(health/400)).to_i
        resulting_money = Zoo.last.money + money_made 
        Zoo.last.update_attribute(:money, resulting_money)
        puts "#{tiger_chosen} is hurt! #{tiger_chosen}'s health went down to #{updated_health}."
        game_run_method
    else 
        puts "You are very kind!"
        game_run_method
    end
end 


def feed_tiger 
    choices = Tiger.all.select{|tiger| tiger.bought? == true && tiger.zoo_id == Zoo.last.id && tiger.alive? == true}.map(&:name)
    choose_tiger = $prompt.select("Choose a Tiger to feed!", choices)
    food_available = Zoofood.all.select{|zoo| zoo.id == Zoo.last.id}.map(&:name) 
    food_choices = food_available.uniq 
    choose_food = $prompt.select("What do you want to feed your tiger?", food_choices)  

    tiger_object = Tiger.all.find_by(name: choose_tiger) 
    food_object = Food.all.find_by(name: choose_food) 
    zoofood_object = Zoofood.all.find_by(zoo_id: Zoo.last.id, food_id: food_object.id)
    zoofood_object.update_attribute(:zoo.id, nil) 

    # Determine whether the tiger prefers the given food or not 
    
    if FoodPreference.find_by(food_id: food_object.id, tiger_id: tiger_object.id) 
        change = 20    
        puts "Your #{choose_tiger} is very happy!" 
    elsif choose_food == "Walmart Meats"
        change = -20 
        puts "Your Tiger is ill! Don't feed him Walmart Meat next time!"
    else 
        change = 5
        puts "Your #{choose_tiger} doesn't really enjoy that food!" 
    end

    updated_health = Tiger.all.find_by(name: choose_tiger).health + change  
    Tiger.all.find_by(name: choose_tiger).update_attribute(:health, updated_health)
    puts "Your tiger's new health is #{updated_health}."
    game_run_method 

end 


Zookeeper.create(name: "Bob", alive?: true)
z1 = Zoo.create(name: "zoo1" , money: 1000, zookeeper_id: Zookeeper.last.id)
t1 = Tiger.create(name: "Hello", zoo_id: z1.id, bought?: true, alive?: true, health: 100, price: 1000) 
t2 = Tiger.create(name: "Bye", zoo_id: z1.id, bought?: true, alive?: true, health: 200, price: 300) 
showcase_tiger 

# turn_choices = ["feed tiger", "sell tiger", "showcase a tiger", "buy food"]
# turn_choice = $prompt.select("Options:", turn_choices)
