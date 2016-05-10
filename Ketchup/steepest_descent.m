function [ tau, angles_new ] = steepest_descent(goal, links, angles, F, p, gradF, P, lower, upper, tool)
    % steepest
    d = @(x) -rose_grad(x) / norm(rose_grad(x));

    c        = 0.2; % Sufficient descrease constant
    beta     = 0.9;    % Step-reduction parameter
    tau     = 1.0;
    angles_new = angles;

    x_k = [1.2 ; 1.2]; 
    x_old = [0,0];
    x_new = x_k;
    precision = 10^-7;
    IT = 0;
    e      = F(links,angles,tool);    
    r      = e-goal;
    J      = jacobian( links, angles_new, tool);
    p      = - J'*(e-goal);

    while norm(p) > precision & IT < 1000%abs(x_new(1) - x_old(1) + x_new(2) - x_old(2)) > precision & IT < 1000
       tau = 1;
       while (rose_(x_new + tau * d(x_new)) > rose_(x_new) + tau * c * rose_grad([x_new ; d(x_new)]))
           tau = beta * tau;
       end
       IT = IT + 1;
       x_old = x_new;
       x_new = x_old + tau *c* d(x_old);
       line([x_old(2) x_new(2)],[x_old(1) x_new(1)],'Color','r','LineWidth',2);
       plot(x_new(2),x_new(1),'rX')
    end
    % hold off
    
    

% iter     = 1;
% max_iter = 10;
% tol      = 0.00001;
% 
% tau     = 1.0;
% angles_new = angles;
% dif = 0;
% 
% e      = F(links,angles,tool);    
% r      = e-goal;
% f = 0.5*norm(r)^2;
% f_new      = f;
% 
% while (f + c*gradF'*dif <= f_new & iter < max_iter)    
%         
%     tau = beta*tau;
%     angles_new = angles + tau * p;
%     angles_new = P( angles_new, lower, upper);
%     dif = angles_new - angles;
%     
%     e      = F(links,angles_new,tool);    
%     r      = e-goal;
%     f = 0.5*norm(r)^2;
% 
%     iter   = iter + 1;
% end

end
