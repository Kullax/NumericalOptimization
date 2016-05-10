function [ angles ] = nonlinear_newton( goal, links, angles, tool )
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
if nargin < 4
    tool = [0.0;  0.0; 1.0];
end

iter     = 0;
max_iter = 10;
tol      = 0.01;
e        = F(links,angles,tool);
tst      = norm(goal-e);
while ( tst > tol && iter < max_iter )
    J      = jacobian( links, angles, tool);
    angles = angles + pinv(J)*(goal-e);
    e      = F(links,angles,tool);
    tst    = norm(goal-e);
    iter   = iter + 1;
end
end
