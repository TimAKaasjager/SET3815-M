function [location, speed, livescounter ] = Badblock(background, image, location,speed,livescounter,PlayerCenter,PlayerWidth)   
    dimensions = size(background);      %defining screen width to later determine new position for block
    imagedim = size(image);             %defining block width in order to later find center of image
    if location(2) < 50                   %if y value of position is below a certain value
        if abs((location(1)+51.2) - PlayerCenter) > PlayerWidth   %and the block is not touching the player 
            %(with compensation for the fact that image x&y data corresponds to bottom left corner)
            
            %reposition block somewhere randomly at the top when it has
            %reached the bottom
            newposx = randi([0.1*dimensions(1) 0.9*dimensions(1)]);
            newposy = randi([0.8*dimensions(2) dimensions(2)]);
            location = [newposx newposy];
            giftspeed = -0.005*dimensions(2)*randi([2 4]);
            speed = [0 giftspeed];
        else 
           %if it hits, lose one life and position block randomly at the
           %top
           
           livescounter = livescounter - 1;
           newposx = randi([0.1*dimensions(1) 0.9*dimensions(1)]);
           newposy = randi([0.8*dimensions(2) dimensions(2)]);
           location = [newposx newposy];  
           giftspeed = -0.005*dimensions(2)*randi([2 4]);
           speed = [0 giftspeed];
        end
    end
   
    