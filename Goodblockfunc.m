function [location, speed, pointscounter ] = Goodblockfunc(background, image, location,speed,pointscounter,PlayerCenter,...
    PlayerWidth) 
    dimensions = size(background); 
    imagedim = size(image);
    if location(2) < 50
        if abs((location(1)+48) - PlayerCenter) > PlayerWidth
            newposx = randi([0.1*dimensions(1) 0.9*dimensions(1)]);
            newposy = randi([0.8*dimensions(2) dimensions(2)]);
            location = [newposx newposy];
            giftspeed = -0.005*dimensions(2)*randi([2 4]);
            speed = [0 giftspeed];
        else
            pointscounter = pointscounter - speed(2);          %points correspond to speed of gift
            newposx = randi([0.1*dimensions(1) 0.9*dimensions(1)]);
            newposy = randi([0.8*dimensions(2) dimensions(2)]);
            location = [newposx newposy];
            giftspeed = -0.005*dimensions(2)*randi([2 4]);
            speed = [0 giftspeed];
            
            
        end
    end
end


