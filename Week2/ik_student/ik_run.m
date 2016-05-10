% Make sure we got a clean environment to work in
close all;
clear all;
clc;

% Setup a default configuration
links = [ 0 0 0;...
          1 1 1];
angles = [pi/4; pi/4; pi/4];

jacobian(links,angles)

figure(1);
clf;
hold on;
title('Inverse Kinematic Chain');
xlabel('X');
ylabel('Y');
draw_chain( links, angles );

hold off;
