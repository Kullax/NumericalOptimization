fun = @rosen;
x0 = [-5,50];
options = optimoptions('fminunc','Hessian','on', 'GradObj','on');
[x,g,h] = fminunc(fun,x0,options)