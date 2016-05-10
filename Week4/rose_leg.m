%clear
x_k = [1.2;1.2];
rose_ = @(z) 100*(z(2) - z(1)^2)^2 + (1-z(1))^2;
rose_grad = @(z) [-400*(z(2)-z(1)^2)*z(1)-2*(1-z(1)); 200*(z(2)-z(1)^2)];
rose_hess = @(x) [1200*x(1)^2 - 400*x(2) + 2, -400*x(1); -400*x(1), 200];

hold on
%  x_plot = [-1.5:0.01:2]';
%  y_plot = [-1.5:0.01:2]';
%  value = rose(x_plot,y_plot);
%  axis equal;
  % plot the matrix as a contour
%  contour(x_plot,y_plot, value,100);
%  hold on

% Parameters
tol = 1e-6;
rhoLimit = [0.25 0.75];
deltaHat = 0.75;
eta = 0.25; % [0, 0.25)
% Initial values
delta = rand(1)*deltaHat;

IT = 0;
g = rose_grad(x_k);
while (norm(g) >tol & IT < 100)
     IT = IT +1;
     
     g = rose_grad(x_k);
     B = rose_hess(x_k);
     
     pB = - B^-1 * g; %B\g; %4.14
     pU = - (g'*g)/(g'*B*g) * g; %4.15

     if (norm(pB)<delta)
         p_k = pB
     elseif (norm(pU)>delta)
         p_k = delta* pU / norm(pU);
%      if (norm(pU)>delta)
%          tau = delta/norm(pU);
%      elseif (norm(pB)<delta)
%          tau = 2;
     else
         alpha = roots([norm(pB-pU)^2 sum(pB.*pU*2,1) norm(pU)^2-delta^2]);
         tau = alpha(alpha>=0)+1;
     
         if (tau>=0 && tau <=1) %4.16
             p_k = tau*pU;
         elseif (tau>1 && tau <=2)
             p_k = pU + (tau-1)*(pB - pU);
         end
     end
     
     m_k = @(p) (rose_(x_k)+g'*p+p'*B*p/2); %4.3
     
     xTemp = x_k+p_k;

     rho = (rose_(x_k) - rose_(xTemp))/(m_k([0 0]') - m_k(p_k)); %4.4
     if (rho < rhoLimit(1))
         delta = delta/4;
     elseif (rho>rhoLimit(2) && norm(p_k)==delta)
         delta = min(delta*2,deltaHat);
     end
     
     if (rho > eta)
         line([x_k(2) xTemp(2)],[x_k(1) xTemp(1)],'Color','k','LineWidth',2);
         plot(xTemp(2),xTemp(1),'kX')
         x_k = xTemp;
     end
    
end
hold off


