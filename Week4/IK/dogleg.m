function [ angles,error_m,time_m ] = dogleg( goal, links, angles, tool )
start = tic;
if nargin < 4
    tool = [0.0;  0.0; 1.0];
end

iter     = 1;
max_iter = 100;
error_m = zeros(1,max_iter)-1;
time_m = zeros(1,max_iter)-1;

tol      = 0.01;
rhoLimit = [0.25 0.75];
deltaHat = 0.75;
eta = 0.25;
delta = 0.2;
f = @(e) (0.5*norm(e)^2) - goal;
e      = F(links,angles,tool); 
%J      = jacobian( links, angles, tool);
%g = J'*(e-goal);
tst      = norm(goal-e);
old_tol = 99;
error_m(1) = 0.5*norm(e-goal)^2;
time_m(1) = 0;
while ( tst > tol && iter < max_iter && old_tol > tst)
old_tol = tst;

%while (norm(g) > tol && iter < max_iter )
    J = jacobian( links, angles, tool);
    g = J'*(e-goal);
    B = J' * J;% +??? (g-F(theta))'J_i;
    pB = - pinv(B) * g; %- B\g;% - delta * g ./ norm(g); %- B^-1 * g; %B\g; %4.14
    pU = - (g' * g) / (g' * B * g) * g;%-g*(dot(g',g)/dot(g',B*g));%- (g'*g)/(g'*B*g) * g; %4.15
%    if any(~isfinite(pB))
%        p_k = pU;
  %  else
         if (norm(pB)<delta)
             p_k = pB;
         %    disp('full step')

         elseif (norm(pU)>delta)
             p_k = delta* pU / norm(pU);
        %     disp('unconstrained minimiser along the steepest descent direction')

         else
             alpha = roots([norm(pB-pU)^2 sum(pB.*pU*2,1) norm(pU)^2-delta^2]);
             tau = alpha(alpha>=0)+1;

             if (tau>=0 && tau <=1) %4.16
                 p_k = tau*pU;
                 % Will never enter this
             elseif (tau>1 && tau <=2)
                 p_k = pU + (tau-1)*(pB - pU);
             end
         end
   % end
     angles_new = angles + p_k;
     e_new = F(links,angles_new, tool);
     m_k = @(p) (angles + g'*p+p'*B*p/2);
     %rho = (angles - angles_new) ./ (m_k([0 0 0]') - m_k(p_k));
     rho = (f(e) - f(e_new)) ./ (m_k([0 0 0]') - m_k(p_k));
     if (sum(gt(rhoLimit(1) , rho)))
         delta = delta/4;
     elseif (sum(gt(rho,rhoLimit(2))) && norm(p_k)==delta)
         delta = min(delta*2,deltaHat);
     end
     if (sum(gt(rho,eta)))
        angles = angles_new;
     end

    e      = F(links,angles,tool);
    tst      = norm(goal-e);
    iter   = iter + 1;
    error_m(iter) = 0.5*norm(e-goal)^2;
    time_m(iter) = toc(start);
end
    error_m = error_m(1:min(iter, max_iter));
    time_m = time_m(1:min(iter, max_iter));

%iter
end
