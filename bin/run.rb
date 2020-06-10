require_relative '../config/environment.rb'
require 'pry'

#blank tigers before buying: bought = false, alive = true, time_born = nil
#blank tigers after buying: bought = true, alive = true, time_born = nil  
#living tigers in zoo: bought = true, alive = true, time_born != nil
#dead tigers in zoo: bought = true, alive = false, time_born != nil
#sold tigers: bought = false, alive = nil, time_born != nil

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
    zookeeper_object = Zookeeper.create(name: char_name, alive: true)  
    puts "Welcome," + char_name +" !" 

    zoo_name = $prompt.ask("Now, name your zoo:")
    Zoo.create(name: zoo_name, money: start_money, zookeeper_id: zookeeper_object.id)
    puts "You, #{Zookeeper.last.name}, are in charge of #{zoo_name} with starting funds of $#{start_money}!"
end 

def game_run_method 
    current_money = Zoo.last.money 
    current_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}.map(&:name)  

    check_health
    current_food_supply = Zoofood.all.select{|zoo_food| zoo_food.zoo_id == Zoo.last.id} 
    
    $prompt.select("What would you like to do next?", filter: true) do |c|
        c.choice 'Feed your tiger', -> {feed_tiger}
        c.choice 'Buy a Tiger', -> {buy_tiger}
        c.choice 'Sell a Tiger', -> {sell_tiger}
        c.choice 'Buy Food', -> {buy_food}
        c.choice 'See your current stats', -> {check_stats}
    end
end 

def check_health 
    #determine who has not been fed for long enough => die
    #determine who has died (zero, negative health)
    #random illness! a tiger dies 
end 


def buy_tiger 
    #pick from unbought tigers to buy from. in each session, rake::seed clears all non-blank_zoo tigers. 
    choices = Tiger.all.select{|tiger| (tiger.bought == false) && (tiger.alive == true)}.map(&:name) 
    tiger_chosen = $prompt.select("Pick your tiger!", choices) 
    tiger_object = Tiger.find_by(name: tiger_chosen) 
    
    if Zoo.last.money >= tiger_object.price  
        tiger_object.update_attribute(:bought, true)  #same tiger cannot be bought again 
        new_tiger = tiger_object.dup  #tiger instance duplicated to current zo
        new_tiger.save 
        new_tiger.update_attribute(:time_born, Time.now) #set time born to new tiger 
        new_tiger.update_attribute(:zoo_id, Zoo.last.id) #set current zoo_id to new tiger 
        resulting_money = Zoo.last.money - tiger_object.price  #updates zoo's money 
        Zoo.last.update_attribute(:money, resulting_money)
        puts "Congrats, #{Zookeeper.last.name}! You just bought #{tiger_chosen}!"
        game_run_method 
    else 
        puts "You do not have enough money to buy this tiger!"
        game_run_method
    end 
end 

def buy_food 
    choices = Food.all.map{|food| food.name + " for $#{food.price}"}
    food_choice = $prompt.select("Which food will you feed your tiger today?", choices).split(" ")
    food_choice.pop(2)
    food_choice = food_choice.join(" ") 
    price = Food.all.find_by(name: food_choice).price  

    if Zoo.last.money >= price 
        puts "You just bought #{food_choice}!" 
        Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.all.find_by(name: food_choice).id) #add food to zoo through joiner class
        resulting_money = Zoo.last.money - price #update money after buying food 
        Zoo.last.update_attribute(:money, resulting_money)
        game_run_method
    else 
        puts "You do not have enough money to buy this food product!"
        game_run_method
    end 
end 


def sell_tiger 
    available_tigers = Tiger.all.select{|tiger| (tiger.bought == true) && (tiger.zoo_id == Zoo.last.id) && (tiger.alive == true)}
    if available_tigers.length == 0 
        puts "You have no tigers!"
        game_run_method
    else 
        choices = available_tigers.map{|tiger| tiger.name + " (bought for #{tiger.price})"} 
        tiger_chosen = $prompt.select("Pick a tiger to sell!", choices).split(" ")
        tiger_chosen.pop(3)
        tiger_object = Tiger.all.find_by(name: tiger_chosen.join(" "), bought: true, zoo_id: Zoo.last.id, alive: true)
        price = tiger_object.price 
        health = tiger_object.health 

        if health >= 50
            sell_price = (price*((1+(health/200))*(1+0.5*(rand)))).to_i 
            resulting_money = Zoo.last.money + sell_price  
            Zoo.last.update_attribute(:money, resulting_money)
            Zoo.last.save 
            tiger_object.update_attribute(:bought, false) 
            tiger_object.update_attribute(:alive, nil) 
            puts "You just sold #{tiger_chosen.join(" ")} for #{sell_price}! Say goodbye to your tiger!"
            game_run_method 
        elsif health <= 50
            puts "This Tiger is too sick too sell!"
            game_run_method
        end 
    end 
end 

# char1 = Zookeeper.create(name: "Joe", alive: true )
# z1 = Zoo.create(name: "zoo1", money: 2000 , zookeeper_id: Zookeeper.last.id)


def showcase_tiger 
    available_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}
    
    if available_tigers.length == 0
        puts "You have no tigers!"
        game_run_method
    else 
        tiger_choices = available_tigers.map(&:name)  
        tiger_chosen = $prompt.select("Pick a tiger to showcase at your local mall!", tiger_choices) 
        tiger_object = Tiger.all.find_by(name: tiger_chosen, zoo_id: Zoo.last.id, bought: true, alive: true)
        health = tiger_object.health 
        price = tiger_object.price 

        input = $prompt.yes?("Are you sure you want to submit this tiger to torture?")
        if input == true
            updated_health = health - 50  
            tiger_object.update_attribute(:health, updated_health) 
            money_made = price*2*(0.5+(health/400)).to_i 
            resulting_money = Zoo.last.money + money_made 
            Zoo.last.update_attribute(:money, resulting_money) 
            if updated_health <= 0 
                puts "You made #{money_made}, but #{tiger_chosen} is hurt so badly it died!" 
            else puts "You made #{money_made}, but #{tiger_chosen} is traumatized! #{tiger_chosen}'s health went down to #{updated_health}."
            end 
            game_run_method 
        else 
            puts "You are very kind!"
            game_run_method
        end
    end
end 

def feed_tiger 
    available_tigers = Tiger.all.select{|tiger| tiger.bought == true && tiger.zoo_id == Zoo.last.id && tiger.alive == true}
    available_foods = Zoo.last.foods 
    if available_tigers.length == 0 || available_foods.length == 0 
        if available_tigers.length == 0 && available_foods.length == 0 
            puts "You have no tigers and no food!" 
        elsif available_foods.length == 0 
            puts "You don't have any food supplies!"
        else
            puts "You don't have any tigers to feed!"
        end 
        game_run_method
    else 
        tiger_choices = available_tigers.map(&:name)
        tiger_chosen = $prompt.select("Choose a Tiger to feed!", tiger_choices)
        food_choices = available_foods.map(&:name).uniq 
        food_chosen = $prompt.select("What do you want to feed your tiger?", food_choices)  

        tiger_object = Tiger.all.find_by(name: tiger_chosen, zoo_id: Zoo.last.id, bought: true, alive: true) 
        food_object = Food.all.find_by(name: food_chosen) 
        zoofood_object = Zoofood.all.find_by(zoo_id: Zoo.last.id, food_id: food_object.id)
        zoofood_object.update_attribute(:zoo_id, nil) 
        puts "Chomp chomp chomp!"

        # Determine whether the tiger prefers the given food or not 
        
        tied_blank_tiger = Tiger.all.find_by(name: tiger_chosen, bought: true, alive: true, time_born: nil)  
        binding.pry 
        if FoodPreference.find_by(food_id: food_object.id, tiger_id: tied_blank_tiger.id)  
            change = 40  
            puts "Your tiger #{tiger_chosen} is very happy!" 
        elsif food_chosen == "Walmart Meats"
            change = -40 
            puts "Your Tiger is ill! Don't feed him Walmart Meat next time!"
        else 
            change = 5
            puts "Your #{tiger_chosen} doesn't really enjoy that food!" 
        end
 
        updated_health = tiger_object.health + change  
        tiger_object.update_attribute(:health, updated_health)
        puts "Your tiger's new health is now #{updated_health}."
        game_run_method 
     
    end 
end 

f2 = Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.find_by(name: "Organic Chicken").id) 
f3 = Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.find_by(name: "Beef").id) 
f3 = Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.find_by(name: "Beef").id) 
f3 = Zoofood.create(zoo_id: Zoo.last.id, food_id: Food.find_by(name: "Walmart Meats").id) 

Zookeeper.create(name: "Bob", alive?: true)
z1 = Zoo.create(name: "zoo1" , money: 1000, zookeeper_id: Zookeeper.last.id)
t1 = Tiger.create(name: "Hello", zoo_id: z1.id, bought?: true, alive?: true, health: 100, price: 1000) 
t2 = Tiger.create(name: "Bye", zoo_id: z1.id, bought?: true, alive?: true, health: 200, price: 300) 




# turn_choices = ["feed tiger", "sell tiger", "showcase a tiger", "buy food"]
# turn_choice = $prompt.select("Options:", turn_choices)
