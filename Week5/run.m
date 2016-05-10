% Make sure we got a clean environment to work in
close all;
clear all;

% Setup a default configuration
links = [ 0 0 0;...
          1 1 1];
angles = [pi/4; pi/4; pi/4];

% Try to find end-effector position
e = F(links, angles);

% Get x and y coordinates
x = e(1);
y = e(2);

% Verify if f worked as we expected
%if ( (x  + 1.7071) > 0.001 )
%    error('x-test failed.');
%end

%if (  (y  - 1.7071) > 0.001 )
%    error('y-test failed.');
%end

figure(1);
clf;
hold on;
title('Inverse Kinematic Chain');
xlabel('X');
ylabel('Y');
%draw_chain( links, angles );

for n = 1:20
    [gx,gy] = ginput(1);
    plot(gx,gy,'bo');
    
    
%    angles = nonlinear_newton([gx; gy; 1],links,angles);
    angles = levenberg_marquardt([gx; gy; 1],links,angles);
    
    %
    % TODO: Replace the nonlinear newton method with 
    %
    %   a) Dog leg method
    %
    
    
    draw_chain( links, angles );
end
hold off;
