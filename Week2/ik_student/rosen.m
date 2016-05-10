function [f,GRAD,HESS] = rosen(z)
% Calculate objective f
f = 100*(z(2) - z(1)^2)^2 + (1-z(1))^2;

if nargout > 1 % gradient required
    GRAD = [-400*(z(2)-z(1)^2)*z(1)-2*(1-z(1));
        200*(z(2)-z(1)^2)];
end

if nargout > 2 % hessian required
   HESS = [-400*(z(2) -3*z(1)^2) + 2, -400*z(1); ... 
         -400*z(1), 200];
end