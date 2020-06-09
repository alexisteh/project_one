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
    $char_object = Zookeeper.find_by(name: char_name)  
    # zoo_name prompt
    # game_run_method
end 

def game_run_method 
    puts "good"
end 



pick_character_and_zoo
puts $char_object