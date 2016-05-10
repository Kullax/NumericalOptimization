function [ angles, error_m, time_m ] = ik_steepest_descent( goal, links, angles, line_search, tool)%, Pro, lower, upper, tool)
start = tic;
if nargin < 8
    tool = [0.0;  0.0; 1.0];
end

iter     = 1;
max_iter = 100;
tol      = 0.01;
error_m = zeros(1,max_iter)-1;
time_m = zeros(1,max_iter)-1;
e      = F(links,angles,tool);    
r      = e-goal;
error      = 0.5*norm(r)^2;
error_m(1) = error;
time_m(1) = 0;
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
    [a, angles] = line_search(goal, links, angles, @F, p , -p, tool);% Pro, lower, upper,tool);
    iter   = iter + 1;
    error_m(iter) = error;
    time_m(iter) = toc(start);
end
    error_m = error_m(1:min(iter, max_iter));
    time_m = time_m(1:min(iter, max_iter));
end