clear
rose_ = @(z) 100*(z(2) - z(1)^2)^2 + (1-z(1))^2;
rose_grad = @(z) [-400*(z(2)-z(1)^2)*z(1)-2*(1-z(1)); 200*(z(2)-z(1)^2)];
rose_hess = @(x) [1200*x(1)^2 - 400*x(2) + 2, -400*x(1); ...
    -400*x(1), 200];

 x_plot = [.9:0.01:1.5]';
 y_plot = [.9:0.01:1.5]';
 value = rose(x_plot,y_plot);
 axis equal;
 % plot the matrix as a contour
 contour(x_plot,y_plot, value,100);
 hold on

% x = -6:0.1:6;
% y = -6:.1:6;
% 
% [X,Y] = meshgrid(x,y);
% Z = rose(X,Y);
% 
% figure
% axis equal
% hold on
% contour(X,Y,Z,'ShowText','on')

%rose_hess = @(z) [-400*(z(2) -3*z(1)^2) + 2, -400*z(1); ... 
%     -400*z(1), 200];

% steepest
d = @(x) -rose_grad(x) / norm(rose_grad(x));

T = 0.8;
c = 0.2;
x_k = [1.2 ; 1.2]; 
 x_old = [0,0];
 x_new = x_k;
 precision = 10^-7;
 IT = 0;
 t = 1;
 while norm(rose_grad(x_new)) > precision & IT < 1000%abs(x_new(1) - x_old(1) + x_new(2) - x_old(2)) > precision & IT < 1000
    t = 1;
    while (rose_(x_new + t * d(x_new)) > rose_(x_new) + t * c * rose_grad([x_new ; d(x_new)]))
        t = T * t;
    end
    IT = IT + 1;
    x_old = x_new;
    x_new = x_old + t *c* d(x_old);
    line([x_old(2) x_new(2)],[x_old(1) x_new(1)],'Color','r','LineWidth',2);
    plot(x_new(2),x_new(1),'rX')
end
% hold off

T = 0.4;
%c = rand/2;
c = 0.471;
x_k = [1.2 ; 1.2];
% newton
d = @(x) -(rose_hess(x)^-1 * rose_grad(x));
k = 0;
k_max = 1000;
%data = 1
step = 1
while abs(rose_grad(x_k))>10^-7 & k < k_max
   t = 1;
   while (rose_(x_k + d(x_k)) > rose_(x_k) + t * c * rose_grad([x_k ; d(x_k)]))
        t = T * t;
        if t < 10^-7
            break
        end
   end
   step = t;
%   data = [data step];
   xTemp = x_k + step * d(x_k);
   k = k + 1
   line([x_k(2) xTemp(2)],[x_k(1) xTemp(1)],'Color','g','LineWidth',2);
   plot(xTemp(2),xTemp(1),'gX')
    x_k = xTemp;
end

%plot(data)
%plot(alpha, data)
% 
% t = 1;
% new_f = rose(x + d(x));
% while new_f  > rose(x) + t*delta_f
%      t = T * t
%      new_f = rose(x + t * d(x));
% end

% WIKIPEDIA MADE ME DO IT
% m = @(x) d(x)'*rose_grad(x);
% a = 1;
% t = -c * m(x);
% j = 0;
% while rose(x) - rose(x+a*d(x)) < a * t & j < 200
%     j = j + 1;
%     a = T * a;
% end
% a

% x = [1.2 ; 1.2];
% d = @(x) -(rose_hess(x)^-1 * rose_grad(x));
% while norm(d(x)) > 0.01
%     x = x + d(x);
% end
% d(x)


%fplot(fh,[0,8])
%low_x = 999;
%high_x = 0;
%gradient = @(z) 2*(z-3);
% THIS IS THE FUN VALUE!
%steplength = 0.9 % must be stickly less than 1.

% Initial guess, if we guess 3 we dont even do the loop.
%guess = 0;
% Gradient, used to determine direction.
%g = gradient(guess)
% Number of iterations, stops after 200.
%it = 0;
%while g ~= 0 && it < 200
    % The next guess is simply result of old guess affected by the
    % steplength and gradient.
    % Note - Steplength is fixed, better version of algorithm should adjust
    % steplength.
%    g = guess - steplength * gradient(guess);
    % Draw a line from current guess to next iteration
%    line([guess, g],[fh(guess), fh(g)],'Color','b','LineWidth',2);
    % Prepare next iteration.
%    guess = g;
%    it = it + 1
%end


%function [f,GRAD,HESS] = rosen(z)
% Calculate objective f
%f = 100*(z(2) - z(1)^2)^2 + (1-z(1))^2;

%if nargout > 1 % gradient required
%    GRAD = [-400*(z(2)-z(1)^2)*z(1)-2*(1-z(1));
%        200*(z(2)-z(1)^2)];
%end

%if nargout > 2 % hessian required
%   HESS = [-400*(z(2) -3*z(1)^2) + 2, -400*z(1); ... 
%         -400*z(1), 200];
%end

% this script runs the rosenbrock function plotter on an instance going
% from -1 to 2 with an interval of 0.1 

%Notice a vector is defined this is good to remember
%notice also the ' after the square brackets which transpose the vector so
%we have column vectors 
% 
% X = [-2.01:0.05:2.01]';
% Y = [-2.01:0.05:2.01]';
% 
% value = rose(X,Y);
% figure(2)
% axis equal;
% h = surf(X,Y,value);
% hold on
% %plot(data, 'color','r','linewidth',3)
% I = 0
% for N=1:1:length(data)-1
%     if(I == 0)
%         I = 1
%     line([data(:,N); rose_(data(:,N))], [data(:,N+1); rose_(data(:,N+1))], 'color','r','linewidth',2)        
%     else
%             line(data(:,N), data(:,N+1), 'color','b','linewidth',2)
% I = 0
%     end
% end
% %plot(1:50,1:50,'color','r','linewidth',3)
%line([N-steplength, q],[fh(N-steplength), fh(q)],'Color','b','LineWidth',2);