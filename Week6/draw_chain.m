function draw_chain( links, angles, col )
% DRAW_CHAIN Draw an inverse kinematic chain
%   Given an initial configuration of a inverse kinematics chain
%   with a root fixed at the origin this function draws
%   an illustration of the pose of the chain.
% input
%     links  : A matrix of fixed rod-link vectors
%     angles : A vector with joint angles
N = length(angles);  % Number of joints/links in chain
x = 0;
y = 0;
for i=1:N
    sub_links  = links(:,1:i);
    sub_angles = angles(1:i);
    C = F(sub_links,sub_angles, [0.0;  0.0; 1.0]);
    
    new_x = C(1);
    new_y = C(2);
    line([x new_x],[y new_y],'Color',col,'LineWidth',2);
    x = new_x;
    y = new_y;
end
end
