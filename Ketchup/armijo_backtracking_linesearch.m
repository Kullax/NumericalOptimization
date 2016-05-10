function [ tau, angles_new ] = armijo_backtracking_linesearch(goal, links, angles, F, p, gradF, lower, upper, tool)
iter     = 1;
max_iter = 10;
tol      = 0.00001;
c        = 0.0001; % Sufficient descrease constant
beta     = 0.9;    % Step-reduction parameter
tau     = 1.0;
angles_new = angles;
dif = 0;

e      = F(links,angles,tool);    
r      = e-goal;
f = 0.5*norm(r)^2;
f_new      = f;

while (f + c*gradF'*dif <= f_new & iter < max_iter)    
        
    tau = beta*tau;
    angles_new = angles + tau * p;
%    angles_new = P( angles_new, lower, upper);
    dif = angles_new - angles;
    
    e      = F(links,angles_new,tool);    
    r      = e-goal;
    f = 0.5*norm(r)^2;

    iter   = iter + 1;
end

end