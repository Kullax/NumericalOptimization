function [ angles, error_m ] = ik_steepest_descent( goal, links, angles, line_search, Pro, lower, upper, tool)

if nargin < 8
    tool = [0.0;  0.0; 1.0];
end

iter     = 1;
max_iter = 100;
tol      = 0.00001;
error_m = zeros(1,max_iter-1)-1;

old_error      = 999999;
while ( old_error > tol && iter < max_iter)    
    e      = F(links,angles,tool);    
    r      = e-goal;
    error      = 0.5*norm(r)^2;
    if error == old_error
       break
    elseif error > old_error
        break
    else
        old_error = error;
    end
    J      = jacobian( links, angles, tool);
    p      = - J'*(e-goal);
    [a, angles] = line_search(goal, links, angles, @F, p , -p, Pro, lower, upper,tool);
    error_m(iter) = error;
    iter   = iter + 1;
end

end