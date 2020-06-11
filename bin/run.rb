require_relative '../config/environment.rb' 
require 'colorize'
require 'tty-prompt'
require 'pry'
require 'terminal-table'

#blank tigers before buying: bought = false, alive = true, time_born = nil
#blank tigers after buying: bought = true, alive = true, time_born = nil  
#living tigers in zoo: bought = true, alive = true, time_born != nil
#dead tigers in zoo: bought = true, alive = false, time_born != nil
#sold tigers: bought = false, alive = nil, time_born != nil


$prompt = TTY::Prompt.new 

def run 
    Interface.opening_display  
end 

run 
