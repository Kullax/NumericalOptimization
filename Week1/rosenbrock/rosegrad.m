% the gradient of the rosenbrock function
function retur = rosegrad(x,y)

%return a vector of 2 elements which gives the derivative of the rosenbrock
%with regard to x and y respectively
% I have supplied a template where each element is just set to zero
retur = [-400*x*(y-x^2) - (2-2*x), 200*(y-x^2)];

end