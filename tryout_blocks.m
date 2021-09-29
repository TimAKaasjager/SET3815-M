%https://www.youtube.com/watch?v=taDSfV2a3J8&ab_channel=SilasHenderson;

%--------------------------Setup---------------------------------------%
FallingBlocksFigure = figure('color',[.2 .8 .8],...            %Block
    'KeyPressFcn', @keyboardFunction,'unit','normal','position',[.1 .1 .8 .8]);

FallingBlocksAxes = axes('color', 'black',...                  %Axes
   'XLim', [0 100], 'YLim', [0 100], 'XTickLabels',[],'YTickLabels',[],'position',[.05 .05 .9 .9]);

FallingBlockVel = [0, -2];                                     %Ball
FallingBlockPos = [20, 70];
FallingBlock = line(FallingBlockPos(1),FallingBlockPos(2),...  
    'marker','.','markersize', 25,'color','red');

global PlayerCenter;                                           %Player
PlayerCenter = 45;
Player = line([PlayerCenter - 5, PlayerCenter + 5],[5 5],...     
    'color', 'green', 'linewidth', 4);

%------------------------Loop-----------------------------------------%
tic;
toc;
while toc < 15
    
    if FallingBlockPos(2) < 5
        if abs(FallingBlockPos(1) - PlayerCenter) > 5
            newpos = randi([10 90]);
            FallingBlockPos = [newpos 100];
        else 
           close all; return ;
        end
    end
                
    FallingBlockPos = FallingBlockPos + FallingBlockVel;      %Update Ball  
    set(FallingBlock, 'XData', FallingBlockPos(1), 'YData', FallingBlockPos(2))
    
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


