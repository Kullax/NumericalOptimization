function [ angles,error_m,time_m ] = nonlinear_newton( goal, links, angles, tool )
% NONLINEAR_NEWTON Solve IK problem using a Newton method.
%
% input:
%     goal   - Goal position/vector (specified in homogenuous coordinates)
%     links  - A matrix of fixed rod-link vectors
%     angles - A vector with joint angles
%     tool   - Tool position wrt. end effector frame (specified in homogenuous coordinates).
% output
%     angles - The updated pose which will reach the specified goal position.
%
start = tic;
if nargin < 4
    tool = [0.0;  0.0; 1.0];
end

iter     = 1;
max_iter = 100;
error_m = zeros(1,max_iter)-1;
time_m = zeros(1,max_iter)-1;
tol      = 0.01;
e        = F(links,angles,tool);
tst      = norm(goal-e);
error_m(1) = 0.5*norm(e-goal)^2;
time_m(1) = 0;
while ( tst > tol && iter < max_iter )
    J      = jacobian( links, angles, tool);
    angles = angles + pinv(J)*(goal-e);
    e      = F(links,angles,tool);
    tst    = norm(goal-e);
    iter   = iter + 1;
    error_m(iter) = 0.5*norm(e-goal)^2;
    time_m(iter) = toc(start);
end
    error_m = error_m(1:min(iter, max_iter));
    time_m = time_m(1:min(iter, max_iter));
end
