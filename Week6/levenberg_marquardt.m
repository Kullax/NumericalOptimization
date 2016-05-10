function [ angles ] = levenberg_marquardt( goal, links, angles, tool )

if nargin < 4
    tool = [0.0;  0.0; 1.0];
end
max_iter = 10;
tol      = 0.01;
e        = F(links,angles,tool);
tst      = norm(goal-e);
x = 0;
delta = 0.1;
delta_up = 2;
delta_down = 20;
e        = F(links,angles,tool);
r = goal - e;

iter = 0;
while ( tst > tol && iter < max_iter )
%    J = Q * [R ; 0]
    J = jacobian( links, angles, tool);
    % Approximate Hessian
    B = J' * J;
    g = J' * J + delta * eye;
    d_C = J' * r;
    C = 0.5 * r.^2;
    x_new = x - g' * d_C;
    r_new = goal - F(links, angles, tool);
    C_new = 0.5 * r_new.^2;
    if C_new  < C
        x = x_new;
        r = r_new;
        delta = delta * delta_down;
        delta_down
    else
        delta = delta / delta_up;
        delta_up
        C_new
        C
    end
    
%     e = F(links,angles,tool);
%     r = e - goal;
%     angles = angles + pinv(J)*(goal-e);
%     iter = iter + 1;
    iter = iter + 1;
end
%angles = 0
