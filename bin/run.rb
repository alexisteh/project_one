require_relative '../config/environment.rb'

$prompt = TTY::Prompt.new 

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
    choices = ["Joe Exotic", "Carole Baskin", "Doc Bhagaven Antle"]
    char_name = $prompt.select("Pick your character!", choices)
    if char_name == "Joe Exotic"
        start_money = 1200 
    elsif char_name == "Carole Baskin"
        start_money = 800 
    else start_money = 1000
    end 
    zookeeper_object = Zookeeper.create(name: char_name, money: start_money, alive?: true)  
    puts "Welcome," + char_name +" !"

    zoo_name = $prompt.ask("Now, name your zoo:")
    zoo_object = Zoo.create(name: zoo_name, end_money: start_money, zookeeper_id: zookeeper_object.id)
    puts zoo_object.zookeeper_id 
    puts zoo_object.end_money
end 
 

def game_run_method 
    puts "good"
end 



pick_character_and_zoo
