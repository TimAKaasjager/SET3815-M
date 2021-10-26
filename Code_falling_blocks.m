

tic;
toc;
while 1                 %game keeps running indefinitely
    %Calls function that contains the if statement that dictates what
    %happens when a block is at y = 0 or hits the player
   [FallingBlockPoscloud, FallingBlockVelcloud, livescounter] = Badblock(x, cloud, ...
   FallingBlockPoscloud,FallingBlockVelcloud,livescounter,PlayerCenter,PlayerWidth);

   [FallingBlockPossun, FallingBlockVelsun, pointscounter] = Goodblockfunc(x, sun, ...
   FallingBlockPossun,FallingBlockVelsun,pointscounter,PlayerCenter,PlayerWidth);
    %Calls a different function for the good block, as hitting the player
    %has different consequences than hitting a bad block

   if livescounter == 0       %what happens when the game is over

    %GAME OVER text appears
    gameover = text(230,640,'Too cloudy, you are bankrupped!','FontSize',...   
    50,'Color','r','FontName','Impact');

    %The counters are redefined because setting x and y values doesn't work
    T_points = text(256,512,Y,'Fontsize',40,...           
    'Color','w','FontName','Impact');
    set(T_points, 'str', ['Your final score is ', num2str(pointscounter)])
    set(T_lives, 'str', [Display_lives,' = ',num2str(livescounter)])
    break
    
   end