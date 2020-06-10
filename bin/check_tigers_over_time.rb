

def check_tigers_over_time
    #update tiger healths and alives 
    #puts message on tiger deaths and tigers who need feeding 
    existing_tigers = Tiger.all.select{|t| t.bought == true && t.zoo_id == Zoo.last.id && t.alive == true}
    if existing_tigers.length == 0 
        return 
    end 

    starved_tigers = [] 
    hungry_tigers = [] 
    dead_tigers = [] 
    existing_tigers.each do |tiger_object|
        if tiger_object.time_last_fed == nil 
            time_considered = tiger_object.time_born 
        else time_considered = tiger_object.time_last_fed 
        end 

        if Time.now - time_considered > 240.0 
            resulting_health = tiger_object.health - 20 
            tiger_object.update_attribute(:health, resulting_health)
            starved_tigers << tiger_object 
        elsif Time.now - tiger_object.time_last_fed > 80.0
            hungry_tigers << tiger_object  
        end 
        
        if tiger_object.health <= 0 
            tiger_object.update_attribute(:alive, false)
            dead_tigers << tiger_object 
            hungry_tigers.delete(tiger_object) 
            starved_tigers.delete(tiger_object) 
        end 
    end 
    if starved_tigers != []  
        puts "Tigers are starving: #{starved_tigers.map(&:name).join(", ")}." 
    end 
    if hungry_tigers != []  
        puts "Tigers are hungry: #{hungry_tigers.map(&:name).join(", ")}."
    end 
    if dead_tigers != []  
        puts "Tigers have died: #{dead_tigers.map(&:name).join(", ")}."
    end 
end 
