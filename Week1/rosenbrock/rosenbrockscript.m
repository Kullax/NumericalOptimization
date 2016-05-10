% this script runs the rosenbrock function plotter on an instance going
% from -1 to 2 with an interval of 0.1 

%Notice a vector is defined this is good to remember
%notice also the ' after the square brackets which transpose the vector so
%we have column vectors 
x = [-3.01:0.05:3.01]';

y = [-3.01:0.05:3.01]';

value = rose(x,y);
figure(2)
axis equal;
% plot the matrix as a surface
surf(x,y,value);

% I call the functions with the global minimum as input expecting a zero
% vector and a positive definite matrix respectively
rosegrad(2,2)
rosehess(2,2)
% try other inputs to test if the result makes sense