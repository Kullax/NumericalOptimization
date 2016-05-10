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

N = length(angles);  % Number of joints/links in chain
J = zeros(N,3);
for i=N:-1:1
    
    % Compute position of end-effector wrt. i'th joint frame
    sub_links  = links(:,i+1:N);
    sub_angles = angles(i+1:N);
    e_i        = F(sub_links,sub_angles, tool);
    
    % Compute differential of end-effector wrt. i'th frame
    angle = angles(i);
    ca    = cos( angle );
    sa    = sin( angle );
    dR    = [ -sa  -ca   0;...
             ca  -sa   0;...
              0    0   0];
          
    de_i  = dR*e_i;
    
    % Transform differential from i'th frame to root frame and store in
    % Jacobian
    sub_links  = links(:,1:i-1);
    sub_angles = angles(1:i-1);
    
    J(:,i) = F(sub_links,sub_angles,de_i);
end
end
