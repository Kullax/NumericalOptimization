%rosenbrock function . This function should fill a matrix (value) with 
% values for the rosenbrock function the input vectors x and y are just the
% x and y values along the axes. your job is to make a nested forloop 
%(or something smarter if you are a matlab-wiz)which fills in all the values  

function value = rose(x,y)

%assume we get two columnvectors as input

X = size(x,1);
Y = size(y,1);

value = zeros(X,Y); % initialization of the return value 
%fill in all the values of the value matrix with the corresponding values
%of the rosenbrock function for the given point

% f(x) = 100(x_2^2-x_1^2)^2+(1+x_1)^2

for i=1:1:X
    for j=1:1:Y
       value(i,j) = 100*(y(j)-x(i)^2)^2+(1+x(i))^2;
    end
end

end