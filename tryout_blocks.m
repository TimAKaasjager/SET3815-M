%                                              Falling Blocks Game
%                         Authors: Floris van Buren, Tim Kaasjager, Olav
%                         Eringfeld en Sophie
%                         Minimum Matlab version required: 2020a
%                         Toolboxes required: Image Processing
%                                           Have fun playing the game!

%--------------------Setting up board and objects---------------%
clear all
FallingBlocksFigure = figure('color',[0 0.4470 0.7410],...            %Block
    'KeyPressFcn', @keyboardFunction,'unit','normal','position',[.1 .1 .8 .8]);

FallingBlocksAxes = axes('color', 'black',...                  %Axes
   'XLim', [0 100], 'YLim', [0 100], 'XTickLabels',[],'YTickLabels',[],'position',[.05 .05 .9 .9]);

%defining initial velocities and positions
FallingBlockVel = [0, -1];                                      %Block
FallingBlockvelsq = [0, -1];                                    %Block 2
GoodBlockVel = [0, -1];                                        %Good Block
FallingBlockVelpl = [0 0; -1 -1];                               %plastic

FallingBlockPos = [30 70];
FallingBlockPossq = [50 80];
FallingBlockPoswi = [50 60;70 80];
GoodBlockPos = [20, 90];

%defining shapes of player and falling blocks, including implementing image of plastic
%bag
FallingBlock = line(FallingBlockPos(1),FallingBlockPos(2),...  
    'marker','.','markersize', 50,'color','red');
FallingBlocksq = line(FallingBlockPossq(1),FallingBlockPossq(2),...  
    'marker','s','markersize', 30,'color','red');
wind = imread(); 
wind = imresize(wind, 0.01);
fallingwind = image('XData',FallingBlockPoswi(1,:),'YData',FallingBlockPoswi(2,:),'CData', flipud(wind)); 
GoodBlock = line(GoodBlockPos(1),GoodBlockPos(2),...  
    'marker','.','markersize', 25,'color','green');

global PlayerCenter;                                           %Player
PlayerCenter = 45;
Player = line([PlayerCenter - 5, PlayerCenter + 5],[5 5],...     
    'color', '[0.5 0.5 0.5]', 'linewidth', 4);

%% 
%------------------------Loop-----------------------------------------%

%counters display and initial conditions
livescounter = 3;
pointscounter = 0;

Display_lives = 'Lives';
amount_lives = livescounter;
X = [Display_lives,' = ',num2str(livescounter)];
T_lives = text(80,80,X,'FontSize',40,'Color','w','FontName','Impact');

Display_points = 'Points';
amount_points = pointscounter;
Y = [Display_points, ' = ', num2str(pointscounter)];
T_points = text(80,70,Y,'Fontsize',40,'Color','w','FontName','Impact');

tic;
toc;
while toc < inf                 %game keeps running indefinitely
    
    Badblock
%     if FallingBlockPos(2) < 5                   %if y value of position is below a certain value
%         if abs(FallingBlockPos(1) - PlayerCenter) > 5   %and the block is not touching the player
%             %reposition block somewhere randomly at the top when it has
%             %reached the bottom
%             newposx = randi([10 90]);
%             newposy = randi([80 100]);
%             giftspeed = randi([-2 -1]);
%             FallingBlockPos = [newposx newposy];
%             FallingBlockVel = [0 giftspeed];
%         else 
%            %if it hits, lose one life and position block randomly at the
%            %top
%            
%            livescounter = livescounter - 1;
%            newposx = randi([10 90]);
%            newposy = randi([80 100]);
%            FallingBlockPos = [newposx newposy];        
%         end
%     end
    
    if FallingBlockPossq(2) < 5
        if abs(FallingBlockPossq(1) - PlayerCenter) > 5
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            giftspeed = randi([-2 -1]);
            FallingBlockPossq = [newposx newposy];
            FallingBlockVel = [0 giftspeed];       
        else 
           
           livescounter = livescounter - 1;
           newposx = randi([10 90]);
           newposy = randi([80 100]);
           FallingBlockPossq = [newposx newposy];        
        end
    end
    
%     if FallingBlockPospl(2) < 5
%         if abs(FallingBlockPospl(1,1)+(FallingBlockPospl(1,2)-FallingBlockPospl(1,1))/2 - PlayerCenter) > 5
%             newposx = randi([10 90]);
%             newposy = randi([80 100]);
%             %randomize block speed when it goes back to the top
%             speed = randi([-2 -1]);
%             FallingBlockPospl = [newposx newposy];
%             FallingBlockVelpl = [0 speed];
%         else 
%             pointscounter = pointscounter - speed;      %points correspond to speed of gift
%             newposx = randi([10 90]);
%             newposy = randi([80 100]);
%             FallingBlockPospl = [newposx newposy];
%                   
%         end
%     end

    if GoodBlockPos(2) < 5
        if abs(GoodBlockPos(1) - PlayerCenter) > 5
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            GoodBlockPos = [newposx newposy];
        else
            pointscounter = pointscounter - giftspeed;          %points correspond to speed of gift
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            GoodBlockPos = [newposx newposy];
            set(GoodBlock, 'markersize', -giftspeed*30)
            
        end
    end
if livescounter == 0                            %what happens when the game is over
%     bar(pointscounter)
%     text(1:length(pointscounter),pointscounter,num2str(pointscounter'),'vert','bottom','horiz','center'); 
%     set(gca,'XTick',[], 'YTick', [])
%     title('Your Score','FontSize',10)
%     %Xlabel('Your Score')

    gameover = text(20,50,'GAME OVER','FontSize',...    %GAME OVER text appears
    100,'Color','r','FontName','Impact');
    T_points = text(20,40,Y,'Fontsize',40,...           %redefined because setting x and y values doesn't work
    'Color','w','FontName','Impact');
    set(T_points, 'str', ['Your final score is ', num2str(pointscounter)])
    set(T_lives, 'str', [Display_lives,' = ',num2str(livescounter)])
    break
    
end

    FallingBlockPos = FallingBlockPos + FallingBlockVel;      %add velocity step to position
    set(FallingBlock, 'XData', FallingBlockPos(1), 'YData', FallingBlockPos(2)) %set new position
    
    FallingBlockPossq = FallingBlockPossq + FallingBlockVel;
    set(FallingBlocksq, 'XData', FallingBlockPossq(1), 'YData', FallingBlockPossq(2))
    
%     FallingBlockPospl = FallingBlockPospl + FallingBlockVelpl;
%     set(fallingplastic, 'XData', FallingBlockPospl(1), 'YData', FallingBlockPospl(2))
    
    GoodBlockPos = GoodBlockPos + GoodBlockVel;
    set(GoodBlock, 'XData', GoodBlockPos(1), 'YData', GoodBlockPos(2))
    
    set(T_lives, 'str', [Display_lives,' = ',num2str(livescounter)])  %refresh counters
    
    set(T_points, 'str', [Display_points,' = ',num2str(pointscounter)])
    
    set(Player, 'XData', [PlayerCenter - 5, PlayerCenter + 5])
    
    pause(0.05);
end

%% 

%Function
function keyboardFunction(figure,event)
global PlayerCenter
switch event.Key
    case 'rightarrow'
        PlayerCenter = PlayerCenter + 2;
    case 'leftarrow'
        PlayerCenter = PlayerCenter - 2;
    case 'a'
        PlayerCenter = PlayerCenter - 2;
    case 'd'
        PlayerCenter = PlayerCenter + 2;
end 
%set(gcf,'color',rand(1,3))
end

