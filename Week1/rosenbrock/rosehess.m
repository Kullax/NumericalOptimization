% the gradient of the rosenbrock function
function retur = rosehess(x,y)

%return a  2 X 2 matrix which gives the second derivative of the rosenbrock
%with regard to x and y respectively
% ive supplied a template where each element is just set to zero
%the semicolon is for showing that we move to the next row 
%the ... are for showing matlab that a new line continues the input

%retur = [0 ,  0  ; ...  
%         0 ,  0 ];

retur = [-400*(y -3*x^2) + 2, -400*x; ... 
         -400*x, 200];
end