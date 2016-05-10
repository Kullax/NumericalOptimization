clear
fh = @(x, y) 11 -2*x-20*y + 21 * x.^2 + 10* y.^2

x = -6:0.1:6;
y = -6:.1:6;

[X,Y] = meshgrid(x,y);
Z = fh(X,Y);

figure
axis equal
hold on
contour(X,Y,Z,'ShowText','on')

for D=0.01:0.5:2
    %    x = fminsearch(@(x) 31*x^2 - 2* x + 11 ,0);
    x = fminsearch(@(x) 11-2*x-20*sqrt(D^2-x^2)+21*x^2+10*(D^2-x^2),0);
%    x = fminsearch(@(x) 40 / sqrt(D^2-x^2) + 42 *x - 40 *x -2, 0)
    y = sqrt(D^2-x^2)-1;
    plot(x, y,'*');
    draw_circle(0,-1,D);
end
% 0.5
clear
X_1=0;
X_2=0.5;
f_d = @(x,y) [-20*x*(y-x^2)-2*(1-x); 20*(y-x^2)];
f_dd = @(x,y) [-40*(y-3*x^2)+2 -40*x ; -40*x 20];
f_x = @(x,y) 10*(y-x^2)^2+(1-x)^2;

%fh = @(x, y) f_x(X_1,X_2)+ -2*x-20*y + 21 * x.^2 + 10* y.^2;
fh = @(x, y) 3.5 -2*x+10*y - 9 * x.^2 + 10* y.^2;

%fh = @(x, y) 11 -2*x-20*y + 21 * x.^2 + 10* y.^2;

x = -6:0.1:6;
y = -6:.1:6;

[X,Y] = meshgrid(x,y);
Z = fh(X,Y);

figure
axis equal
hold on
contour(X,Y,Z,'ShowText','on')

for D=0.01:0.5:2
    x = fminsearch(@(x) 3.5-2*x-20*sqrt(D^2-x^2)-9*x^2+10*(D^2-x^2),0);
%    x = fminsearch(@(x) 20 / sqrt(D^2-x^2) -18 *x - 20 *x -2, 0)
    y = sqrt(D^2-x^2)+0.5;
    plot(x, y,'*');
    draw_circle(0,0.5,D);
end

