function [ J ] = jacobian( links, angles, tool )
% JACOBIAN -- The jacobian function
% input:
%     links   : A matrix of fixed rod-link vectors
%     angles : A vector with joint angles
%     tool      : Position/vector (specified in homogenuous coordinates)
% output
%     J : The Jacobian matrix
if nargin < 3
    tool = [0.0;  0.0; 1.0];
end

e = F(links, angles);
N = length(angles);  % Number of joints/links in chain
J = zeros(N,3);
for i=0:1:N
    if(i == 0)
        % P_-1
        P(:,1) = [0 0 0];
        a = 0;
    else
      %p = ;
      P(:,i)
      [cos(a), -sin(a);sin(a), cos(a)]*links(:,i)
      tmp = [cos(a), -sin(a);sin(a), cos(a)]*links(:,i);
      tmp(3) = 0;
      P(:,i+1) = P(:,i) + tmp;
      J(:,i) = [0 -1 0; 1 0 0; 0 0 0] * (e-P(:,i+1));
      a = a + angles(i);
    end
end
P
end
