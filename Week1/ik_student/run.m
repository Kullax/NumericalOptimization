% Make sure we got a clean environment to work in
close all;
clear all;

% Setup a default configuration
links = [ 0 0 0;...
          1 1 1];
angles = [pi/2; pi/2; pi/2];

% Try to find end-effector position
e = F(links, angles);

% Get x and y coordinates
x = e(1);
y = e(2);

% Verify if f worked as we expected
% if ( (x  + 1.7071) > 0.001 )
%     error('x-test failed.');
% end
% 
% if (  (y  - 1.7071) > 0.001 )
%     error('y-test failed.');
% end

figure(1);
clf;
hold on; axis equal;
title('Inverse Kinematic Chain');
xlabel('X');
ylabel('Y');
draw_chain( links, angles );

% Last angle will not have effect on the draw, since it's the direction
% which any NEXT draws will be.