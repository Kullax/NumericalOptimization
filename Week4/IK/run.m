% Make sure we got a clean environment to work in
close all;
clear all;

% Setup a default configuration
links = [ 0 0 0;...
          1 1 1];
angles = [pi/4; pi/4; pi/4];

% Try to find end-effector position
e = F(links, angles);

convergence = figure(1);
clf;
hold on;
title('Real Time Convergence Plot');
xlabel('Runtime in ms');
ylabel('Convergence of 0.5*norm(e-goal)^2');
arm = figure(2);
colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2]};
cc=hsv(5);
    %angles = [pi/4;pi/4;pi/4];
upper = [pi/4; pi/4; pi];
lower = [-pi/4;-pi/4; -pi];
max  = 50;
non = zeros(1,max);
dogle = zeros(1,max);
bf = zeros(1,max);
ds = zeros(1,max);
for n = 1: max
    figure(arm);
   axis([-2 2 -1 3])
    pause(0.1)
%    [gx,gy] = ginput(1);
    gx = 1.5 - (3).*rand(1);
    gy = 2.5 - (3).*rand(1);
%    clf
    figure(arm);
 %   plot(gx,gy,'bo');
%    disp('non linear')
    % nonlinear_newton
    color = cc(1,:);
    angles = [pi/4;pi/4;pi/4];
    t = tic;
    [angles,error_m, time_m] = nonlinear_newton([gx;gy;1],links,angles);
    non(n) = toc(t);
    if(n > 1)
        figure(convergence);

         plot(time_m, error_m, 'Color',color)
    end
    figure(arm);
%    draw_chain( links, angles, color );

%    disp('dogleg')
    % dogleg
    color = cc(4,:);
    angles = [0;0;0];
    t = tic;
    [angles,error_m, time_m] = dogleg([gx;gy;1],links,angles);
    dogle(n) = toc(t);
    if(n>1)
        figure(convergence);

     plot(time_m, error_m, 'Color',color)
    end
     figure(arm);
 % draw_chain( links, angles, color );
    
 %   disp('bfgs')
    % BFGS
    color = cc(3,:);
    angles = [pi/4;pi/4;pi/4];
    t = tic;
    [angles,error_m, time_m] = BFGS([gx;gy;1],links,angles);
    bf(n) = toc(t);
    if(n>1)
        figure(convergence);

         plot(time_m, error_m, 'Color',color)
    end
      figure(arm);
  %draw_chain( links, angles, color );
    
   % disp('sd')
    %  SD
    color = cc(5,:);
    t = tic;
    [angles,error_m, time_m] = ik_steepest_descent([gx; gy; 1],links,angles, @armijo_backtracking_linesearch);%, @projection, lower, upper);
    ds(n) = toc(t);
     figure(arm);
  %  draw_chain( links, angles, color );
 if(n>1)
     figure(convergence);

    plot(time_m, error_m, 'Color',color)
 end
 figure(arm);
end
figure(convergence);
%legend('steepest descent')
legend('nonlinear\_newton','dogleg', 'bfgs',  'steepest descent')
