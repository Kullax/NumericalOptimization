function [ angles, error_m, time_m ] = BFGS( goal, links, angles, tool )
start = tic;
%Should be superlinear

if nargin < 4
    tool = [0.0;  0.0; 1.0];
end

iter     = 1;
max_iter = 200;
error_m = zeros(1,max_iter)-1;
time_m = zeros(1,max_iter)-1;
tol      = 0.1;
e        = F(links,angles,tool);

J      = jacobian( links, angles, tool);
B = J'*J;
p_new = J'*(e-goal);
tst      = norm(p_new);
c = 0.5;
T = 0.01;
error_m(iter) = 0.5*norm(e-goal)^2;
time_m(iter) = 0;

while ( tst > tol && iter < max_iter )
    p_k =  -B * p_new;
    t = 1;
    while F(links, angles + t * p_k, tool) < (F(links, angles, tool) + t * c * p_new'* p_k)
     t = T * t;
    end
    p_old = p_new;
    new_angles = angles + t * p_k;
    e        = F(links,new_angles,tool);
    J      = jacobian( links, new_angles, tool);

    p_new = J'*(e-goal);
    s = new_angles - angles;
   % if isnan(s)
   %    break 
   % end
    y = p_new - p_old;
%    p1 = (B * (s * s') * B) / (s' * B * s);
%    p2 = (y * y')/(y' * s);
%    B = B - p1 + p2 ;
    ro = 1/(y' * s);
    B = (eye(3) - ro * s * y') * B * (eye(3) - ro * y * s') + ro * (s * s');
    angles = new_angles;
    tst    = norm(p_new);
    iter   = iter + 1;
    error_m(iter) = 0.5*norm(e-goal)^2;
    time_m(iter) = toc(start);
end
    error_m = error_m(1:min(iter, max_iter));
    time_m = time_m(1:min(iter, max_iter));

%iter
end