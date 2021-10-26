%                                              Falling Blocks Game
%                         Authors: Floris van Buren, Tim Kaasjager, Olav
%                         Eringfeld en Sophie van Kleef 
%                         Minimum Matlab version required: 2020a
%                         Toolboxes required: Image Processing
%                                           Have fun playing the game!

%--------------------Setting up board and objects---------------%
FallingBlocksFigure = figure('color',[0 0.4470 0.7410],...            %Block
    'KeyPressFcn', @keyboardFunction,'unit','normal','position',[.1 .1 .7 .7]);

%  FallingBlocksAxes = axes('color', 'black',...                  %Axes
%     'XLim', [0 1280], 'YLim', [0 1280], 'XTickLabels',[],'YTickLabels',[],'position',[.05 .05 .9 .9]);

FallingBlocksAxes = gca;
uistack(FallingBlocksAxes,'bottom');
[x, FallingBlocksAxes]=imread('clouds.jpg');
image(x)
%set(x, 'ydir','reverse')
set(FallingBlocksAxes,'handlevisibility','off','visible','off')
set(FallingBlocksAxes,'alphadata',.05)
ax = gca;
ax.YDir = 'normal';
set(gca,'visible','off')
%set(gca, 'ydir','reverse')
%set(FallingBlocksAxes,'ydir','reverse')
%set(gca, 'YDir','reverse')
%set(FallingBlocksAxes, 'YDir','reverse')

missionstatement = text(100,1300,'Collect as much sun as possible!','Fontsize',40,...           
'Color','w','FontName','Impact');
% set(missionstatement, 'str', ['Collect as much sun as possible!'])



%-------defining initial velocities and positions of falling blocks 
FallingBlockVelcloud = [0, -12.8];                                %cloud
FallingBlockVelsun = [0, -12.8];                                  %sun                                

FallingBlockPossun = [200 1150];
FallingBlockPoscloud = [640 1024]; 

%defining shapes of player and falling blocks, including implementing image
%of sun and of clouds

[sun, mapsun, alpha] = imread('sunray.png','BackgroundColor','none');
alpha = zeros(length(alpha(1)),length(alpha(2))); 
sunresize = imresize(sun, 0.1);
Fallingsun = image('XData',FallingBlockPossun(1),'YData',FallingBlockPossun(2),'CData', ...
    flipud(sunresize)); 

[cloud, mapcloud, alpha2] = imread('sadcloud.png','BackgroundColor','none');
alpha2 = zeros(length(alpha2(1)),length(alpha2(2)));
cloudresize = imresize(cloud, 0.4);
Fallingcloud = image('XData',FallingBlockPoscloud(1),'YData',FallingBlockPoscloud(2),'CData', ...
    flipud(cloudresize));

%  GoodBlock = line(GoodBlockPos(1),GoodBlockPos(2),...  
%     'marker','.','markersize', 25,'color','green');

global PlayerCenter;                                           %Player
PlayerCenter = 576;
PlayerWidth = 64;
Player = line([PlayerCenter - PlayerWidth, PlayerCenter + PlayerWidth],[PlayerWidth PlayerWidth],...     
    'color', '[0.5 0.5 0.5]', 'linewidth', 4);
%% 
%------------------------Loop-----------------------------------------%

%counters display and initial conditions
livescounter = 3;
pointscounter = 0;

Display_lives = 'Lives';
amount_lives = livescounter;
X = [Display_lives,' = ',num2str(livescounter)];
T_lives = text(1024,1024,X,'FontSize',40,'Color','w','FontName','Impact');

Display_points = 'Points';
amount_points = pointscounter;
Y = [Display_points, ' = ', num2str(pointscounter)];
T_points = text(1024,896,Y,'Fontsize',40,'Color','w','FontName','Impact');

tic;
toc;
while 1                 %game keeps running indefinitely
    %Calls function that contains the if statement that dictates what
    %happens when a block is at y = 0 or hits the player
   [FallingBlockPoscloud, FallingBlockVelcloud, livescounter] = Badblock(x, ...
   FallingBlockPoscloud,FallingBlockVelcloud,livescounter,PlayerCenter,PlayerWidth);

   [FallingBlockPossun, FallingBlockVelsun, pointscounter] = Goodblockfunc(x, ...
   FallingBlockPossun,FallingBlockVelsun,pointscounter,PlayerCenter,PlayerWidth);
    %Calls a different function for the good block, as hitting the player
    %has different consequences than hitting a bad block

   if livescounter == 0       %what happens when the game is over
%     bar(pointscounter)
%     text(1:length(pointscounter),pointscounter,num2str(pointscounter'),'vert','bottom','horiz','center'); 
%     set(gca,'XTick',[], 'YTick', [])
%     title('Your Score','FontSize',10)
%     %Xlabel('Your Score')

    %GAME OVER text appears
    gameover = text(230,640,'Too cloudy, you are bankrupt!','FontSize',...    
    50,'Color','r','FontName','Impact');
    set(missionstatement,'str','' )

    %The counters are redefined because setting x and y values doesn't work
    T_points = text(256,512,Y,'Fontsize',40,...           
    'Color','w','FontName','Impact');
    set(T_points, 'str', ['Your final score is ', num2str(pointscounter)])
    set(T_lives, 'str', [Display_lives,' = ',num2str(livescounter)])
    break
    
   end

    FallingBlockPoscloud = FallingBlockPoscloud + FallingBlockVelcloud;      %add velocity step to position
    set(Fallingcloud, 'XData', FallingBlockPoscloud(1), 'YData', FallingBlockPoscloud(2)) %set new position
    
    FallingBlockPossun = FallingBlockPossun + FallingBlockVelsun;
    set(Fallingsun, 'XData', FallingBlockPossun(1), 'YData', FallingBlockPossun(2))
    
    set(T_lives, 'str', [Display_lives,' = ',num2str(livescounter)])  %refresh counters
    
    set(T_points, 'str', [Display_points,' = ',num2str(pointscounter)])
    
    set(Player, 'XData', [PlayerCenter - PlayerWidth, PlayerCenter + PlayerWidth])
    
    pause(0.05);
end

%% 
 
%  solar = imread('solar1.png'); 
%  solar = imresize(solar, 1);
%  solarpic = image('XData',FallingBlockPossq(1,:),'YData',FallingBlockPossq(2,:),'CData', flipud(solar));

 
%  %Function
function keyboardFunction(~,event)
global PlayerCenter
switch event.Key
    case 'rightarrow'
        PlayerCenter = PlayerCenter + 25.6;
    case 'leftarrow'
        PlayerCenter = PlayerCenter - 25.6;
    case 'a'
        PlayerCenter = PlayerCenter - 25.6;
    case 'd'
        PlayerCenter = PlayerCenter + 25.6;
end 
%set(gcf,'color',rand(1,3))
end

