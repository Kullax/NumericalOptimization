function [ angles ] = ik_steepest_descent( goal, links, angles, tool )
%  ik_f -- The nonlinear least square unconstrained minimization IK
%  problem.
% input:
%     goal      : The end effector goal
%     links     : A matrix of fixed rod-link vectors
%     angles    : A vector with joint angles
%     tool      : Position/vector (specified in homogenuous coordinates)
% output
%     angles    : The resutling angles
if nargin < 4
    tool = [0.0;  0.0; 1.0];
end

%
% TODO Add your own code here?????
%


end