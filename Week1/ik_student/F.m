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
tmp=[0;0];

N = length(angles);  % Number of joints/links in chain
ang = cumsum(angles);
% First angle is "ignored" as we move normally the first angle.
ang = [0;ang];
for i=N:-1:1
    R = [cos(ang(i)), -sin(ang(i)); sin(ang(i)), cos(ang(i))];    
    tmp = tmp + R * [links(1,i); links(2,i)];
end

e(1:2) = tmp;

if( ~isequal(e(3),0) )
    e = e./e(3);
end

end

