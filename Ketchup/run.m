% Make sure we got a clean environment to work in
clear all;

% Setup a default configuration
links = [ 0 0 0;...
          1 1 1];
angles = [pi/4; pi/4; pi/4];

% Try to find end-effector position
e = F(links, angles);

%er = figure(1);
%semilogy(1,1);
%clf;
%hold on;
%title('Convergence Rates');
%xlabel('Iterations');
%ylabel('Error');

a = figure(2);
clf;
hold on;
title('Inverse Kinematic Chain');
xlabel('X');
ylabel('Y');
upper = [pi/4; pi/4; pi];
lower = [-pi/4;-pi/4; -pi];
clr = 0;
colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2]};
cc=hsv(5);
    angles = [0;0;0];
for n = 1:5 
     color = cc(1,:);
    figure(a)
    [gx,gy] = ginput(1);
    plot(gx,gy,'bo', 'Color', color);
    
%    [angles,error_m] = ik_steepest_descent([gx; gy; 1],links,angles, @steepest_descent, @projection, lower, upper); 
    [angles,error_m] = ik_steepest_descent([gx; gy; 1],links,angles, @armijo_backtracking_linesearch, @projection, lower, upper); 
    draw_chain( links, angles, color );
    angles = [0;0;0];
    color = cc(2,:);
    angles = nonlinear_newton([gx; gy; 1],links,angles);
    draw_chain( links, angles, color );

%    figure(er)
%    semilogy(error_m, 'Color', color)

end
hold off;
