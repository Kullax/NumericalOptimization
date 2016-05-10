function [ objective ] = ik_objective( goal, links, angles, tool )
%  ik_f -- The nonlinear least square unconstrained minimization IK
%  problem.
% input:
%     goal      : The end effector goal
%     links     : A matrix of fixed rod-link vectors
%     angles    : A vector with joint angles
%     tool      : Position/vector (specified in homogenuous coordinates)
% output
%     objective : The value of the objective function
if nargin < 3
    tool = [0.0;  0.0; 1.0];
end

%
% TODO Add your own code here
%
%
%  objective = ???;

end
