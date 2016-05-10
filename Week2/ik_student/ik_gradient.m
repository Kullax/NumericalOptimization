function [ p ] = ik_gradient( goal, links, angles, tool )
%  ik_nabla_f -- The graient of nonlinear least square unconstrained minimization IK
%  problem
% input:
%     goal    : The end effector goal
%     links   : A matrix of fixed rod-link vectors
%     angles  : A vector with joint angles
%     tool    : Position/vector (specified in homogenuous coordinates)
% output
%     p       : The gradient
if nargin < 3
    tool = [0.0;  0.0; 1.0];
end

%
% TODO Add your own code here
%
%  p = ???;

end
