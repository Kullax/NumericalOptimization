function [ e ] = F( links, angles, tool )
% F -- The forward kinematics function, computes end-effector position.
% input:
%     links   - A matrix of fixed rod-link vectors. 
%     angles  - A vector with joint angles.
%     tool    - Tool position wrt. end effector frame (specified in homogenuous coordinates).
% output:
%     e      - The end-effector position/vector given in root frame
if nargin < 3
  e = [0.0;  0.0; 1.0];
else
  e = tool;
end

N = length(angles);  % Number of joints/links in chain

for i=N:-1:1
    
    x     = links(1,i);
    y     = links(2,i);
    angle = angles(i);
    ca    = cos( angle );
    sa    = sin( angle );
    
    % Coordinate transformation matrix
    T     = [ ca -sa  x;...
              sa  ca  y;...
               0   0  1 ];
           
    e     = T*e;
end

if( ~isequal(e(3),0) )
    e = e./e(3);
end

end

