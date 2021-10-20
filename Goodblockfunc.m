function [location, speed, pointscounter ] = Goodblockfunc(location,speed,pointscounter,PlayerCenter) 

    if location(2) < 5
        if abs(location(1) - PlayerCenter) > 5
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            location = [newposx newposy];
        else
            pointscounter = pointscounter - speed(2);          %points correspond to speed of gift
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            location = [newposx newposy];
            
            
        end
    end
end