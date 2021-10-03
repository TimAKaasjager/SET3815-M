%https://www.youtube.com/watch?v=taDSfV2a3J8&ab_channel=SilasHenderson;

%--------------------------Setup---------------------------------------%
FallingBlocksFigure = figure('color',[0 0.4470 0.7410],...            %Block
    'KeyPressFcn', @keyboardFunction,'unit','normal','position',[.1 .1 .8 .8]);

FallingBlocksAxes = axes('color', 'black',...                  %Axes
   'XLim', [0 100], 'YLim', [0 100], 'XTickLabels',[],'YTickLabels',[],'position',[.05 .05 .9 .9]);

giftspeed = randi([-2 -1]);
FallingBlockVel = [0, -1];                                     %Block
GoodBlockVel = [0, giftspeed];                                        %Good Block
FallingBlockPos = [30, 70];
GoodBlockPos = [20, 90];
FallingBlock = line(FallingBlockPos(1),FallingBlockPos(2),...  
    'marker','.','markersize', 50,'color','red');
GoodBlock = line(GoodBlockPos(1),GoodBlockPos(2),...  
    'marker','.','markersize', 25,'color','green');

global PlayerCenter;                                           %Player
PlayerCenter = 45;
Player = line([PlayerCenter - 5, PlayerCenter + 5],[5 5],...     
    'color', '[0.5 0.5 0.5]', 'linewidth', 4);

%------------------------Loop-----------------------------------------%

livescounter = 3; 
pointscounter = 0;

tic;
toc;
while toc < 50
    
    if FallingBlockPos(2) < 5
        if abs(FallingBlockPos(1) - PlayerCenter) > 5
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            FallingBlockPos = [newposx newposy];
 %           pause(randi(3));
        else 
           %close all; return;
           livescounter = livescounter - 1;
           newposx = randi([10 90]);
           newposy = randi([80 100]);
           FallingBlockPos = [newposx newposy];
           
        end
    end
    
    if GoodBlockPos(2) < 5
        if abs(GoodBlockPos(1) - PlayerCenter) > 5
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            GoodBlockPos = [newposx newposy];
        else
            pointscounter = pointscounter + 1;
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            GoodBlockPos = [newposx newposy];
            
        end
    if livescounter == 0
        close all; return;
    end
   
    
    %----------The counters---------------------------- 
    Display_lives = 'Lives';   
    amount_lives = livescounter;
    X = [Display_lives,' = ',num2str(amount_lives)];
    T_lives = text(80,80,X,'FontSize',40,'Color','w','FontName','Impact');
    
    Display_points = 'Points';
    amount_points = pointscounter;
    Y = [Display_points, ' = ', num2str(amount_points)];
    T_points = text(80,70,Y,'Fontsize',40,'Color','w','FontName','Impact'); 
   
    %------------------------------------------------
                
    FallingBlockPos = FallingBlockPos + FallingBlockVel;      %Update Ball  
    set(FallingBlock, 'XData', FallingBlockPos(1), 'YData', FallingBlockPos(2))
    
    GoodBlockPos = GoodBlockPos + GoodBlockVel;      %Update Ball  
    set(GoodBlock, 'XData', GoodBlockPos(1), 'YData', GoodBlockPos(2))
    
    set(Player, 'XData', [PlayerCenter - 5, PlayerCenter + 5])
    
    pause(0.05);
end
%------------------------Functions------------------------------------%
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


