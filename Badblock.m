function [location, speed, livescounter ] = Badblock(location,speed,livescounter,PlayerCenter)   
    if location(2) < 5                   %if y value of position is below a certain value
        if abs(location(1) - PlayerCenter) > 5   %and the block is not touching the player
            %reposition block somewhere randomly at the top when it has
            %reached the bottom
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            giftspeed = randi([-2 -1]);
            location = [newposx newposy];
            speed = [0 giftspeed];
        else 
           %if it hits, lose one life and position block randomly at the
           %top
           
           livescounter = livescounter - 1;
           newposx = randi([10 90]);
           newposy = randi([80 100]);
           location = [newposx newposy];        
        end
   end