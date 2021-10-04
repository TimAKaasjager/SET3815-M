%--------------------------Setup----------------------------------------%
FallingBlocksFigure = figure('color',[0 0.4470 0.7410],...            %Block
    'KeyPressFcn', @keyboardFunction,'unit','normal','position',[.1 .1 .8 .8]);

FallingBlocksAxes = axes('color', 'black',...                  %Axes
   'XLim', [0 100], 'YLim', [0 100], 'XTickLabels',[],'YTickLabels',[],'position',[.05 .05 .9 .9]);

%giftspeed = randi([-2 -1]);
FallingBlockVel = [0, -1];                                     %Block
GoodBlockVel = [0, -1];                                         %Good Block
FallingBlockVelpl = [0, -1];
FallingBlockPos = [30 70];
FallingBlockPossq = [50 80];
FallingBlockPospl = [60 90];
GoodBlockPos = [20, 90];
FallingBlock = line(FallingBlockPos(1),FallingBlockPos(2),...  
    'marker','.','markersize', 50,'color','red');
FallingBlocksq = line(FallingBlockPossq(1),FallingBlockPossq(2),...  
    'marker','s','markersize', 70,'color','red');
%plastic = imread('Plastic-PNG-Transparent-HD-Photo.png'); 
%plastic = imresize(plastic, 0.2);
%fallingplastic = subimage(FallingBlockPospl(1),FallingBlockPospl(2),plastic); 
GoodBlock = line(GoodBlockPos(1),GoodBlockPos(2),...  
    'marker','.','markersize', 25,'color','green');

global PlayerCenter;                                           %Player
PlayerCenter = 45;
Player = line([PlayerCenter - 5, PlayerCenter + 5],[5 5],...     
    'color', '[0.5 0.5 0.5]', 'linewidth', 4);

%------------------------Loop-----------------------------------------%

livescounter = 3; 
pointscounter = 0;

%----------The counters----------------------------
Display_lives = 'Lives';
amount_lives = livescounter;
X = [Display_lives,' = ',num2str(livescounter)];
T_lives = text(80,80,X,'FontSize',40,'Color','w','FontName','Impact');

Display_points = 'Points';
amount_points = pointscounter;
Y = [Display_points, ' = ', num2str(pointscounter)];
T_points = text(80,70,Y,'Fontsize',40,'Color','w','FontName','Impact');

%------------------------------------------------

tic;
toc;
while toc < 150
    
    if FallingBlockPos(2) < 5
        if abs(FallingBlockPos(1) - PlayerCenter) > 5
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            giftspeed = randi([-2 -1]);
            FallingBlockPos = [newposx newposy];
            FallingBlockVel = [0 giftspeed];
 %           pause(randi(3));
        else 
           %close all; return;
           
           livescounter = livescounter - 1;
           newposx = randi([10 90]);
           newposy = randi([80 100]);
           FallingBlockPos = [newposx newposy];        
        end
    end
    
    if FallingBlockPossq(2) < 5
        if abs(FallingBlockPossq(1) - PlayerCenter) > 5
            newposx = randi([10 90]);
            newposy = randi([80 100]);
            giftspeed = randi([-2 -1]);
            FallingBlockPossq = [newposx newposy];
            FallingBlockVel = [0 giftspeed];
 %           pause(randi(3));
        else 
           %close all; return;
           
           livescounter = livescounter - 1;
           newposx = randi([10 90]);
           newposy = randi([80 100]);
           FallingBlockPossq = [newposx newposy];        
        end
    end
    
%     if FallingBlockPospl(2) < 5
%         if abs(FallingBlockPospl(1) - PlayerCenter) > 5
%             newposx = randi([10 90]);
%             newposy = randi([80 100]);
%             speed = randi([-2 -1]);
%             FallingBlockPospl = [newposx newposy];
%             FallingBlockVelpl = [0 speed];
%         else 
%             pointscounter = pointscounter - speed;          %points correspond to speed of gift
%             newposx = randi([10 90]);
%             newposy = randi([80 100]);
%             FallingBlockPospl = [newposx newposy];
%                   
%         end
%     end
    
%    R = randi([0 5]);
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
if livescounter == 0
    bar(pointscounter)
    text(1:length(pointscounter),pointscounter,num2str(pointscounter'),'vert','bottom','horiz','center'); 
    set(gca,'XTick',[], 'YTick', [])
    title('Your Score','FontSize',10)
    %Xlabel('Your Score')
    
end


                
    FallingBlockPos = FallingBlockPos + FallingBlockVel;      %Update Ball  
    set(FallingBlock, 'XData', FallingBlockPos(1), 'YData', FallingBlockPos(2))
    
    FallingBlockPossq = FallingBlockPossq + FallingBlockVel;      %Update Ball  
    set(FallingBlocksq, 'XData', FallingBlockPossq(1), 'YData', FallingBlockPossq(2))
    
    GoodBlockPos = GoodBlockPos + GoodBlockVel;      %Update Ball  
    set(GoodBlock, 'XData', GoodBlockPos(1), 'YData', GoodBlockPos(2))
    
    set(T_lives, 'str', [Display_lives,' = ',num2str(livescounter)])
    
    set(T_points, 'str', [Display_points,' = ',num2str(pointscounter)])
    
    set(Player, 'XData', [PlayerCenter - 5, PlayerCenter + 5])
    
    pause(0.05);
end

%------------------------Functions-------------------------------------%
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

